<?php
/**
 * Database Configuration
 * MySQL connection settings for Movie Review Website
 */

// Database credentials
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', 'MaybeReda');  // Change this to your MySQL password
define('DB_NAME', 'movie_review_db');
define('DB_CHARSET', 'utf8mb4');

// Create database connection
function getDBConnection() {
    try {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        return $pdo;
    } catch (PDOException $e) {
        // Log error and return user-friendly message
        error_log("Database Connection Error: " . $e->getMessage());
        die(json_encode([
            'error' => true,
            'message' => 'Database connection failed. Please try again later.'
        ]));
    }
}

// Test connection function
function testConnection() {
    try {
        $pdo = getDBConnection();
        return [
            'success' => true,
            'message' => 'Database connected successfully!'
        ];
    } catch (Exception $e) {
        return [
            'success' => false,
            'message' => $e->getMessage()
        ];
    }
}
?>
