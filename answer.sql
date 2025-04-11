CREATE DATABASE bookstore;
USE bookstore;

-- Stores information about publishers, including their name and contact details.
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20)
);

-- These table will store languages in which books are available, with language name and code.
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL,
    language_code CHAR(2) NOT NULL UNIQUE
);