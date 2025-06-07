<?php
// This file handles DELETE operations for Chart of Accounts
// No need to start session or check login as that's handled by the controller

// Initialize response array for AJAX requests
$response = array('success' => false, 'error' => '', 'has_dependencies' => false);

// Function to check dependencies before deletion
function check_dependencies($id, $type) {
    global $pdo;
    $dependencies = array();
    
    try {
        if ($type === 'account_head') {
            // Check if account head has any sub accounts
            $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM sub_accounts WHERE account_head_id = :id");
            $check_stmt->bindParam(':id', $id);
            $check_stmt->execute();
            if ($check_stmt->fetchColumn() > 0) {
                $dependencies[] = 'Sub Accounts';
            }
        } elseif ($type === 'sub_account') {
            // Check if sub account has any accounts
            $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM accounts WHERE sub_account_id = :id");
            $check_stmt->bindParam(':id', $id);
            $check_stmt->execute();
            if ($check_stmt->fetchColumn() > 0) {
                $dependencies[] = 'Accounts';
            }
        } elseif ($type === 'account') {
            // First check if there are any journal entries referencing this account
            $tables_to_check = [
                'journal_entries' => ['debit_account_id', 'credit_account_id'],
                'payment_voucher_entries' => ['debit_account_id', 'credit_account_id'],
                'receive_voucher_entries' => ['debit_account_id', 'credit_account_id'],
                // Add any other tables that might reference accounts
            ];
            
            foreach ($tables_to_check as $table => $columns) {
                foreach ($columns as $column) {
                    // Check if table exists before querying
                    $table_exists = $pdo->prepare("SHOW TABLES LIKE :table");
                    $table_exists->execute(['table' => $table]);
                    
                    if ($table_exists->rowCount() > 0) {
                        // If table exists, check for dependencies
                        $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM $table WHERE $column = :id");
                        $check_stmt->bindParam(':id', $id);
                        $check_stmt->execute();
                        
                        if ($check_stmt->fetchColumn() > 0) {
                            // Convert table name to more readable format
                            $readable_name = ucwords(str_replace('_', ' ', $table));
                            $dependencies[] = $readable_name;
                            break; // Break inner loop if dependency found in this table
                        }
                    }
                }
            }
        }
        
        return $dependencies;
        
    } catch (Exception $e) {
        error_log("Error checking dependencies: " . $e->getMessage());
        throw new Exception("Error checking dependencies: " . $e->getMessage());
    }
}

// Handle DELETE operations
try {
    if (isset($_POST['delete_id']) && isset($_POST['delete_type'])) {
        // Validate input
        if (empty($_POST['delete_id']) || empty($_POST['delete_type'])) {
            throw new Exception("Delete ID and type are required");
        }
        
        $delete_id = filter_var($_POST['delete_id'], FILTER_VALIDATE_INT);
        $delete_type = filter_var($_POST['delete_type'], FILTER_SANITIZE_STRING);
        
        // Check if item is locked (system default)
        if ($delete_type === 'account_head' && is_locked_account_head($delete_id)) {
            throw new Exception("This account head is a system default and cannot be deleted");
        } elseif ($delete_type === 'sub_account' && is_locked_sub_account($delete_id)) {
            throw new Exception("This sub account is a system default and cannot be deleted");
        } elseif ($delete_type === 'account' && is_locked_account($delete_id)) {
            throw new Exception("This account is a system default and cannot be deleted");
        }
        
        // Check for dependencies
        $dependencies = check_dependencies($delete_id, $delete_type);
        
        if (!empty($dependencies)) {
            throw new Exception("There are entries associated with this Account in the following forms: '" . implode("', '", $dependencies) . "'. Please delete the associated entries from these forms first.");
        }
        
        // If we get here, it's safe to delete
        if ($delete_type === 'account_head') {
            $delete_stmt = $pdo->prepare("DELETE FROM accounts_head WHERE id = :id");
        } elseif ($delete_type === 'sub_account') {
            $delete_stmt = $pdo->prepare("DELETE FROM sub_accounts WHERE id = :id");
        } elseif ($delete_type === 'account') {
            $delete_stmt = $pdo->prepare("DELETE FROM accounts WHERE id = :id");
        }
        
        $delete_stmt->bindParam(':id', $delete_id);
        
        if (!$delete_stmt->execute()) {
            throw new PDOException("Failed to delete item");
        }
        
        $response['success'] = true;
        $response['message'] = ucfirst($delete_type) . " deleted successfully";
    } elseif (isset($_POST['check_dependencies'])) {
        $delete_id = filter_var($_POST['delete_id'], FILTER_VALIDATE_INT);
        $delete_type = filter_var($_POST['delete_type'], FILTER_SANITIZE_STRING);
        
        $dependencies = check_dependencies($delete_id, $delete_type);
        
        $response['success'] = true;
        $response['has_dependencies'] = !empty($dependencies);
        if (!empty($dependencies)) {
            $forms_list = implode("', '", $dependencies);
            $response['error'] = "There are entries associated with this Account in the following forms: '$forms_list'. Please delete the associated entries from these forms first.";
        }
    }
    
} catch (Exception $e) {
    error_log("Error in delete.php: " . $e->getMessage());
    $response['error'] = $e->getMessage();
}

if (isset($_POST['ajax'])) {
    header('Content-Type: application/json');
    echo json_encode($response);
    exit;
}

// Redirect for non-AJAX requests
if ($response['success'] || $response['error']) {
    header('Location: index.php' . ($response['success'] ? '?success=1' : '?error=' . urlencode($response['error'])));
    exit;
}
?>