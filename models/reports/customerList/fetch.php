<?php
/**
 * Fetch customer data from database
 * This file handles retrieving customer data for display in the customer list
 */

/**
 * Fetches all customer data from the database
 * 
 * @param PDO $pdo Database connection
 * @return array Returns all customer data
 */
function fetchAllCustomers($pdo) {
    // Get all customers with their primary cell number first
    $sql = "
        SELECT 
            c.id,
            c.name,
            c.email,
            c.company,
            c.occupation,
            c.visiting_card,
            c.photo,
            DATE_FORMAT(c.created_at, '%d-%m-%Y') as entry_date,
            l.name as lead_name,
            r.name as religion_name,
            ms.name as marital_status
        FROM customers c
        LEFT JOIN leads l ON c.lead_id = l.id
        LEFT JOIN religions r ON c.religion_id = r.id
        LEFT JOIN marital_statuses ms ON c.marital_status_id = ms.id
        ORDER BY c.created_at DESC
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch all cell numbers for each customer
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
        
        // Construct the full path for the photo if it exists
        if (!empty($customer['photo'])) {
            // Using the correct path format with server document root
            $customer['photo_url'] = '../../../uploads/customer/customer_photos/' . $customer['photo'];
        } else {
            $customer['photo_url'] = '';
        }
    }

    return $customers;
}

/**
 * Fetches the total number of customers from the database
 * 
 * @param PDO $pdo Database connection
 * @return int Returns the total number of customers
 */
function fetchTotalCustomers($pdo) {
    $sql = "SELECT COUNT(*) AS total_customers FROM customers";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    
    return (int)$result['total_customers'];
}

/**
 * Fetches lookup data for filters
 * 
 * @param PDO $pdo Database connection
 * @return array Returns lookup data for filters
 */
function fetchLookupData($pdo) {
    // Fetch lookup data for filters
    $leadStmt = $pdo->query("SELECT id, name FROM leads ORDER BY name");
    $leads = $leadStmt->fetchAll(PDO::FETCH_ASSOC);

    $religionStmt = $pdo->query("SELECT id, name FROM religions ORDER BY name");
    $religions = $religionStmt->fetchAll(PDO::FETCH_ASSOC);

    $maritalStmt = $pdo->query("SELECT id, name FROM marital_statuses ORDER BY name");
    $maritalStatuses = $maritalStmt->fetchAll(PDO::FETCH_ASSOC);

    return [
        'leads' => $leads,
        'religions' => $religions,
        'maritalStatuses' => $maritalStatuses
    ];
}