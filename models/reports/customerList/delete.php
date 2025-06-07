<?php
/**
 * Delete customer functionality
 * This file handles deleting a customer by ID
 */

// Start session and include database connection
session_start();
require_once '../../../includes/connection.php';

// Check if user is logged in
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
    
    // First delete related records from customer_banks table
    $deleteCustomerBanksQuery = "DELETE FROM customer_banks WHERE customer_id = ?";
    $stmt = $pdo->prepare($deleteCustomerBanksQuery);
    $stmt->execute([$customerId]);
    
    // Delete any cell numbers associated with this customer
    $deleteCellQuery = "DELETE FROM cell_no WHERE customer_id = ?";
    $stmt = $pdo->prepare($deleteCellQuery);
    $stmt->execute([$customerId]);
    
    // Now we can safely delete the customer
    $deleteCustomerQuery = "DELETE FROM customers WHERE id = ?";
    $stmt = $pdo->prepare($deleteCustomerQuery);
    $stmt->execute([$customerId]);
    
    // Commit transaction
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