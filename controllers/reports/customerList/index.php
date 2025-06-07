<?php
session_start();
require_once '../../../includes/connection.php';
require_once '../../../models/reports/customerList/fetch.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: ../../auth/login.php');
    exit;
}

// Fetch all customer data
$customers = fetchAllCustomers($pdo);

// Fetch total customer count
$totalCustomers = fetchTotalCustomers($pdo);

// Fetch lookup data for filters
$lookupData = fetchLookupData($pdo);
$leads = $lookupData['leads'];
$religions = $lookupData['religions'];
$maritalStatuses = $lookupData['maritalStatuses'];

// Prepare data for JavaScript
$jsData = [
    'customers' => $customers,
    'totalCustomers' => $totalCustomers,
    'lookupData' => [
        'leads' => $leads,
        'religions' => $religions,
        'maritalStatuses' => $maritalStatuses
    ]
];

// Include the HTML template
include_once '../../../views/reports/customerList/customerList.html';
?>

<!-- Script to pass PHP data to JavaScript -->
<script>
    // Pass PHP data to JavaScript
    const customerData = <?php echo json_encode($jsData); ?>;
</script>