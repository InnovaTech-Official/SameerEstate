<?php
require_once '../../../includes/connection.php';

/**
 * Fetches a customer by ID
 * 
 * @param PDO $pdo Database connection
 * @param int $id Customer ID to fetch
 * @return array Customer data or error message
 */
function fetchCustomerById($pdo, $id) {
    try {
        $stmt = $pdo->prepare("
            SELECT c.*, 
                l.name as lead_name,
                ct.name as city_name,
                a.name as area_name,
                cs.name as cast_name,
                r.name as religion_name,
                ms.name as marital_status_name,
                co.name as country_name,
                o.name as occupation_name
            FROM customers c
            LEFT JOIN leads l ON c.lead_id = l.id
            LEFT JOIN cities ct ON c.city_id = ct.id
            LEFT JOIN areas a ON c.area_id = a.id
            LEFT JOIN casts cs ON c.cast_id = cs.id
            LEFT JOIN religions r ON c.religion_id = r.id
            LEFT JOIN marital_statuses ms ON c.marital_status_id = ms.id
            LEFT JOIN countries co ON c.country_id = co.id
            LEFT JOIN occupations o ON c.occupation_id = o.id
            WHERE c.id = :id
        ");
        
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        $customer = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$customer) {
            return [
                'success' => false,
                'error' => 'Customer not found'
            ];
        }
        
        // Get customer images paths
        $stmt = $pdo->prepare("
            SELECT file_type, file_path 
            FROM customer_files 
            WHERE customer_id = :customer_id
        ");
        
        $stmt->bindParam(':customer_id', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        $files = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $customer['files'] = [];
        
        foreach ($files as $file) {
            $customer['files'][$file['file_type']] = $file['file_path'];
        }
        
        return [
            'success' => true,
            'data' => $customer
        ];
    } catch (PDOException $e) {
        error_log("Error fetching customer: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ];
    }
}

/**
 * Fetches all customers with optional filtering and pagination
 * 
 * @param PDO $pdo Database connection
 * @param array $filters Optional filters for the query
 * @param int $page Page number for pagination
 * @param int $limit Items per page
 * @return array List of customers or error message
 */
function fetchCustomers($pdo, $filters = [], $page = 1, $limit = 10) {
    try {
        $whereClause = [];
        $params = [];
        
        // Build where clause based on filters
        if (!empty($filters['name'])) {
            $whereClause[] = "c.name LIKE :name";
            $params[':name'] = '%' . $filters['name'] . '%';
        }
        
        if (!empty($filters['cell'])) {
            $whereClause[] = "c.cell LIKE :cell";
            $params[':cell'] = '%' . $filters['cell'] . '%';
        }
        
        if (!empty($filters['cnic'])) {
            $whereClause[] = "c.cnic LIKE :cnic";
            $params[':cnic'] = '%' . $filters['cnic'] . '%';
        }
        
        if (!empty($filters['city_id'])) {
            $whereClause[] = "c.city_id = :city_id";
            $params[':city_id'] = $filters['city_id'];
        }
        
        if (!empty($filters['area_id'])) {
            $whereClause[] = "c.area_id = :area_id";
            $params[':area_id'] = $filters['area_id'];
        }

        if (!empty($filters['lead_id'])) {
            $whereClause[] = "c.lead_id = :lead_id";
            $params[':lead_id'] = $filters['lead_id'];
        }
        
        // Calculate offset for pagination
        $offset = ($page - 1) * $limit;
        
        // Construct the WHERE part of the query
        $whereStr = '';
        if (!empty($whereClause)) {
            $whereStr = 'WHERE ' . implode(' AND ', $whereClause);
        }
        
        // Count total records for pagination
        $countQuery = "SELECT COUNT(*) FROM customers c $whereStr";
        $countStmt = $pdo->prepare($countQuery);
        foreach ($params as $key => $value) {
            $countStmt->bindValue($key, $value);
        }
        $countStmt->execute();
        $totalRecords = $countStmt->fetchColumn();
        
        // Main query to fetch customers
        $query = "
            SELECT c.*, 
                l.name as lead_name,
                ct.name as city_name,
                a.name as area_name
            FROM customers c
            LEFT JOIN leads l ON c.lead_id = l.id
            LEFT JOIN cities ct ON c.city_id = ct.id
            LEFT JOIN areas a ON c.area_id = a.id
            $whereStr
            ORDER BY c.created_at DESC
            LIMIT :limit OFFSET :offset
        ";
        
        $stmt = $pdo->prepare($query);
        
        // Bind parameters
        foreach ($params as $key => $value) {
            $stmt->bindValue($key, $value);
        }
        
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
        
        $stmt->execute();
        $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Calculate pagination info
        $totalPages = ceil($totalRecords / $limit);
        
        return [
            'success' => true,
            'data' => [
                'customers' => $customers,
                'pagination' => [
                    'total' => $totalRecords,
                    'per_page' => $limit,
                    'current_page' => $page,
                    'last_page' => $totalPages
                ]
            ]
        ];
    } catch (PDOException $e) {
        error_log("Error fetching customers: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ];
    }
}

/**
 * Check if a customer with the given field and value exists
 * 
 * @param PDO $pdo Database connection
 * @param string $field Field to check
 * @param mixed $value Value to check
 * @param int|null $excludeId Optional customer ID to exclude from check
 * @return bool True if exists, false otherwise
 */
function customerExists($pdo, $field, $value, $excludeId = null) {
    try {
        if ($field === 'cell') {
            // For cell numbers, check in the cell_no table
            $sql = "SELECT COUNT(*) FROM cell_no WHERE cell_no = :value";
            if ($excludeId) {
                $sql .= " AND customer_id != :exclude_id";
            }
            
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':value', $value);
            
            if ($excludeId) {
                $stmt->bindParam(':exclude_id', $excludeId);
            }
        } else {
            // For other fields, check in the customers table
            $sql = "SELECT COUNT(*) FROM customers WHERE $field = :value";
            if ($excludeId) {
                $sql .= " AND id != :exclude_id";
            }
            
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':value', $value);
            
            if ($excludeId) {
                $stmt->bindParam(':exclude_id', $excludeId);
            }
        }
        
        $stmt->execute();
        $count = $stmt->fetchColumn();
        
        return $count > 0;
    } catch (PDOException $e) {
        error_log("Error checking if customer exists: " . $e->getMessage());
        return false;
    }
}

/**
 * Handle API request for customer data
 */
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        // Create database connection
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        // Check if requesting lookup data
        if (isset($_GET['table'])) {
            $table = $_GET['table'];
            $allowedTables = ['leads', 'cities', 'areas', 'casts', 'religions', 'marital_statuses', 'countries', 'occupations', 'bank'];
            
            if (in_array($table, $allowedTables)) {
                // Basic query
                $query = "SELECT id, name FROM $table ORDER BY name ASC";
                $params = [];
                
                // Handle special cases
                if ($table === 'occupations') {
                    $query = "SELECT id, name FROM $table ORDER BY name ASC";
                }
                
                // Filter cities by country if requested
                if ($table === 'cities' && isset($_GET['country_id']) && !empty($_GET['country_id'])) {
                    $query = "SELECT id, name FROM cities WHERE country_id = :country_id ORDER BY name ASC";
                    $params[':country_id'] = $_GET['country_id'];
                }
                
                // Filter areas by city if requested
                if ($table === 'areas' && isset($_GET['city_id']) && !empty($_GET['city_id'])) {
                    $query = "SELECT id, name FROM areas WHERE city_id = :city_id ORDER BY name ASC";
                    $params[':city_id'] = $_GET['city_id'];
                }
                
                $stmt = $pdo->prepare($query);
                
                // Bind parameters if any
                foreach ($params as $key => $value) {
                    $stmt->bindValue($key, $value);
                }
                
                $stmt->execute();
                $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
                
                header('Content-Type: application/json');
                echo json_encode([
                    'success' => true,
                    'data' => $data
                ]);
                exit;
            } else {
                header('Content-Type: application/json');
                echo json_encode([
                    'success' => false,
                    'error' => 'Invalid table name'
                ]);
                exit;
            }
        }
        
        // Check if checking for uniqueness
        if (isset($_POST['field']) && isset($_POST['value'])) {
            $field = $_POST['field'];
            $value = $_POST['value'];
            $excludeId = isset($_POST['exclude_id']) ? intval($_POST['exclude_id']) : null;
            
            $exists = customerExists($pdo, $field, $value, $excludeId);
            
            header('Content-Type: application/json');
            echo json_encode([
                'success' => true,
                'exists' => $exists
            ]);
            exit;
        }
        
        // Check if requesting a specific customer
        if (isset($_GET['id']) && is_numeric($_GET['id'])) {
            $result = fetchCustomerById($pdo, intval($_GET['id']));
        } else {
            // Prepare filters from GET parameters
            $filters = [];
            $validFilters = ['name', 'cell', 'cnic', 'city_id', 'area_id', 'lead_id'];
            
            foreach ($validFilters as $filter) {
                if (isset($_GET[$filter]) && !empty($_GET[$filter])) {
                    $filters[$filter] = $_GET[$filter];
                }
            }
            
            // Get pagination parameters
            $page = isset($_GET['page']) && is_numeric($_GET['page']) ? intval($_GET['page']) : 1;
            $limit = isset($_GET['limit']) && is_numeric($_GET['limit']) ? intval($_GET['limit']) : 10;
            
            // Fetch customers with filters and pagination
            $result = fetchCustomers($pdo, $filters, $page, $limit);
        }
        
        // Return result as JSON
        header('Content-Type: application/json');
        echo json_encode($result);
    } catch (Exception $e) {
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'error' => 'Server error: ' . $e->getMessage()
        ]);
    }
}
?>