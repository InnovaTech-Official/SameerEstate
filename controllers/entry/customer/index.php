<?php
session_start();
require_once '../../../includes/connection.php';
require_once '../../../models/entry/customer/post.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: ../../auth/login.php');
    exit;
}

// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Create database connection
try {
    $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Handle AJAX request for getting next customer ID
if (isset($_GET['action']) && $_GET['action'] === 'get_next_code') {
    header('Content-Type: application/json');
    echo json_encode([
        'success' => true,
        'code' => generateCustomerCode($pdo)
    ]);
    exit;
}

// Generate initial ID for form display
$newCustomerCode = generateCustomerCode($pdo);

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    header('Content-Type: application/json');
    
    try {
        // Debug: Log POST data
        error_log("POST data: " . print_r($_POST, true));
        
        // Process additional cell numbers
        $additionalCells = [];
        if (isset($_POST['additional_cell']) && is_array($_POST['additional_cell'])) {
            foreach ($_POST['additional_cell'] as $cell) {
                if (!empty($cell)) {
                    $additionalCells[] = $cell;
                }
            }
        }
        
        // Process additional bank details
        $additionalBankIds = [];
        if (isset($_POST['additional_bank_id']) && is_array($_POST['additional_bank_id'])) {
            foreach ($_POST['additional_bank_id'] as $bankId) {
                if (!empty($bankId)) {
                    $additionalBankIds[] = $bankId;
                }
            }
        }
        
        $additionalIbans = [];
        if (isset($_POST['additional_iban']) && is_array($_POST['additional_iban'])) {
            foreach ($_POST['additional_iban'] as $iban) {
                if (!empty($iban)) {
                    $additionalIbans[] = $iban;
                }
            }
        }
        
        $data = array(
            'lead_id' => !empty($_POST['leads_id']) ? $_POST['leads_id'] : null,
            'name' => $_POST['name'],
            'father' => !empty($_POST['father']) ? $_POST['father'] : null,
            'cast_id' => !empty($_POST['casts_id']) ? $_POST['casts_id'] : null,
            'religion_id' => !empty($_POST['religions_id']) ? $_POST['religions_id'] : null,
            'marital_status_id' => !empty($_POST['marital_statuses_id']) ? $_POST['marital_statuses_id'] : null,
            'email' => !empty($_POST['email']) ? $_POST['email'] : null,
            'web_page' => !empty($_POST['web_page']) ? $_POST['web_page'] : null,
            'address' => !empty($_POST['address']) ? $_POST['address'] : null,
            'area_id' => !empty($_POST['areas_id']) ? $_POST['areas_id'] : null,
            'city_id' => !empty($_POST['cities_id']) ? $_POST['cities_id'] : null,
            'country_id' => !empty($_POST['countries_id']) ? $_POST['countries_id'] : null,
            'cell' => $_POST['cell'],
            'cnic' => !empty($_POST['cnic']) ? $_POST['cnic'] : null,
            'dob' => !empty($_POST['dob']) ? $_POST['dob'] : null,
            'star' => !empty($_POST['star']) ? $_POST['star'] : null,
            'bank_id' => !empty($_POST['bank_id']) ? $_POST['bank_id'] : null,
            'account_iban' => !empty($_POST['account_iban']) ? $_POST['account_iban'] : null,
            'additional_bank_id' => $additionalBankIds,
            'additional_iban' => $additionalIbans,
            'ref_name' => !empty($_POST['ref_name']) ? $_POST['ref_name'] : null,
            'ref_cnic' => !empty($_POST['ref_cnic']) ? $_POST['ref_cnic'] : null,
            'ref_cell' => !empty($_POST['ref_cell']) ? $_POST['ref_cell'] : null,
            'ref_note' => !empty($_POST['ref_note']) ? $_POST['ref_note'] : null,
            'company' => !empty($_POST['company']) ? $_POST['company'] : null,
            'department' => !empty($_POST['department']) ? $_POST['department'] : null,
            'designation' => !empty($_POST['designation']) ? $_POST['designation'] : null,
            'occupation' => !empty($_POST['occupations_id']) ? $_POST['occupations_id'] : null, // Changed from occupation_id to occupation
            'off_address' => !empty($_POST['off_address']) ? $_POST['off_address'] : null,
            'work_note' => !empty($_POST['work_note']) ? $_POST['work_note'] : null,
            'remarks' => !empty($_POST['remarks']) ? $_POST['remarks'] : null,
            'additional_cell' => $additionalCells
        );

        // Call the model function to insert the customer
        $response = insertCustomer($pdo, $data, $_FILES);
        
        echo json_encode($response);
    } catch (Exception $e) {
        error_log("Error saving customer: " . $e->getMessage());
        echo json_encode([
            'success' => false, 
            'error' => $e->getMessage()
        ]);
    }
    exit;
}

// Load customer data for editing if ID is provided
if (isset($_GET['id']) && is_numeric($_GET['id'])) {
    $customerId = intval($_GET['id']);
    
    try {
        // Fetch basic customer information
        $stmt = $pdo->prepare("
            SELECT c.*, 
                l.name as lead_name,
                ct.name as city_name,
                a.name as area_name,
                cs.name as cast_name,
                r.name as religion_name,
                ms.name as marital_status_name,
                co.name as country_name,
                o.name as occupation_name
            FROM customers c
            LEFT JOIN leads l ON c.lead_id = l.id
            LEFT JOIN cities ct ON c.city_id = ct.id
            LEFT JOIN areas a ON c.area_id = a.id
            LEFT JOIN casts cs ON c.cast_id = cs.id
            LEFT JOIN religions r ON c.religion_id = r.id
            LEFT JOIN marital_statuses ms ON c.marital_status_id = ms.id
            LEFT JOIN countries co ON c.country_id = co.id
            LEFT JOIN occupations o ON o.id = c.occupation
            WHERE c.id = :id
        ");
        
        $stmt->bindParam(':id', $customerId, PDO::PARAM_INT);
        $stmt->execute();
        
        $customer = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($customer) {
            // Fetch cell numbers from cell_no table
            $cellStmt = $pdo->prepare("
                SELECT cell_no FROM cell_no 
                WHERE customer_id = :customer_id 
                ORDER BY id ASC
            ");
            $cellStmt->bindParam(':customer_id', $customerId, PDO::PARAM_INT);
            $cellStmt->execute();
            
            $cellNumbers = $cellStmt->fetchAll(PDO::FETCH_COLUMN);
            
            // Assign the primary cell number to the customer record
            if (!empty($cellNumbers)) {
                $customer['cell'] = $cellNumbers[0];
                
                // Store additional cell numbers
                $customer['additional_cell'] = array_slice($cellNumbers, 1);
            }

            // Fetch bank information from customer_banks table
            $bankStmt = $pdo->prepare("
                SELECT id, bank_name, iban
                FROM customer_banks
                WHERE customer_id = :customer_id
                ORDER BY id ASC
            ");
            $bankStmt->bindParam(':customer_id', $customerId, PDO::PARAM_INT);
            $bankStmt->execute();
            
            $bankData = $bankStmt->fetchAll(PDO::FETCH_ASSOC);
            
            // Get the primary bank and IBAN details
            if (!empty($bankData)) {
                $customer['bank_name'] = $bankData[0]['bank_name'];
                $customer['account_iban'] = $bankData[0]['iban'];
                
                // Get bank_id from bank table for the primary bank
                $bankIdStmt = $pdo->prepare("
                    SELECT id FROM bank WHERE name = :bank_name
                ");
                $bankIdStmt->bindParam(':bank_name', $bankData[0]['bank_name'], PDO::PARAM_STR);
                $bankIdStmt->execute();
                $bankIdResult = $bankIdStmt->fetch(PDO::FETCH_ASSOC);
                if ($bankIdResult) {
                    $customer['bank_id'] = $bankIdResult['id'];
                }
                
                // Store additional bank information
                $customer['additional_banks'] = array_slice($bankData, 1);
            }

            // Fetch customer files
            $fileStmt = $pdo->prepare("
                SELECT file_type, file_path 
                FROM customer_files 
                WHERE customer_id = :customer_id
            ");
            
            $fileStmt->bindParam(':customer_id', $customerId, PDO::PARAM_INT);
            $fileStmt->execute();
            
            $files = $fileStmt->fetchAll(PDO::FETCH_ASSOC);
            $customer['files'] = [];
            
            foreach ($files as $file) {
                $customer['files'][$file['file_type']] = $file['file_path'];
            }
            
            // Make customer data available to JavaScript
            echo "<script>const customerData = " . json_encode($customer) . ";</script>";
        }
    } catch (PDOException $e) {
        error_log("Error fetching customer data: " . $e->getMessage());
    }
}

// If no AJAX request or form submission, include the HTML view
include_once '../../../views/entry/customer/customer.html';
?>