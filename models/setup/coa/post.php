<?php
// This file handles INSERT operations for Chart of Accounts
// No need to start session or check login as that's handled by the controller

// Initialize response array for AJAX requests
$response = array('success' => false, 'error' => '', 'has_dependencies' => false);

// Handle form submissions for INSERT operations
try {
    if (isset($_POST['add_account_head'])) {
        // Validate input
        if (empty($_POST['name'])) {
            throw new Exception("Account head name is required");
        }
        
        $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
        
        // Check for duplicate
        $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM accounts_head WHERE name = :name");
        $check_stmt->bindParam(':name', $name);
        $check_stmt->execute();
        
        if ($check_stmt->fetchColumn() > 0) {
            throw new Exception("Account head with this name already exists");
        }
        
        // Insert new account head
        $insert_stmt = $pdo->prepare("INSERT INTO accounts_head (name) VALUES (:name)");
        $insert_stmt->bindParam(':name', $name);
        
        if (!$insert_stmt->execute()) {
            throw new PDOException("Failed to add account head");
        }
        
        $response['success'] = true;
        $response['message'] = "Account head added successfully";
    } elseif (isset($_POST['add_sub_account'])) {
        // Validate input
        if (empty($_POST['name']) || empty($_POST['account_head_id'])) {
            throw new Exception("Sub account name and account head are required");
        }
        
        $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
        $account_head_id = filter_var($_POST['account_head_id'], FILTER_VALIDATE_INT);
        
        // Check for duplicate
        $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM sub_accounts WHERE name = :name AND account_head_id = :account_head_id");
        $check_stmt->bindParam(':name', $name);
        $check_stmt->bindParam(':account_head_id', $account_head_id);
        $check_stmt->execute();
        
        if ($check_stmt->fetchColumn() > 0) {
            throw new Exception("Sub account with this name already exists under the selected account head");
        }
        
        // Insert new sub account
        $insert_stmt = $pdo->prepare("INSERT INTO sub_accounts (name, account_head_id) VALUES (:name, :account_head_id)");
        $insert_stmt->bindParam(':name', $name);
        $insert_stmt->bindParam(':account_head_id', $account_head_id);
        
        if (!$insert_stmt->execute()) {
            throw new PDOException("Failed to add sub account");
        }
        
        $response['success'] = true;
        $response['message'] = "Sub account added successfully";
    } elseif (isset($_POST['add_account'])) {
        // Validate input
        if (empty($_POST['name']) || empty($_POST['sub_account_id'])) {
            throw new Exception("Account name and sub account are required");
        }
        
        $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
        $sub_account_id = filter_var($_POST['sub_account_id'], FILTER_VALIDATE_INT);
        
        // Check for duplicate
        $check_stmt = $pdo->prepare("SELECT COUNT(*) FROM accounts WHERE name = :name AND sub_account_id = :sub_account_id");
        $check_stmt->bindParam(':name', $name);
        $check_stmt->bindParam(':sub_account_id', $sub_account_id);
        $check_stmt->execute();
        
        if ($check_stmt->fetchColumn() > 0) {
            throw new Exception("Account with this name already exists under the selected sub account");
        }
        
        // Insert new account
        $insert_stmt = $pdo->prepare("INSERT INTO accounts (name, sub_account_id) VALUES (:name, :sub_account_id)");
        $insert_stmt->bindParam(':name', $name);
        $insert_stmt->bindParam(':sub_account_id', $sub_account_id);
        
        if (!$insert_stmt->execute()) {
            throw new PDOException("Failed to add account");
        }
        
        $response['success'] = true;
        $response['message'] = "Account added successfully";
    }
    
} catch (Exception $e) {
    error_log("Error in post.php: " . $e->getMessage());
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