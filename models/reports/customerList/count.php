<?php
/**
 * API endpoint to get the total customer count
 * Used for the live customer count feature
 */

require_once '../../../includes/connection.php';
require_once '../../../models/reports/customerList/fetch.php';

// Set response header to JSON
header('Content-Type: application/json');

try {
    // Fetch the total customer count
    $totalCustomers = fetchTotalCustomers($pdo);
    
    // Return the count as JSON
    echo json_encode([
        'success' => true,
        'total_customers' => $totalCustomers
    ]);
} catch (Exception $e) {
    // Return error as JSON
    echo json_encode([
        'success' => false,
        'message' => 'Error fetching customer count: ' . $e->getMessage()
    ]);
}
?>