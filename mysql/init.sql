-- Create a database and a table for the blog posts
CREATE DATABASE IF NOT EXISTS blog;
USE blog;

-- Table structure for the posts
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
