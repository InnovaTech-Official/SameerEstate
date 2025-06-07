<?php
session_start();
require_once('../../../includes/connection.php');
require_once('../../../models/setup/companySetup/post.php');
require_once('../../../models/setup/companySetup/update.php');
require_once('../../../models/setup/companySetup/fetch.php');

// Redirect to login page if not logged in
if (!isset($_SESSION['user_id'])) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        header('Content-Type: application/json');
        echo json_encode(['error' => true, 'message' => 'Not authenticated']);
        exit;
    } else {
        header('Location: ../../../controllers/auth/login.php');
        exit;
    }
}

// Check if the user is an admin
if (!isset($_SESSION['is_admin']) || !$_SESSION['is_admin']) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        header('Content-Type: application/json');
        echo json_encode(['error' => true, 'message' => 'Access denied. You are not authorized to access this feature.']);
        exit;
    } else {
        echo "Access denied. You are not authorized to view this page.";
        exit;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Set content type to JSON for AJAX responses
    header('Content-Type: application/json');
    
    try {
        // Handle logo upload
        $logo_path = null;
        if (isset($_FILES['company_logo']) && $_FILES['company_logo']['error'] === UPLOAD_ERR_OK) {
            // Create uploads directory if it doesn't exist
            $upload_dir = 'uploads/company_logo/';
            if (!file_exists($upload_dir)) {
                mkdir($upload_dir, 0777, true);
            }

            $file = $_FILES['company_logo'];
            
            // Validate file type
            $allowed_types = ['image/jpeg', 'image/png', 'image/gif'];
            if (!in_array($file['type'], $allowed_types)) {
                throw new Exception('Invalid file type. Only JPG, PNG and GIF are allowed.');
            }
            
            // Generate unique filename
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
            $filename = 'company_logo_' . uniqid() . '.' . $extension;
            $logo_path = $upload_dir . $filename;
            
            // Move uploaded file
            if (!move_uploaded_file($file['tmp_name'], $logo_path)) {
                throw new Exception('Failed to upload logo');
            }
        }

        // Collect form data
        $data = [
            'company_name' => $_POST['company_name'] ?? '',
            'address_line1' => $_POST['address_line1'] ?? '',
            'address_line2' => $_POST['address_line2'] ?? '',
            'city' => $_POST['city'] ?? '',
            'state' => $_POST['state'] ?? '',
            'postal_code' => $_POST['postal_code'] ?? '',
            'country' => $_POST['country'] ?? '',
            'phone_1' => $_POST['phone_1'] ?? '',
            'phone_2' => $_POST['phone_2'] ?? '',
            'email' => $_POST['email'] ?? '',
            'website' => $_POST['website'] ?? '',
            'tax_id' => $_POST['tax_id'] ?? '',
            'registration_number' => $_POST['registration_number'] ?? ''
        ];

        // Validate required fields
        $required_fields = ['company_name', 'address_line1', 'city', 'state', 'postal_code', 'country', 'phone_1'];
        $missing_fields = [];
        
        foreach ($required_fields as $field) {
            if (empty($_POST[$field])) {
                $missing_fields[] = ucwords(str_replace('_', ' ', $field));
            }
        }
        
        if (!empty($missing_fields)) {
            echo json_encode([
                'error' => true,
                'message' => "Please fill in the following required fields: " . implode(", ", $missing_fields)
            ]);
            exit;
        } else {
            // Save company settings using the model function
            $result = saveCompanySettings($pdo, $data, $logo_path);
            
            if ($result['success']) {
                echo json_encode([
                    'success' => true,
                    'message' => $result['message']
                ]);
            } else {
                echo json_encode([
                    'error' => true,
                    'message' => $result['message']
                ]);
            }
            exit;
        }
    } catch (Exception $e) {
        echo json_encode([
            'error' => true,
            'message' => "Error: " . $e->getMessage()
        ]);
        exit;
    }
} else {
    // For regular page visits, include the HTML view
    include_once('../../../views/setup/companySetup/companySetup.html');
}
?>