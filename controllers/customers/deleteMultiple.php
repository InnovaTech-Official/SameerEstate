<?php
// Delete multiple customers functionality
session_start();
require_once '../../../includes/connection.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Authentication required']);
    exit;
}

// Check if this is a POST request and has IDs
if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_POST['ids']) || !is_array($_POST['ids'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Invalid request or missing customer IDs']);
    exit;
}

$customerIds = $_POST['ids'];

// Validate IDs - all must be numeric
foreach ($customerIds as $id) {
    if (!is_numeric($id)) {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => 'Invalid customer ID']);
        exit;
    }
}

try {
    // Start transaction
    $pdo->beginTransaction();
    
    // Use placeholders for prepared statement
    $placeholders = implode(',', array_fill(0, count($customerIds), '?'));
    
    // First delete related records from customer_banks table
    $deleteCustomerBanksQuery = "DELETE FROM customer_banks WHERE customer_id IN ($placeholders)";
    $stmt = $pdo->prepare($deleteCustomerBanksQuery);
    $stmt->execute($customerIds);
    
    // Delete related cell numbers
    $deleteCellQuery = "DELETE FROM cell_no WHERE customer_id IN ($placeholders)";
    $stmt = $pdo->prepare($deleteCellQuery);
    $stmt->execute($customerIds);
    
    // Now delete the customers
    $deleteCustomersQuery = "DELETE FROM customers WHERE id IN ($placeholders)";
    $stmt = $pdo->prepare($deleteCustomersQuery);
    $stmt->execute($customerIds);
    
    // Commit transaction
    $pdo->commit();
    
    // Return success response
    header('Content-Type: application/json');
    echo json_encode([
        'success' => true, 
        'message' => count($customerIds) . ' customer(s) deleted successfully'
    ]);
} catch (PDOException $e) {
    // Rollback transaction if there was an error
    $pdo->rollBack();
    
    header('Content-Type: application/json');
    echo json_encode([
        'success' => false, 
        'message' => 'Error deleting customers: ' . $e->getMessage()
    ]);
}