<?php
// Database connection settings
$dsn = 'mysql:host=mysql-db;dbname=blog';
$username = 'root';
$password = 'root';
$options = [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION];

try {
    $pdo = new PDO($dsn, $username, $password, $options);
} catch (PDOException $e) {
    die('Database connection failed: ' . $e->getMessage());
}
?>
