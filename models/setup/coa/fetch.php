<?php
// This file handles SELECT operations for Chart of Accounts
// No need to start session or check login as that's handled by the controller

// Initialize variables to store fetched data
$account_heads = [];
$sub_accounts = [];
$accounts = [];
$error_message = '';

try {
    // Fetch account heads with proper error handling
    $account_heads_stmt = $pdo->prepare("SELECT * FROM accounts_head ORDER BY name");
    if (!$account_heads_stmt->execute()) {
        throw new PDOException("Failed to fetch account heads");
    }
    $account_heads = $account_heads_stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch sub accounts with proper error handling
    $sub_accounts_stmt = $pdo->prepare("
        SELECT sa.*, sa.name as sub_name, ah.name as account_head_name 
        FROM sub_accounts sa 
        LEFT JOIN accounts_head ah ON sa.account_head_id = ah.id 
        ORDER BY ah.name, sa.name
    ");
    if (!$sub_accounts_stmt->execute()) {
        throw new PDOException("Failed to fetch sub accounts");
    }
    $sub_accounts = $sub_accounts_stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch accounts with proper error handling
    $accounts_stmt = $pdo->prepare("
        SELECT a.*, sa.name as sub_account_name, ah.name as account_head_name
        FROM accounts a
        LEFT JOIN sub_accounts sa ON a.sub_account_id = sa.id
        LEFT JOIN accounts_head ah ON sa.account_head_id = ah.id
        ORDER BY ah.name, sa.name, a.name
    ");
    if (!$accounts_stmt->execute()) {
        throw new PDOException("Failed to fetch accounts");
    }
    $accounts = $accounts_stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    error_log("Database error in fetch.php: " . $e->getMessage());
    $error_message = "Failed to load account data. Please try again later.";
}

// Return JSON data for AJAX requests
if (isset($_GET['fetch_data']) || (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest')) {
    header('Content-Type: application/json');
    echo json_encode([
        'account_heads' => $account_heads,
        'sub_accounts' => $sub_accounts,
        'accounts' => $accounts,
        'error' => $error_message
    ]);
    exit;
}
?>