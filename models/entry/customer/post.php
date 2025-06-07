<?php
require_once '../../../includes/connection.php';

/**
 * Generate a simple numeric ID for a new customer
 * 
 * @param PDO $pdo Database connection
 * @return string The generated customer ID
 */
function generateCustomerCode($pdo) {
    try {
        // Get the last customer ID from the database
        $stmt = $pdo->query("SELECT MAX(id) FROM customers");
        $lastId = $stmt->fetchColumn();
        
        // If no records exist, start with 1, otherwise use last ID + 1
        $newId = $lastId ? $lastId + 1 : 1;
        
        return (string)$newId;
    } catch (PDOException $e) {
        error_log("Error generating customer ID: " . $e->getMessage());
        // Fallback code generation
        return '1';
    }
}

/**
 * Convert an image to WebP format
 * 
 * @param string $source Path to source image
 * @param string $destination Path to destination WebP image
 * @param int $quality WebP quality (0-100)
 * @return bool True if successful, false otherwise
 */
function convertToWebP($source, $destination, $quality = 80) {
    $info = getimagesize($source);
    if (!$info) {
        return false;
    }

    $mime = $info['mime'];
    
    switch ($mime) {
        case 'image/jpeg':
            $image = imagecreatefromjpeg($source);
            break;
        case 'image/png':
            $image = imagecreatefrompng($source);
            // Handle transparency for PNG
            imagepalettetotruecolor($image);
            imagealphablending($image, true);
            imagesavealpha($image, true);
            break;
        case 'image/gif':
            $image = imagecreatefromgif($source);
            break;
        case 'image/bmp':
            $image = imagecreatefrombmp($source);
            break;
        case 'image/webp':
            // Already WebP, just copy
            return copy($source, $destination);
        case 'image/svg+xml':
            // SVG cannot be converted to WebP using GD
            // Just copy it instead
            return copy($source, $destination);
        default:
            return false;
    }

    if (!$image) {
        return false;
    }

    $result = imagewebp($image, $destination, $quality);
    imagedestroy($image);
    
    return $result;
}

/**
 * Insert or update a customer record
 * 
 * @param PDO $pdo Database connection
 * @param array $data Customer data
 * @param array $files Uploaded files
 * @param int|null $customerId Optional customer ID for updates
 * @return array Success status and message
 */
function insertCustomer($pdo, $data, $files = [], $customerId = null) {
    try {
        $pdo->beginTransaction();
        
        // Check if customer with the same CNIC or cell already exists
        if (!empty($data['cnic'])) {
            require_once 'fetch.php';
            if (customerExists($pdo, 'cnic', $data['cnic'], $customerId)) {
                return [
                    'success' => false,
                    'error' => 'A customer with this CNIC already exists.'
                ];
            }
        }
        
        if (!empty($data['cell'])) {
            require_once 'fetch.php';
            if (customerExists($pdo, 'cell', $data['cell'], $customerId)) {
                return [
                    'success' => false,
                    'error' => 'A customer with this cell number already exists.'
                ];
            }
        }
        
        // Check if the customers table has updated_at column
        $hasUpdatedAtColumn = false;
        $stmt = $pdo->prepare("SHOW COLUMNS FROM customers LIKE 'updated_at'");
        $stmt->execute();
        if ($stmt->rowCount() > 0) {
            $hasUpdatedAtColumn = true;
        }
        
        // Prepare common fields for insert or update with null defaults for all optional fields
        $fields = [
            'lead_id' => isset($data['lead_id']) && !empty($data['lead_id']) ? $data['lead_id'] : null,
            'name' => $data['name'],
            'father' => isset($data['father']) ? $data['father'] : null,
            'cast_id' => isset($data['cast_id']) && !empty($data['cast_id']) ? $data['cast_id'] : null,
            'religion_id' => isset($data['religion_id']) && !empty($data['religion_id']) ? $data['religion_id'] : null,
            'marital_status_id' => isset($data['marital_status_id']) && !empty($data['marital_status_id']) ? $data['marital_status_id'] : null,
            'email' => isset($data['email']) ? $data['email'] : null,
            'web_page' => isset($data['web_page']) ? $data['web_page'] : null,
            'address' => isset($data['address']) ? $data['address'] : null,
            'area_id' => isset($data['area_id']) && !empty($data['area_id']) ? $data['area_id'] : null,
            'city_id' => isset($data['city_id']) && !empty($data['city_id']) ? $data['city_id'] : null,
            'country_id' => isset($data['country_id']) && !empty($data['country_id']) ? $data['country_id'] : null,
            // Note: We're no longer storing cell in the customers table
            // 'cell' => $data['cell'],
            'cnic' => isset($data['cnic']) ? $data['cnic'] : null,
            'dob' => isset($data['dob']) ? $data['dob'] : null,
            'star' => isset($data['star']) ? $data['star'] : null,
            // Removed bank_id and account_iban - now using customer_banks table
            'ref_name' => isset($data['ref_name']) ? $data['ref_name'] : null,
            'ref_cnic' => isset($data['ref_cnic']) ? $data['ref_cnic'] : null,
            'ref_cell' => isset($data['ref_cell']) ? $data['ref_cell'] : null,
            'ref_note' => isset($data['ref_note']) ? $data['ref_note'] : null,
            'company' => isset($data['company']) ? $data['company'] : null,
            'department' => isset($data['department']) ? $data['department'] : null,
            'designation' => isset($data['designation']) ? $data['designation'] : null,
            'occupation' => isset($data['occupation']) && !empty($data['occupation']) ? $data['occupation'] : null,
            'off_address' => isset($data['off_address']) ? $data['off_address'] : null,
            'work_note' => isset($data['work_note']) ? $data['work_note'] : null,
            'remarks' => isset($data['remarks']) ? $data['remarks'] : ''
        ];
        
        // Insert or update the customer record
        if ($customerId) {
            // Update existing record
            $updatePairs = [];
            $params = [];
            
            foreach ($fields as $field => $value) {
                $updatePairs[] = "$field = :$field";
                $params[":$field"] = $value;
            }
            
            if ($hasUpdatedAtColumn) {
                $params[':updated_at'] = date('Y-m-d H:i:s');
                $sql = "UPDATE customers SET " . implode(', ', $updatePairs) . ", updated_at = :updated_at WHERE id = :id";
            } else {
                $sql = "UPDATE customers SET " . implode(', ', $updatePairs) . " WHERE id = :id";
            }
            
            $params[':id'] = $customerId;
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            
            // Customer ID already exists
            $newCustomerId = $customerId;
            
            // Remove existing cell numbers for this customer before adding new ones
            $deleteStmt = $pdo->prepare("DELETE FROM cell_no WHERE customer_id = :customer_id");
            $deleteStmt->execute([':customer_id' => $newCustomerId]);
            
            // Remove existing bank records for this customer before adding new ones
            $deleteBankStmt = $pdo->prepare("DELETE FROM customer_banks WHERE customer_id = :customer_id");
            $deleteBankStmt->execute([':customer_id' => $newCustomerId]);
        } else {
            // Insert new record
            $fieldNames = array_keys($fields);
            $placeholders = array_map(function($field) {
                return ":$field";
            }, $fieldNames);
            
            $params = [];
            foreach ($fields as $field => $value) {
                $params[":$field"] = $value;
            }
            
            // Check if created_at column exists
            $hasCreatedAtColumn = false;
            $stmt = $pdo->prepare("SHOW COLUMNS FROM customers LIKE 'created_at'");
            $stmt->execute();
            if ($stmt->rowCount() > 0) {
                $hasCreatedAtColumn = true;
            }
            
            if ($hasCreatedAtColumn && $hasUpdatedAtColumn) {
                $params[':created_at'] = date('Y-m-d H:i:s');
                $params[':updated_at'] = date('Y-m-d H:i:s');
                
                $sql = "INSERT INTO customers (" . implode(', ', $fieldNames) . ", created_at, updated_at) 
                        VALUES (" . implode(', ', $placeholders) . ", :created_at, :updated_at)";
            } elseif ($hasCreatedAtColumn) {
                $params[':created_at'] = date('Y-m-d H:i:s');
                
                $sql = "INSERT INTO customers (" . implode(', ', $fieldNames) . ", created_at) 
                        VALUES (" . implode(', ', $placeholders) . ", :created_at)";
            } else {
                $sql = "INSERT INTO customers (" . implode(', ', $fieldNames) . ") 
                        VALUES (" . implode(', ', $placeholders) . ")";
            }
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            
            $newCustomerId = $pdo->lastInsertId();
        }
        
        // Insert primary cell number in the cell_no table - using prepared statements properly
        if (!empty($data['cell'])) {
            $cellStmt = $pdo->prepare("INSERT INTO cell_no (customer_id, cell_no) VALUES (:customer_id, :cell_no)");
            $cellStmt->bindParam(':customer_id', $newCustomerId, PDO::PARAM_INT);
            $cellStmt->bindParam(':cell_no', $data['cell'], PDO::PARAM_STR);
            $cellStmt->execute();
        }
        
        // Insert additional cell numbers if any - using prepared statements properly
        if (isset($data['additional_cell']) && is_array($data['additional_cell'])) {
            $additionalCellStmt = $pdo->prepare("INSERT INTO cell_no (customer_id, cell_no) VALUES (:customer_id, :cell_no)");
            $additionalCellStmt->bindParam(':customer_id', $newCustomerId, PDO::PARAM_INT);
            
            foreach ($data['additional_cell'] as $additionalCell) {
                if (!empty($additionalCell)) {
                    $additionalCellStmt->bindParam(':cell_no', $additionalCell, PDO::PARAM_STR);
                    $additionalCellStmt->execute();
                }
            }
        }
        
        // Insert primary bank and IBAN information into customer_banks table
        if ((!empty($data['bank_id']) || !empty($data['bank_name'])) && !empty($data['account_iban'])) {
            $bankName = !empty($data['bank_name']) ? $data['bank_name'] : '';
            
            // If bank_id is provided, get the bank name from the bank table
            if (!empty($data['bank_id'])) {
                $bankStmt = $pdo->prepare("SELECT name FROM bank WHERE id = :bank_id");
                $bankStmt->bindParam(':bank_id', $data['bank_id'], PDO::PARAM_INT);
                $bankStmt->execute();
                $bankResult = $bankStmt->fetch(PDO::FETCH_ASSOC);
                
                if ($bankResult && !empty($bankResult['name'])) {
                    $bankName = $bankResult['name'];
                }
            }
            
            // Insert the primary bank information
            $bankInsertStmt = $pdo->prepare("INSERT INTO customer_banks (customer_id, bank_name, iban) VALUES (:customer_id, :bank_name, :iban)");
            $bankInsertStmt->bindParam(':customer_id', $newCustomerId, PDO::PARAM_INT);
            $bankInsertStmt->bindParam(':bank_name', $bankName, PDO::PARAM_STR);
            $bankInsertStmt->bindParam(':iban', $data['account_iban'], PDO::PARAM_STR);
            $bankInsertStmt->execute();
        }
        
        // Insert additional bank information if any
        if (isset($data['additional_bank_id']) && is_array($data['additional_bank_id']) && 
            isset($data['additional_iban']) && is_array($data['additional_iban'])) {
            
            $additionalBankStmt = $pdo->prepare("INSERT INTO customer_banks (customer_id, bank_name, iban) VALUES (:customer_id, :bank_name, :iban)");
            $additionalBankStmt->bindParam(':customer_id', $newCustomerId, PDO::PARAM_INT);
            
            for ($i = 0; $i < count($data['additional_iban']); $i++) {
                if (!empty($data['additional_iban'][$i])) {
                    $bankName = '';
                    
                    // If bank_id is provided, get the bank name
                    if (!empty($data['additional_bank_id'][$i])) {
                        $bankStmt = $pdo->prepare("SELECT name FROM bank WHERE id = :bank_id");
                        $bankStmt->bindParam(':bank_id', $data['additional_bank_id'][$i], PDO::PARAM_INT);
                        $bankStmt->execute();
                        $bankResult = $bankStmt->fetch(PDO::FETCH_ASSOC);
                        
                        if ($bankResult && !empty($bankResult['name'])) {
                            $bankName = $bankResult['name'];
                        }
                    }
                    
                    // If we have a bank name and IBAN, insert the record
                    if (!empty($bankName) && !empty($data['additional_iban'][$i])) {
                        $additionalBankStmt->bindParam(':bank_name', $bankName, PDO::PARAM_STR);
                        $additionalBankStmt->bindParam(':iban', $data['additional_iban'][$i], PDO::PARAM_STR);
                        $additionalBankStmt->execute();
                    }
                }
            }
        }
        
        // Define file upload paths for different file types
        $fileUploadPaths = [
            'photo' => '../../../uploads/customer/customer_photos/',
            'cnic_front' => '../../../uploads/customer/cnic_front/',
            'cnic_back' => '../../../uploads/customer/cnic_back/',
            'visiting_card' => '../../../uploads/customer/visiting_cards/'
        ];
        
        // Process file uploads
        $fileTypes = ['photo', 'cnic_front', 'cnic_back', 'visiting_card'];
        
        // Ensure all upload directories exist
        foreach ($fileUploadPaths as $path) {
            if (!is_dir($path)) {
                mkdir($path, 0777, true);
            }
        }
        
        foreach ($fileTypes as $fileType) {
            if (isset($files[$fileType]) && $files[$fileType]['error'] === UPLOAD_ERR_OK) {
                $tmpName = $files[$fileType]['tmp_name'];
                $fileName = basename($files[$fileType]['name']);
                $fileExt = pathinfo($fileName, PATHINFO_EXTENSION);
                
                // Always use .webp extension regardless of original format
                $newFileName = $fileType . '_' . $newCustomerId . '_' . time() . '.webp';
                $targetPath = $fileUploadPaths[$fileType] . $newFileName;
                
                // Convert image to WebP format and save it
                $conversionSuccess = convertToWebP($tmpName, $targetPath);
                
                if ($conversionSuccess) {
                    // Check if customer_files table has updated_at column
                    $hasCustomerFilesUpdatedAtColumn = false;
                    $stmt = $pdo->prepare("SHOW COLUMNS FROM customer_files LIKE 'updated_at'");
                    $stmt->execute();
                    if ($stmt->rowCount() > 0) {
                        $hasCustomerFilesUpdatedAtColumn = true;
                    }
                    
                    // Check if customer_files table has created_at column
                    $hasCustomerFilesCreatedAtColumn = false;
                    $stmt = $pdo->prepare("SHOW COLUMNS FROM customer_files LIKE 'created_at'");
                    $stmt->execute();
                    if ($stmt->rowCount() > 0) {
                        $hasCustomerFilesCreatedAtColumn = true;
                    }
                    
                    // Check if a record already exists for this file type
                    $checkStmt = $pdo->prepare("
                        SELECT id FROM customer_files 
                        WHERE customer_id = :customer_id AND file_type = :file_type
                    ");
                    
                    $checkStmt->execute([
                        ':customer_id' => $newCustomerId,
                        ':file_type' => $fileType
                    ]);
                    
                    $existingFile = $checkStmt->fetch(PDO::FETCH_ASSOC);
                    
                    if ($existingFile) {
                        // Update existing file record
                        if ($hasCustomerFilesUpdatedAtColumn) {
                            $updateStmt = $pdo->prepare("
                                UPDATE customer_files 
                                SET file_path = :file_path, updated_at = :updated_at 
                                WHERE id = :id
                            ");
                            
                            $updateStmt->execute([
                                ':file_path' => $targetPath,
                                ':updated_at' => date('Y-m-d H:i:s'),
                                ':id' => $existingFile['id']
                            ]);
                        } else {
                            $updateStmt = $pdo->prepare("
                                UPDATE customer_files 
                                SET file_path = :file_path 
                                WHERE id = :id
                            ");
                            
                            $updateStmt->execute([
                                ':file_path' => $targetPath,
                                ':id' => $existingFile['id']
                            ]);
                        }
                    } else {
                        // Insert new file record
                        if ($hasCustomerFilesCreatedAtColumn && $hasCustomerFilesUpdatedAtColumn) {
                            $insertStmt = $pdo->prepare("
                                INSERT INTO customer_files (customer_id, file_type, file_path, created_at, updated_at) 
                                VALUES (:customer_id, :file_type, :file_path, :created_at, :updated_at)
                            ");
                            
                            $insertStmt->execute([
                                ':customer_id' => $newCustomerId,
                                ':file_type' => $fileType,
                                ':file_path' => $targetPath,
                                ':created_at' => date('Y-m-d H:i:s'),
                                ':updated_at' => date('Y-m-d H:i:s')
                            ]);
                        } elseif ($hasCustomerFilesCreatedAtColumn) {
                            $insertStmt = $pdo->prepare("
                                INSERT INTO customer_files (customer_id, file_type, file_path, created_at) 
                                VALUES (:customer_id, :file_type, :file_path, :created_at)
                            ");
                            
                            $insertStmt->execute([
                                ':customer_id' => $newCustomerId,
                                ':file_type' => $fileType,
                                ':file_path' => $targetPath,
                                ':created_at' => date('Y-m-d H:i:s')
                            ]);
                        } else {
                            $insertStmt = $pdo->prepare("
                                INSERT INTO customer_files (customer_id, file_type, file_path) 
                                VALUES (:customer_id, :file_type, :file_path)
                            ");
                            
                            $insertStmt->execute([
                                ':customer_id' => $newCustomerId,
                                ':file_type' => $fileType,
                                ':file_path' => $targetPath
                            ]);
                        }
                    }
                } else {
                    // Failed to convert or move file
                    error_log("Failed to convert and save image: $tmpName to $targetPath");
                }
            }
        }
        
        // Commit all changes in a single transaction
        $pdo->commit();
        
        return [
            'success' => true,
            'message' => $customerId ? 'Customer updated successfully' : 'Customer added successfully',
            'id' => $newCustomerId
        ];
    } catch (PDOException $e) {
        $pdo->rollBack();
        error_log("Error inserting/updating customer: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Database error: ' . $e->getMessage()
        ];
    } catch (Exception $e) {
        $pdo->rollBack();
        error_log("General error: " . $e->getMessage());
        return [
            'success' => false,
            'error' => 'Error: ' . $e->getMessage()
        ];
    }
}

/**
 * Handle direct POST requests to this script for API use
 */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && !isset($_GET['action'])) {
    // This block handles API calls when post.php is called directly
    try {
        // Create database connection
        $dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        // Check if it's an update operation
        $customerId = isset($_POST['id']) && !empty($_POST['id']) ? intval($_POST['id']) : null;
        
        // Process the customer data
        $result = insertCustomer($pdo, $_POST, $_FILES, $customerId);
        
        // Return JSON response
        header('Content-Type: application/json');
        echo json_encode($result);
    } catch (Exception $e) {
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'error' => 'Server error: ' . $e->getMessage()
        ]);
    }
}
?>