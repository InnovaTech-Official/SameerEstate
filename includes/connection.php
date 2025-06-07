<?php
// Database connection settings for MySQL
$host = 'localhost';
$dbname = 'sameer';
$username = 'root';
$password = ''; // Default empty password for XAMPP MySQL

// Error reporting settings
ini_set('display_errors', 1);
error_reporting(E_ALL);

try {
    // Create PDO instance for MySQL with proper charset
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
    
    // Database wrapper functions
    
    /**
     * Execute a query and return a single row
     * @param string $sql SQL query with placeholders
     * @param array $params Parameters for the query
     * @return array|false The first row from the result or false if no rows
     */
    function db_get_row($sql, $params = []) {
        global $pdo;
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetch();
    }
    
    /**
     * Execute a query and return all rows
     * @param string $sql SQL query with placeholders
     * @param array $params Parameters for the query
     * @return array Array of rows from the result
     */
    function db_get_all($sql, $params = []) {
        global $pdo;
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }
    
    /**
     * Execute a query that doesn't return rows
     * @param string $sql SQL query with placeholders
     * @param array $params Parameters for the query
     * @return int Number of affected rows
     */
    function db_query($sql, $params = []) {
        global $pdo;
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->rowCount();
    }
    
    /**
     * Insert data and return the last insert ID
     * @param string $sql SQL query with placeholders
     * @param array $params Parameters for the query
     * @return string Last insert ID
     */
    function db_insert($sql, $params = []) {
        global $pdo;
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $pdo->lastInsertId();
    }
    
} catch (PDOException $e) {
    // Log the error and display a user-friendly message
    error_log("Database Connection Error: " . $e->getMessage());
    echo "Database connection failed. Please check your configuration or contact support.";
    exit();
}
?>
