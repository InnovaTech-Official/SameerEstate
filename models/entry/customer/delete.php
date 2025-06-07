<?php
require_once '../../../includes/connection.php';

/**
 * Delete a lookup item by ID
 * 
 * @param PDO $pdo Database connection
 * @param string $table Table name (e.g., 'leads', 'cities', 'religions')
 * @param int $id Item ID to delete
 * @param bool $cascade Whether to delete related records
 * @return array Success status and message
 */
function deleteLookupItem($pdo, $table, $id, $cascade = false) {
    try {
        $pdo->beginTransaction();
        
        // Check if the table name is valid (only alphanumeric and underscores)
        if (!preg_match('/^[a-zA-Z0-9_]+$/', $table)) {
            return [
                'success' => false,
                'error' => 'Invalid table name'
            ];
        }
        
        // Check if table exists
        $tableCheckStmt = $pdo->prepare("SHOW TABLES LIKE :table");
        $tableCheckStmt->bindParam(':table', $table);
        $tableCheckStmt->execute();
        
        if ($tableCheckStmt->rowCount() === 0) {
            return [
                'success' => false,
                'error' => "Table '$table' does not exist"
            ];
        }
        
        // Check if the item exists
        $checkStmt = $pdo->prepare("SELECT id FROM $table WHERE id = :id");
        $checkStmt->bindParam(':id', $id, PDO::PARAM_INT);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() === 0) {
            return [
                'success' => false,
                'error' => 'Item not found'
            ];
        }
        
        // Check if there are any related records (dependent on the table)
        $relatedRecords = checkForRelatedRecords($pdo, $table, $id);
        if ($relatedRecords > 0) {
            return [
                'success' => false,
                'error' => "Cannot delete this item. It is used by $relatedRecords record(s).",
                'related_count' => $relatedRecords
            ];
        }
        
        // Delete the item
        $stmt = $pdo->prepare("DELETE FROM $table WHERE id = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        if ($stmt->rowCount() === 0) {
            return [
                'success' => false,
                'error' => 'Failed to delete item'
            ];
        }
        
        return [
            'success' => true,
            'message' => 'Item deleted successfully'
        ];
    } catch (PDOException $e) {
        $pdo->rollBack();
        error_log("Error deleting lookup item: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ];
    } catch (Exception $e) {
        $pdo->rollBack();
        error_log("General error: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Error: ' . $e->getMessage()
        ];
    }
}

/**
 * Check if there are any related records in other tables
 * 
 * @param PDO $pdo Database connection
 * @param string $table Table name
 * @param int $id Item ID
 * @return int Number of related records
 */
function checkForRelatedRecords($pdo, $table, $id) {
    try {
        $relatedCount = 0;
        
        // Define related tables for each lookup table
        $relatedTables = [];
        
        switch ($table) {
            case 'leads':
                $relatedTables[] = ['table' => 'customers', 'column' => 'lead_id'];
                break;
            case 'cities':
                $relatedTables[] = ['table' => 'customers', 'column' => 'city_id'];
                $relatedTables[] = ['table' => 'areas', 'column' => 'city_id'];
                break;
            case 'areas':
                $relatedTables[] = ['table' => 'customers', 'column' => 'area_id'];
                break;
            case 'casts':
                $relatedTables[] = ['table' => 'customers', 'column' => 'cast_id'];
                break;
            case 'religions':
                $relatedTables[] = ['table' => 'customers', 'column' => 'religion_id'];
                break;
            case 'marital_statuses':
                $relatedTables[] = ['table' => 'customers', 'column' => 'marital_status_id'];
                break;
            case 'countries':
                $relatedTables[] = ['table' => 'customers', 'column' => 'country_id'];
                $relatedTables[] = ['table' => 'cities', 'column' => 'country_id'];
                break;
            case 'occupations':
                $relatedTables[] = ['table' => 'customers', 'column' => 'occupation'];
                break;
            case 'bank':
                $relatedTables[] = ['table' => 'customers', 'column' => 'bank_id'];
                break;
        }
        
        // Check each related table
        foreach ($relatedTables as $relatedTable) {
            $tableName = $relatedTable['table'];
            $columnName = $relatedTable['column'];
            
            // Check if the table exists before querying
            $tableCheckStmt = $pdo->prepare("SHOW TABLES LIKE :table");
            $tableCheckStmt->bindParam(':table', $tableName);
            $tableCheckStmt->execute();
            
            if ($tableCheckStmt->rowCount() === 0) {
                continue; // Skip if table doesn't exist
            }
            
            // Check if the column exists in the table
            $columnCheckStmt = $pdo->prepare("SHOW COLUMNS FROM $tableName LIKE :column");
            $columnCheckStmt->bindParam(':column', $columnName);
            $columnCheckStmt->execute();
            
            if ($columnCheckStmt->rowCount() === 0) {
                continue; // Skip if column doesn't exist
            }
            
            // Count related records
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM $tableName WHERE $columnName = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            $relatedCount += $stmt->fetchColumn();
            
            // If we've already found related records, we can stop checking
            if ($relatedCount > 0) {
                break;
            }
        }
        
        return $relatedCount;
    } catch (PDOException $e) {
        error_log("Error checking related records: " . $e->getMessage());
        return 0; // Return 0 on error to prevent deletion
    }
}

// Handle API requests
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['_method']) && $_POST['_method'] === 'DELETE') {
    try {
        // Create database connection
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        // Get request parameters
        $table = $_POST['table'];
        $id = $_POST['id'];
        
        // Validate table name to prevent SQL injection
        $allowedTables = ['leads', 'cities', 'areas', 'casts', 'religions', 'marital_statuses', 'countries', 'occupations', 'bank'];
        
        if (!in_array($table, $allowedTables)) {
            header('Content-Type: application/json');
            echo json_encode([
                'success' => false,
                'error' => 'Invalid table name'
            ]);
            exit;
        }
        
        // Delete the item
        $result = deleteLookupItem($pdo, $table, $id);
        
        // Return JSON response
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