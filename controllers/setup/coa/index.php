<?php
session_start();
require_once '../../../includes/connection.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: ../../auth/login.php');
    exit;
}

// Define the functions to check if an account is locked
function is_locked_account_head($id) {
    $locked_ids = [1, 2, 3, 4, 5]; // IDs of locked account heads
    return in_array($id, $locked_ids);
}

function is_locked_sub_account($id) {
    $locked_ids = range(1, 31); // IDs 1-31 are locked
    return in_array($id, $locked_ids);
}

function is_locked_account($id) {
    $locked_ids = [1, 2, 3, 4]; // IDs of locked accounts
    return in_array($id, $locked_ids);
}

// CONTROLLER LOGIC - Route requests to appropriate model files
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Handle INSERT operations
    if (isset($_POST['add_account_head']) || isset($_POST['add_sub_account']) || isset($_POST['add_account'])) {
        require_once '../../../models/setup/coa/post.php';
    }
    // Handle UPDATE operations
    elseif (isset($_POST['edit_id']) && isset($_POST['edit_type']) && isset($_POST['edit_name'])) {
        require_once '../../../models/setup/coa/edit.php';
    }
    // Handle DELETE operations
    elseif (isset($_POST['delete_id']) && isset($_POST['delete_type']) || isset($_POST['check_dependencies'])) {
        require_once '../../../models/setup/coa/delete.php';
    }
}

// Always fetch data for display
require_once '../../../models/setup/coa/fetch.php';

// Include the HTML view to render the page
include_once '../../../views/setup/coa/coa.html';
?>