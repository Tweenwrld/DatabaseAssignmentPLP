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

--  Stores information about books available in the bookstore, including title, pages, publication details, price, and stock.
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    num_pages INT,
    publication_date DATE,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON DELETE SET NULL,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id) ON DELETE SET NULL
);

-- These table will store information about authors, including their first and last names.
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- These table works in hand with the author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

-- Stores customer information, including contact details and authentication data.
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    registration_date DATE NOT NULL
);

-- Stores country information, including name and country code.
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE
);


-- Stores address information for customers, including street details and country reference.
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(10),
    street_name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id) ON DELETE SET NULL
);

-- Stores possible statuses for customer addresses ie Current, Previous.
CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- These table maanges relationship between customers and addresses, with status and date tracking.
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    date_from DATE NOT NULL,
    date_to DATE,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE,
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id) ON DELETE SET NULL
);

-- Stores available shipping methods and their base costs.
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL
);

-- Stores customer order information, including order date, customer, shipping details, and total.
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME NOT NULL,
    shipping_method_id INT,
    shipping_address_id INT,
    order_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id) ON DELETE SET NULL,
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id) ON DELETE SET NULL
);

-- Stores details of each book in an order, including quantity and price at the time of purchase.
CREATE TABLE order_line (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE SET NULL
);

-- These table will store all possible statuses for orders where the status value can be Pending, Shipped, Delivered, Cancelled.
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_value VARCHAR(50) NOT NULL
);

-- Tracks the history of status changes for each order, with timestamps and notes.
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES order_status(status_id) ON DELETE SET NULL
);

ALTER TABLE customer DROP COLUMN password_hash;