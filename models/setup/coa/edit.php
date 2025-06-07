<?php
// This file handles UPDATE operations for Chart of Accounts
// No need to start session or check login as that's handled by the controller

// Initialize response array for AJAX requests
$response = array('success' => false, 'error' => '');

// Handle form submissions for edits
try {
    if (isset($_POST['edit_id']) && isset($_POST['edit_type']) && isset($_POST['edit_name'])) {
        // Validate input
        if (empty($_POST['edit_id']) || empty($_POST['edit_type']) || empty($_POST['edit_name'])) {
            throw new Exception("Edit ID, type and name are required");
        }
        
        $edit_id = filter_var($_POST['edit_id'], FILTER_VALIDATE_INT);
        $edit_type = filter_var($_POST['edit_type'], FILTER_SANITIZE_STRING);
        $edit_name = filter_var($_POST['edit_name'], FILTER_SANITIZE_STRING);
        
        // Check if item is locked
        if ($edit_type === 'account_head' && is_locked_account_head($edit_id)) {
            throw new Exception("This account head is a system default and cannot be edited");
        } elseif ($edit_type === 'sub_account' && is_locked_sub_account($edit_id)) {
            throw new Exception("This sub account is a system default and cannot be edited");
        } elseif ($edit_type === 'account' && is_locked_account($edit_id)) {
            throw new Exception("This account is a system default and cannot be edited");
        }
        
        // Update account head, sub account or account
        if ($edit_type === 'account_head') {
            $update_stmt = $pdo->prepare("UPDATE accounts_head SET name = :name WHERE id = :id");
        } elseif ($edit_type === 'sub_account') {
            $update_stmt = $pdo->prepare("UPDATE sub_accounts SET name = :name WHERE id = :id");
        } elseif ($edit_type === 'account') {
            $update_stmt = $pdo->prepare("UPDATE accounts SET name = :name WHERE id = :id");
        } else {
            throw new Exception("Invalid edit type");
        }
        
        $update_stmt->bindParam(':name', $edit_name);
        $update_stmt->bindParam(':id', $edit_id);
        
        if (!$update_stmt->execute()) {
            throw new PDOException("Failed to update account");
        }
        
        $response['success'] = true;
        $response['message'] = "Account updated successfully";
    }
    
} catch (Exception $e) {
    error_log("Error in edit.php: " . $e->getMessage());
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