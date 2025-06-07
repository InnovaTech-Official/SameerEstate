<?php
session_start();
require_once('../../../includes/connection.php');
require_once('../../../models/setup/companySetup/fetch.php');

// Redirect to login page if not logged in
if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Not authenticated']);
    exit;
}

// Check if the user is an admin
if (!isset($_SESSION['is_admin']) || !$_SESSION['is_admin']) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Access denied. You are not authorized to view this page.']);
    exit;
}

// Set response content type to JSON
header('Content-Type: application/json');

try {
    // Company data is already fetched in fetch.php and available as $company_data
    if ($company_data) {
        // Add logo URL if available
        if (!empty($company_data['company_logo'])) {
            // Make sure we return the full URL to the logo
            $company_data['company_logo'] = '../../../' . $company_data['company_logo'];
        }
        
        echo json_encode(['success' => true, 'company_data' => $company_data]);
    } else {
        echo json_encode(['success' => true, 'company_data' => null]);
    }
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>