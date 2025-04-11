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
