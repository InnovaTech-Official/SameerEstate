<?php
// Check if company settings already exist
$company_data = null;
try {
    $check_query = "SELECT * FROM company_settings LIMIT 1";
    $stmt = $pdo->query($check_query);
    if ($stmt) {
        $company_data = $stmt->fetch(PDO::FETCH_ASSOC);
    }
} catch (PDOException $e) {
    $error_message = "Error fetching company data: " . $e->getMessage();
}
?>