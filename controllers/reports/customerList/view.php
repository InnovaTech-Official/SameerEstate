<?php
session_start();
require_once '../../../includes/connection.php';
require_once '../../../models/reports/customerList/view.php';

// Set content type to JSON for error responses when needed
$isJsonResponse = isset($_GET['format']) && $_GET['format'] === 'json';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    if ($isJsonResponse) {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'error' => 'Not logged in', 'redirect' => '../../auth/login.php']);
        exit;
    } else {
        header('Location: ../../auth/login.php');
        exit;
    }
}

// Check if ID parameter exists
if (!isset($_GET['id']) || empty($_GET['id'])) {
    if ($isJsonResponse) {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'error' => 'No customer ID provided']);
        exit;
    } else {
        // Log the error for debugging
        error_log('No customer ID provided in view.php');
        $_SESSION['error'] = "No customer ID provided";
        // header('Location: index.php');
        exit;
    }
}

$customerId = intval($_GET['id']);

// For debugging
error_log("Attempting to fetch customer with ID: $customerId");

try {
    // Fetch customer data
    $customer = fetchCustomerById($pdo, $customerId);
    
    // If customer not found
    if (!$customer) {
        if ($isJsonResponse) {
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'error' => "Customer with ID $customerId not found"]);
            exit;
        } else {
            // Log the error for debugging
            error_log("Customer with ID $customerId not found");
            $_SESSION['error'] = "Customer not found";
            header('Location: index.php');
            exit;
        }
    }
    
    // Success - Fetch additional data for dropdowns
    $lookupData = fetchLookupData($pdo);
    
    // Prepare data for JavaScript
    $jsData = [
        'success' => true,
        'customer' => $customer,
        'lookupData' => $lookupData
    ];
    
    // If JSON response was requested, return the data as JSON
    if ($isJsonResponse) {
        header('Content-Type: application/json');
        echo json_encode($jsData);
        exit;
    }
    
    // Otherwise include the HTML template and pass the data
    include_once '../../../views/reports/customerList/view.html';
    
} catch (Exception $e) {
    error_log("Error in view.php: " . $e->getMessage());
    
    if ($isJsonResponse) {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'error' => $e->getMessage()]);
        exit;
    } else {
        $_SESSION['error'] = "An error occurred: " . $e->getMessage();
        header('Location: index.php');
        exit;
    }
}
?>

<!-- Script to pass PHP data to JavaScript -->
<script>
    // Pass PHP data to JavaScript
    const customerData = <?php echo json_encode($jsData); ?>;
</script>