<?php
function saveCompanySettings($pdo, $data, $logo_path = null) {
    try {
        // Check if company settings already exist
        $check_query = "SELECT * FROM company_settings LIMIT 1";
        $stmt = $pdo->query($check_query);
        $company_data = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($company_data) {
            // Use the update function instead
            require_once(dirname(__FILE__) . '/update.php');
            return updateCompanySettings($pdo, $data, $logo_path);
        } else {
            // Insert new settings
            $query = "INSERT INTO company_settings 
                (company_name, " . ($logo_path ? "company_logo," : "") . "
                address_line1, address_line2, city, state, postal_code, country, 
                phone_1, phone_2, email, website, tax_id, registration_number) 
                VALUES (:company_name, " . ($logo_path ? ":company_logo," : "") . "
                :address_line1, :address_line2, :city, :state, :postal_code, :country, 
                :phone_1, :phone_2, :email, :website, :tax_id, :registration_number)";
            
            $stmt = $pdo->prepare($query);
            $stmt->bindParam(':company_name', $data['company_name']);
            if ($logo_path) {
                $stmt->bindParam(':company_logo', $logo_path);
            }
            $stmt->bindParam(':address_line1', $data['address_line1']);
            $stmt->bindParam(':address_line2', $data['address_line2']);
            $stmt->bindParam(':city', $data['city']);
            $stmt->bindParam(':state', $data['state']);
            $stmt->bindParam(':postal_code', $data['postal_code']);
            $stmt->bindParam(':country', $data['country']);
            $stmt->bindParam(':phone_1', $data['phone_1']);
            $stmt->bindParam(':phone_2', $data['phone_2']);
            $stmt->bindParam(':email', $data['email']);
            $stmt->bindParam(':website', $data['website']);
            $stmt->bindParam(':tax_id', $data['tax_id']);
            $stmt->bindParam(':registration_number', $data['registration_number']);
            
            $result = $stmt->execute();
            
            if ($result) {
                return ['success' => true, 'message' => 'Company settings saved successfully!'];
            } else {
                return ['success' => false, 'message' => 'Error saving settings: ' . $pdo->errorInfo()[2]];
            }
        }
    } catch (PDOException $e) {
        return ['success' => false, 'message' => 'Database error: ' . $e->getMessage()];
    } catch (Exception $e) {
        return ['success' => false, 'message' => 'Error: ' . $e->getMessage()];
    }
}
?>