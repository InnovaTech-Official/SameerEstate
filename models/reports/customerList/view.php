<?php
/**
 * Functions to retrieve customer data for viewing
 */

/**
 * Fetch a customer by ID with all related data
 * 
 * @param PDO $pdo Database connection
 * @param int $id Customer ID
 * @return array|false Customer data or false if not found
 */
function fetchCustomerById($pdo, $id) {
    try {
        error_log("Model fetchCustomerById called with ID: $id");
        
        // Basic query to just get the customer first
        $basicSql = "SELECT * FROM customers WHERE id = :id";
        $basicStmt = $pdo->prepare($basicSql);
        $basicStmt->bindParam(':id', $id, PDO::PARAM_INT);
        $basicStmt->execute();
        
        $basicCustomer = $basicStmt->fetch(PDO::FETCH_ASSOC);
        
        // Debug output
        if ($basicCustomer) {
            error_log("Basic query found customer with name: " . $basicCustomer['name']);
        } else {
            error_log("Basic query did not find any customer with ID: $id");
            error_log("SQL used: $basicSql");
            return false;
        }
        
        // Main customer query with all joins - fixed column names to match the database schema
        $sql = "SELECT c.*, 
                l.name as lead_name,
                r.name as religion_name,
                ms.name as marital_status,
                a.name as area_name,
                ct.name as city_name,
                cn.name as country_name,
                o.name as occupation_name
                FROM customers c
                LEFT JOIN leads l ON c.lead_id = l.id
                LEFT JOIN religions r ON c.religion_id = r.id
                LEFT JOIN marital_statuses ms ON c.marital_status_id = ms.id
                LEFT JOIN areas a ON c.area_id = a.id
                LEFT JOIN cities ct ON c.city_id = ct.id
                LEFT JOIN countries cn ON c.country_id = cn.id
                LEFT JOIN occupations o ON c.occupation = o.id
                WHERE c.id = :id";
        
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        $customer = $stmt->fetch(PDO::FETCH_ASSOC);
        
        // Debug log
        if (!$customer) {
            error_log("Full query did not find customer (this should not happen if basic query succeeded)");
            return $basicCustomer; // Return the basic customer data as fallback
        }
        
        // Get cell numbers from cell_no table
        $cellNumbersSql = "SELECT cell_no FROM cell_no WHERE customer_id = :id";
        $cellStmt = $pdo->prepare($cellNumbersSql);
        $cellStmt->bindParam(':id', $id, PDO::PARAM_INT);
        $cellStmt->execute();
        
        $cellNumbers = $cellStmt->fetchAll(PDO::FETCH_COLUMN);
        
        if (!empty($cellNumbers)) {
            $customer['cell'] = $cellNumbers[0]; // Set the primary cell number
            $customer['additional_cell_numbers'] = $cellNumbers; // Store all cell numbers
            error_log("Found " . count($cellNumbers) . " cell numbers from cell_no table");
        }
        
        // Get bank details from customer_banks table
        $bankSql = "SELECT bank_name, iban FROM customer_banks WHERE customer_id = :id";
        $bankStmt = $pdo->prepare($bankSql);
        $bankStmt->bindParam(':id', $id, PDO::PARAM_INT);
        $bankStmt->execute();
        
        $bankDetails = $bankStmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (!empty($bankDetails)) {
            // Set the primary bank and IBAN
            $customer['bank_name'] = $bankDetails[0]['bank_name'];
            $customer['account_iban'] = $bankDetails[0]['iban'];
            
            // Store all bank accounts with IBANs
            $customer['bank_accounts'] = $bankDetails;
            
            // Create an array of just IBANs for backward compatibility
            $ibans = array_column($bankDetails, 'iban');
            $customer['additional_ibans'] = $ibans;
            
            error_log("Found " . count($bankDetails) . " bank accounts from customer_banks table");
        } else {
            // Fallback to check legacy bank fields in the customers table
            if (!empty($basicCustomer['bank'])) {
                $customer['bank_name'] = $basicCustomer['bank'];
                error_log("Using legacy bank name from customers table");
            }
            
            if (!empty($basicCustomer['account_iban'])) {
                $customer['account_iban'] = $basicCustomer['account_iban'];
                $customer['additional_ibans'] = [$basicCustomer['account_iban']];
                error_log("Using legacy IBAN from customers table");
            }
        }
        
        // Add image URLs if available
        if (!empty($customer['photo'])) {
            $customer['photo_url'] = '../../../uploads/customer/customer_photos/' . $customer['photo'];
        }
        
        if (!empty($customer['cnic_front'])) {
            $customer['cnic_front_url'] = '../../../uploads/customer/cnic_front/' . $customer['cnic_front'];
        }
        
        if (!empty($customer['cnic_back'])) {
            $customer['cnic_back_url'] = '../../../uploads/customer/cnic_back/' . $customer['cnic_back'];
        }
        
        if (!empty($customer['visiting_card'])) {
            $customer['visiting_card_url'] = '../../../uploads/customer/visiting_cards/' . $customer['visiting_card'];
        }
        
        error_log("Successfully prepared full customer data");
        return $customer;
    } catch (PDOException $e) {
        // Log error
        error_log("Database error in fetchCustomerById: " . $e->getMessage());
        throw new Exception("Database error: " . $e->getMessage());
    }
}

/**
 * Fetch lookup data for dropdowns
 * 
 * @param PDO $pdo Database connection
 * @return array Lookup data
 */
function fetchLookupData($pdo) {
    try {
        $lookupData = [];
        
        // Fetch leads
        $stmt = $pdo->query("SELECT id, name FROM leads ORDER BY name");
        $lookupData['leads'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch religions
        $stmt = $pdo->query("SELECT id, name FROM religions ORDER BY name");
        $lookupData['religions'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch marital statuses
        $stmt = $pdo->query("SELECT id, name FROM marital_statuses ORDER BY name");
        $lookupData['maritalStatuses'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch areas
        $stmt = $pdo->query("SELECT id, name FROM areas ORDER BY name");
        $lookupData['areas'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch cities
        $stmt = $pdo->query("SELECT id, name FROM cities ORDER BY name");
        $lookupData['cities'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch countries
        $stmt = $pdo->query("SELECT id, name FROM countries ORDER BY name");
        $lookupData['countries'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch occupations
        $stmt = $pdo->query("SELECT id, name FROM occupations ORDER BY name");
        $lookupData['occupations'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch banks
        $stmt = $pdo->query("SELECT id, name FROM bank ORDER BY name");
        $lookupData['banks'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Fetch casts
        $stmt = $pdo->query("SELECT id, name FROM casts ORDER BY name");
        $lookupData['casts'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        return $lookupData;
    } catch (PDOException $e) {
        // Log error
        error_log("Database error in fetchLookupData: " . $e->getMessage());
        throw new Exception("Error fetching lookup data: " . $e->getMessage());
    }
}