<?php
require_once '../../../includes/connection.php';

/**
 * Add a new lookup item
 * 
 * @param PDO $pdo Database connection
 * @param string $table Table name (e.g., 'leads', 'cities', 'religions')
 * @param string $name Name of the new item
 * @param int|null $parentId Optional parent ID for hierarchical data
 * @return array Success status, message, and new item details
 */
function addLookupItem($pdo, $table, $name, $parentId = null) {
    try {
        // Check if the table name is valid (only alphanumeric and underscores)
        if (!preg_match('/^[a-zA-Z0-9_]+$/', $table)) {
            return [
                'success' => false,
                'error' => 'Invalid table name'
            ];
        }
        
        // Check if an item with the same name already exists in the table
        $checkStmt = $pdo->prepare("SELECT id FROM {$table} WHERE name = :name");
        $checkStmt->bindParam(':name', $name, PDO::PARAM_STR);
        $checkStmt->execute();
        
        if ($checkStmt->fetch()) {
            return [
                'success' => false,
                'error' => 'An item with this name already exists'
            ];
        }
        
        // Check if the table has updated_at column
        $hasUpdatedAtColumn = false;
        $columnCheckStmt = $pdo->prepare("SHOW COLUMNS FROM $table LIKE 'updated_at'");
        $columnCheckStmt->execute();
        if ($columnCheckStmt->rowCount() > 0) {
            $hasUpdatedAtColumn = true;
        }
        
        // Check if the table has created_at column
        $hasCreatedAtColumn = false;
        $columnCheckStmt = $pdo->prepare("SHOW COLUMNS FROM $table LIKE 'created_at'");
        $columnCheckStmt->execute();
        if ($columnCheckStmt->rowCount() > 0) {
            $hasCreatedAtColumn = true;
        }
        
        // Prepare SQL based on table structure
        if ($parentId && $table === 'areas') {
            // Special case for areas which have city_id as parent
            if ($hasCreatedAtColumn && $hasUpdatedAtColumn) {
                $sql = "INSERT INTO $table (name, city_id, created_at, updated_at) VALUES (:name, :parent_id, NOW(), NOW())";
            } elseif ($hasCreatedAtColumn) {
                $sql = "INSERT INTO $table (name, city_id, created_at) VALUES (:name, :parent_id, NOW())";
            } else {
                $sql = "INSERT INTO $table (name, city_id) VALUES (:name, :parent_id)";
            }
        } elseif ($parentId && $table === 'cities') {
            // Special case for cities which have country_id as parent
            if ($hasCreatedAtColumn && $hasUpdatedAtColumn) {
                $sql = "INSERT INTO $table (name, country_id, created_at, updated_at) VALUES (:name, :parent_id, NOW(), NOW())";
            } elseif ($hasCreatedAtColumn) {
                $sql = "INSERT INTO $table (name, country_id, created_at) VALUES (:name, :parent_id, NOW())";
            } else {
                $sql = "INSERT INTO $table (name, country_id) VALUES (:name, :parent_id)";
            }
        } else {
            // Standard case for other tables
            if ($hasCreatedAtColumn && $hasUpdatedAtColumn) {
                $sql = "INSERT INTO $table (name, created_at, updated_at) VALUES (:name, NOW(), NOW())";
            } elseif ($hasCreatedAtColumn) {
                $sql = "INSERT INTO $table (name, created_at) VALUES (:name, NOW())";
            } else {
                $sql = "INSERT INTO $table (name) VALUES (:name)";
            }
        }
        
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':name', $name);
        
        if ($parentId && ($table === 'areas' || $table === 'cities')) {
            $stmt->bindParam(':parent_id', $parentId);
        }
        
        $stmt->execute();
        $id = $pdo->lastInsertId();
        
        return [
            'success' => true,
            'id' => $id,
            'name' => $name
        ];
    } catch (PDOException $e) {
        error_log("Error adding lookup item: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ];
    } catch (Exception $e) {
        error_log("General error: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Error: ' . $e->getMessage()
        ];
    }
}

/**
 * Check if the table has a parent_id column
 * 
 * @param string $table The table name
 * @return bool True if the table has a parent_id column, false otherwise
 */
function hasParentColumn($table) {
    // Tables that have a parent_id column for hierarchical data
    $hierarchicalTables = [
        'areas', // Areas may have parent areas
        'cities', // Cities may belong to regions
        'occupations' // Occupations may have broader categories
    ];
    
    return in_array($table, $hierarchicalTables);
}

/**
 * Handle POST requests to this script
 */
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Set content type to JSON
    header('Content-Type: application/json');
    
    try {
        // Create database connection
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        // Check required parameters
        if (!isset($_POST['table']) || !isset($_POST['name']) || empty($_POST['name'])) {
            throw new Exception('Missing required parameters: table and name');
        }
        
        $table = $_POST['table'];
        $name = $_POST['name'];
        $parentId = isset($_POST['parent_id']) && !empty($_POST['parent_id']) ? intval($_POST['parent_id']) : null;
        
        // Add the new lookup item
        $result = addLookupItem($pdo, $table, $name, $parentId);
        
        // Return JSON response
        echo json_encode($result);
    } catch (Exception $e) {
        echo json_encode([
            'success' => false,
            'error' => 'Server error: ' . $e->getMessage()
        ]);
    }
}
?>