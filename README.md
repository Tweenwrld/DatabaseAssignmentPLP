# Bookstore Database Project

## Overview

This project involves designing and implementing a database for a bookstore using MySQL. The database will store information about books, authors, customers, orders, and shipping. This project emphasizes database design principles, SQL proficiency, and user access management. The goal is to create a robust and efficient database system that can handle typical bookstore operations, such as managing inventory, processing orders, and tracking customer information.

## Tools and Technologies

* MySQL
* Draw.io (or similar diagramming tool)

## Prerequisites

* Basic understanding of MySQL
* Ability to create tables in MySQL with appropriate data types
* Familiarity with MySQL user management and security best practices

## Project Objectives

* Design a relational database schema for a bookstore.
* Implement the database using MySQL.
* Create tables with optimal schema and data types.
* Manage database access through user groups and roles.
* Query the database to retrieve and analyze data.
* Demonstrate proficiency in SQL DDL and DML.
* Apply database normalization principles to ensure data integrity.
* Implement security measures to protect sensitive data.

## Database Schema

The database schema is designed to support the core functionalities of a bookstore. The tables and their relationships are as follows:

* **book**: Stores information about books (title, ISBN, publication year, etc.).
    * Key Attributes: `book_id` (primary key), `title`, `isbn`, `publication_date`, `publisher_id`, `language_id`, `price`, `stock_quantity`
* **book\_author**: A junction table for the many-to-many relationship between books and authors.
    * Key Attributes: `book_id`, `author_id` (primary key composite)
* **author**: Stores information about authors.
    * Key Attributes: `author_id` (primary key), `first_name`, `last_name`
* **book\_language**: Stores the languages of the books.
    * Key Attributes: `language_id` (primary key), `language_name`, `language_code`
* **publisher**: Stores information about publishers.
    * Key Attributes: `publisher_id` (primary key), `publisher_name`, `contact_email`, `contact_phone`
* **customer**: Stores information about customers.
    * Key Attributes: `customer_id` (primary key), `first_name`, `last_name`, `email`, `phone`, `registration_date`
* **customer\_address**: A junction table for the many-to-many relationship between customers and their addresses.
    * Key Attributes: `customer_id`, `address_id` (primary key composite), `address_status_id`, `date_from`, `date_to`
* **address\_status**: Stores the status of an address (e.g., current, old).
    * Key Attributes: `address_status_id` (primary key), `status_name`
* **address**: Stores address details.
    * Key Attributes: `address_id` (primary key), `street_number`, `street_name`, `city`, `postal_code`, `country_id`
* **country**: Stores country information.
    * Key Attributes: `country_id` (primary key), `country_name`, `country_code`
* **cust\_order**: Stores customer order information.
    * Key Attributes: `order_id` (primary key), `customer_id`, `order_date`, `shipping_method_id`, `shipping_address_id`, `order_total`
* **order\_line**: Stores the details of books in each order.
    * Key Attributes: `line_id` (primary key), `order_id`, `book_id`, `price`, `quantity`
* **shipping\_method**: Stores shipping methods.
    * Key Attributes: `method_id` (primary key), `method_name`, `cost`
* **order\_history**: Stores the history of orders.
    * Key Attributes: `history_id` (primary key), `order_id`, `status_id`, `status_date`, `notes`
* **order\_status**: Stores order statuses.
    * Key Attributes: `status_id` (primary key), `status_value`

## ER Diagram

\[Diagram of the Bookstore Database ER Diagram would go here]

## SQL Implementation

###   1. Database Creation

    The database is created using the following SQL command:

    * Create a new database named "bookstore".
    * Select the "bookstore" database for use.

###   2. Table Creation

    The following SQL commands create the tables defined in the database schema. The `CREATE TABLE` statements include the definition of columns, data types, primary keys, and foreign key relationships. Constraints such as `NOT NULL` and `DEFAULT` are used to enforce data integrity.

* **publisher Table**:
    * Creates a table to store publisher information, including a unique ID, name, email, and phone number.
* **book\_language Table**:
    * Creates a table to store language information, including a unique ID, name, and code.
* **book Table**:
    * Creates a table to store book information, including a unique ID, title, number of pages, publication date, and foreign keys referencing the publisher and language tables.
* **author Table**:
    * Creates a table to store author information, including a unique ID, first name, and last name.
* **book\_author Table**:
    * Creates a junction table to link books and authors, allowing for many-to-many relationships.
* **customer Table**:
    * Creates a table to store customer information, including a unique ID, name, email, phone number, and registration date.
* **country Table**:
    * Creates a table to store country information, including a unique ID, name, and code.
* **address Table**:
    * Creates a table to store address information, including a unique ID, street details, city, postal code, and a foreign key referencing the country table.
* **address\_status Table**:
    * Creates a table to store address statuses, such as "current" or "old", including a unique ID and status name.
* **customer\_address Table**:
    * Creates a junction table to link customers and addresses, tracking the status and date range of each address.
* **shipping\_method Table**:
    * Creates a table to store shipping method information, including a unique ID, method name, and cost.
* **cust\_order Table**:
    * Creates a table to store customer order information, including a unique ID, customer ID, order date, shipping method, shipping address, and total cost.
* **order\_line Table**:
    * Creates a table to store the details of books within each order, including a unique ID, order ID, book ID, price, and quantity.
* **order\_status Table**:
    * Creates a table to store order statuses, such as "pending" or "shipped", including a unique ID and status value.
* **order_history Table**:
    * Creates a table to store the history of order status changes, including a unique ID, order ID, status ID, status date, and any relevant notes.

###   3. User and Permissions

    This section outlines the SQL commands used to create user accounts with specific roles and permissions. It demonstrates how to set up a read-only user, a user with write permissions, and an administrative user with full privileges. The principle of least privilege is followed to ensure that users only have access to the data they need to perform their job functions.

* Create a user with read-only access to all tables in the database.
* Create a user for sales operations with permissions to select, insert, update, and delete customer, order, and order line data.
* Create a user for inventory management with permissions to manage book, author, publisher, and language data.
* Create a user with full administrative privileges on the database.
* Create a user for shipping management with permissions to manage shipping and order related tables.

## User Roles and Permissions

###   Roles

* **bookstore\_reader**: Read-only access for reporting.

* **bookstore\_sales**: Access to customer, order, and order line tables.

* **bookstore\_inventory**: Access to book, author, and publisher tables.

* **bookstore\_admin**: Full administrative privileges.

* **bookstore\_shipping**: Access to shipping and order related tables.

###   User Creation

    The SQL commands provided in the "SQL Implementation" section create the users associated with the roles defined. Each user is assigned a specific password and host.

###   Permissions

    The SQL `GRANT` statements assign specific privileges to each user role. These privileges define the actions that each user can perform on the database tables. For example, the `bookstore_sales` role is granted `SELECT`, `INSERT`, `UPDATE`, and `DELETE` privileges on the `cust_order` and `order_line` tables, allowing them to manage customer orders. The `bookstore_reader` role is only granted `SELECT` privileges, allowing them to view data but not modify it.

## Testing

* Insert sample data into the tables.
* Execute SQL queries to verify data retrieval.
* Test user permissions by logging in with different user accounts and executing queries.

## Conclusion

This project provides a foundation for managing bookstore data efficiently using MySQL. The database design, table creation, and user management strategies can be extended to accommodate more complex requirements. The implemented database adheres to relational database principles, ensures data integrity, and provides a secure environment for managing bookstore operations.
