<?php
/**
 * Export Customer List to PDF
 * This file handles exporting the customer list to PDF using DOMPDF
 */

// Start session and include necessary files
session_start();
require_once '../../../includes/connection.php';
require_once '../../../models/reports/customerList/fetch.php';

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: ../../auth/login.php');
    exit;
}

// Get customer IDs from the request
$customerIds = [];
if (isset($_POST['customerIds'])) {
    $customerIds = json_decode($_POST['customerIds'], true);
}

// Get search parameters
$searchParams = [];
if (isset($_POST['searchParams'])) {
    $searchParams = json_decode($_POST['searchParams'], true);
}

// If no customer IDs are provided, get all customers
if (empty($customerIds)) {
    $customers = fetchAllCustomers($pdo);
} else {
    // Get customers by IDs
    $sql = "
        SELECT 
            c.id,
            c.name,
            c.email,
            c.company,
            c.occupation,
            c.photo,
            DATE_FORMAT(c.created_at, '%d-%m-%Y') as entry_date,
            l.name as lead_name,
            r.name as religion_name,
            ms.name as marital_status
        FROM customers c
        LEFT JOIN leads l ON c.lead_id = l.id
        LEFT JOIN religions r ON c.religion_id = r.id
        LEFT JOIN marital_statuses ms ON c.marital_status_id = ms.id
        WHERE c.id IN (" . implode(',', array_fill(0, count($customerIds), '?')) . ")
        ORDER BY c.created_at DESC
    ";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute($customerIds);
    $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Fetch cell numbers for each customer
    foreach ($customers as &$customer) {
        $cellSql = "
            SELECT cell_no
            FROM cell_no
            WHERE customer_id = ?
            ORDER BY id ASC
        ";
        $cellStmt = $pdo->prepare($cellSql);
        $cellStmt->execute([$customer['id']]);
        $cellNumbers = $cellStmt->fetchAll(PDO::FETCH_COLUMN);
        
        if (!empty($cellNumbers)) {
            // Set primary cell number
            $customer['cell'] = $cellNumbers[0];
            
            // If there are multiple cell numbers, store them all
            if (count($cellNumbers) > 1) {
                $customer['all_cell_numbers'] = $cellNumbers;
            }
        } else {
            $customer['cell'] = '';
        }
    }
}

// Get company information
$companyInfoSql = "SELECT company_name, address_line1, phone_1, email, company_logo FROM company_settings LIMIT 1";
$companyStmt = $pdo->query($companyInfoSql);
$companyInfo = $companyStmt->fetch(PDO::FETCH_ASSOC);

// Get filter descriptions for the report header
$filterDescription = "All Customers";
if (!empty($searchParams)) {
    $filterParts = [];
    
    if (!empty($searchParams['search'])) {
        $filterParts[] = "Search: " . htmlspecialchars($searchParams['search']);
    }
    
    if (!empty($searchParams['cellNumber'])) {
        $filterParts[] = "Cell: " . htmlspecialchars($searchParams['cellNumber']);
    }
    
    if (!empty($searchParams['leadSource'])) {
        $filterParts[] = "Lead: " . htmlspecialchars($searchParams['leadSource']);
    }
    
    if (!empty($searchParams['religion'])) {
        $filterParts[] = "Religion: " . htmlspecialchars($searchParams['religion']);
    }
    
    if (!empty($searchParams['maritalStatus'])) {
        $filterParts[] = "Marital Status: " . htmlspecialchars($searchParams['maritalStatus']);
    }
    
    if (!empty($searchParams['dateFrom']) || !empty($searchParams['dateTo'])) {
        $datePart = "Date: ";
        if (!empty($searchParams['dateFrom'])) {
            $datePart .= "From " . htmlspecialchars($searchParams['dateFrom']);
        }
        if (!empty($searchParams['dateTo'])) {
            $datePart .= (!empty($searchParams['dateFrom']) ? " " : "") . "To " . htmlspecialchars($searchParams['dateTo']);
        }
        $filterParts[] = $datePart;
    }
    
    if (!empty($filterParts)) {
        $filterDescription = "Filtered by: " . implode(", ", $filterParts);
    }
}

// Include DOMPDF library
require_once '../../../vendor/autoload.php';

// Reference the Dompdf namespace
use Dompdf\Dompdf;
use Dompdf\Options;

// Set options
$options = new Options();
$options->set('isHtml5ParserEnabled', true);
$options->set('isRemoteEnabled', true); // Allow loading images from remote URLs
$options->set('defaultFont', 'Arial');

// Initialize dompdf
$dompdf = new Dompdf($options);

// Generate HTML content for PDF
$html = '
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Customer List Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 10pt;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .header img {
            max-height: 60px;
            margin-bottom: 10px;
        }
        .header h1 {
            margin: 0;
            font-size: 18pt;
            color: #333;
        }
        .header p {
            margin: 5px 0;
            font-size: 10pt;
            color: #666;
        }
        .report-title {
            text-align: center;
            font-size: 14pt;
            font-weight: bold;
            margin: 20px 0 10px;
        }
        .filter-info {
            text-align: center;
            font-size: 9pt;
            color: #666;
            margin-bottom: 15px;
            font-style: italic;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 9pt;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 6px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .cell-numbers {
            font-size: 8pt;
        }
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            font-size: 8pt;
            color: #666;
            padding-top: 5px;
            border-top: 1px solid #ddd;
        }
        .page-number:after {
            content: counter(page);
        }
    </style>
</head>
<body>
    <div class="header">
        ' . (!empty($companyInfo['logo']) ? '<img src="' . $companyInfo['logo'] . '" alt="Company Logo">' : '') . '
        <h1>' . (!empty($companyInfo['name']) ? htmlspecialchars($companyInfo['name']) : 'Real Estate Management System') . '</h1>
        <p>' . (!empty($companyInfo['address']) ? htmlspecialchars($companyInfo['address']) : '') . '</p>
        <p>Phone: ' . (!empty($companyInfo['phone']) ? htmlspecialchars($companyInfo['phone']) : '') . ' | Email: ' . (!empty($companyInfo['email']) ? htmlspecialchars($companyInfo['email']) : '') . '</p>
    </div>
    
    <div class="report-title">Customer List Report</div>
    <div class="filter-info">' . $filterDescription . ' | Generated on: ' . date('d-m-Y H:i:s') . '</div>
    
    <table>
        <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Lead</th>
                <th>Religion</th>
                <th>Company</th>
                <th>Entry Date</th>
            </tr>
        </thead>
        <tbody>';

// Add rows for each customer
foreach ($customers as $customer) {
    // Format cell numbers
    $cellDisplay = $customer['cell'] ?? 'N/A';
    if (isset($customer['all_cell_numbers']) && count($customer['all_cell_numbers']) > 1) {
        $cellDisplay = implode(", ", $customer['all_cell_numbers']);
    }
    
    $html .= '
            <tr>
                <td>' . htmlspecialchars($customer['id'] ?? '') . '</td>
                <td>' . htmlspecialchars($customer['name'] ?? '') . '</td>
                <td class="cell-numbers">' . htmlspecialchars($cellDisplay) . '</td>
                <td>' . htmlspecialchars($customer['email'] ?? '') . '</td>
                <td>' . htmlspecialchars($customer['lead_name'] ?? '') . '</td>
                <td>' . htmlspecialchars($customer['religion_name'] ?? '') . '</td>
                <td>' . htmlspecialchars($customer['company'] ?? '') . '</td>
                <td>' . htmlspecialchars($customer['entry_date'] ?? '') . '</td>
            </tr>';
}

$html .= '
        </tbody>
    </table>
    
    <div class="footer">
        <span>Page <span class="page-number"></span></span>
    </div>
</body>
</html>';

// Load HTML into dompdf
$dompdf->loadHtml($html);

// Set paper size and orientation (landscape for wider tables)
$dompdf->setPaper('A4', 'landscape');

// Render the PDF
$dompdf->render();

// Output the PDF to the browser with a filename
$filename = 'customer_list_' . date('Y-m-d_H-i-s') . '.pdf';
$dompdf->stream($filename, array('Attachment' => true));
exit;