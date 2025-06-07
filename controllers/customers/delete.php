<?php
/**
 * Customer delete controller
 * This file handles the API request for deleting a customer
 */

// Include the database connection
require_once '../../../includes/connection.php';

// Check if user is logged in
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Authentication required']);
    exit;
}

// Check if this is a POST request and has an ID
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_POST['id']) || !is_numeric($_POST['id'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Invalid request or missing customer ID']);
    exit;
}

$customerId = (int)$_POST['id'];

try {
    // Start transaction
    $pdo->beginTransaction();
    
    // Delete related records from all tables with foreign key constraints
    
    // Delete from customer_banks table (handles the foreign key constraint error)
    $deleteBanks = $pdo->prepare("DELETE FROM customer_banks WHERE customer_id = ?");
    $deleteBanks->execute([$customerId]);
    
    // Delete from cell_no table
    $deleteCell = $pdo->prepare("DELETE FROM cell_no WHERE customer_id = ?");
    $deleteCell->execute([$customerId]);
    
    // Check for other possible related tables and delete from them
    // (Add more delete statements for other tables with foreign key constraints)
    
    // Finally delete the customer
    $deleteCustomer = $pdo->prepare("DELETE FROM customers WHERE id = ?");
    $deleteCustomer->execute([$customerId]);
    
    // Commit the transaction
    $pdo->commit();
    
    // Return success response
    header('Content-Type: application/json');
    echo json_encode(['success' => true, 'message' => 'Customer deleted successfully']);
} catch (PDOException $e) {
    // Rollback transaction if there was an error
    $pdo->rollBack();
    
    header('Content-Type: application/json');
    echo json_encode([
        'success' => false, 
        'message' => 'Error deleting customer: ' . $e->getMessage()
    ]);
}