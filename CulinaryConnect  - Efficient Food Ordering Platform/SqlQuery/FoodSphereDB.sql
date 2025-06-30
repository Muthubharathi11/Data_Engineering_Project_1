CREATE DATABASE FoodSphereDB;

USE FoodSphereDB;

SHOW TABLES;

USE FoodSphereDB;

CREATE TABLE IF NOT EXISTS customers (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Insert sample data into customers table
INSERT INTO customers (first_name, last_name, phone_number, email) VALUES
('Ethan', 'Hunt', '9876543210', 'ethan.hunt@example.com'),
('Lara', 'Croft', '8765432109', 'lara.croft@example.com'),
('Tony', 'Stark', '7654321098', 'tony.stark@example.com'),
('Natasha', 'Romanoff', '6543210987', 'natasha.romanoff@example.com'),
('Bruce', 'Wayne', '5432109876', 'bruce.wayne@example.com');

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- Items Table
CREATE TABLE IF NOT EXISTS items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    image_url VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    delivery_address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Payments Table
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    amount DECIMAL(10, 2),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert Categories
INSERT INTO categories (category_name) VALUES
('Vegetarian'),
('Non-Vegetarian'),
('Vegan'),
('Desserts');

INSERT INTO categories (category_name) VALUES
('Starters');


-- Insert Items
INSERT INTO items (item_name, description, price, category_id) VALUES
('Veg Pulav', 'Aromatic rice with vegetables', 120.00, 1),
('Paneer Tikka', 'Grilled cottage cheese', 180.00, 1),
('Chicken Biryani', 'Spicy rice with chicken', 200.00, 2),
('Egg Curry', 'Eggs in spicy gravy', 100.00, 3),
('Gulab Jamun', 'Sweet dessert', 50.00, 4);

INSERT INTO items (item_name, description, price, category_id) VALUES
('Veg Roll', 'Delicious vegetable roll', 150.00, (SELECT category_id FROM categories WHERE category_name = 'Starters'));


-- Insert Users
INSERT INTO users (first_name, last_name, phone_number, email) VALUES
('John', 'Doe', '123-456-7890', 'john.doe@example.com'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com');

-- Insert Orders
INSERT INTO orders (user_id, delivery_address) VALUES
(1, '123 Main St'),
(2, '456 Oak Rd');

-- Insert Order Items
INSERT INTO order_items (order_id, item_id, quantity, price) VALUES
(1, 1, 2, 120.00),
(1, 2, 1, 180.00),
(2, 3, 1, 200.00);

-- Insert Payments
INSERT INTO payments (order_id, payment_method, payment_status, amount) VALUES
(1, 'Credit Card', 'Paid', 420.00),
(2, 'Debit Card', 'Paid', 200.00);

INSERT INTO users (first_name, last_name, phone_number, email) VALUES
('Aryan', 'Verma', '987-654-3210', 'aryan.verma@example.com'),
('Kiara', 'Sharma', '982-345-6789', 'kiara.sharma@example.com'),
('Raghav', 'Mehta', '981-234-5678', 'raghav.mehta@example.com'),
('Zara', 'Khan', '987-765-4321', 'zara.khan@example.com'),
('Neha', 'Kapoor', '981-123-4567', 'neha.kapoor@example.com'),
('Kabir', 'Singh', '982-876-5432', 'kabir.singh@example.com'),
('Ishaan', 'Chopra', '980-987-6543', 'ishaan.chopra@example.com'),
('Anaya', 'Nair', '980-345-6789', 'anaya.nair@example.com');

-- Clear the existing data first
DELETE FROM customers;

-- Insert unique user IDs
INSERT INTO customers (user_id, first_name, last_name, phone_number, email) VALUES
(101, 'Arjun', 'Menon', '123-456-7890', 'arjun.menon@example.com'),
(102, 'Meera', 'Iyer', '987-654-3210', 'meera.iyer@example.com'),
(103, 'Ayaan', 'Das', '111-222-3333', 'ayaan.das@example.com'),
(104, 'Rhea', 'Mitra', '444-555-6666', 'rhea.mitra@example.com'),
(105, 'Varun', 'Patel', '777-888-9999', 'varun.patel@example.com'),
(106, 'Divya', 'Gupta', '999-888-7777', 'divya.gupta@example.com'),
(107, 'Aditya', 'Bhatt', '555-666-7777', 'aditya.bhatt@example.com'),
(108, 'Tanya', 'Roy', '888-777-6666', 'tanya.roy@example.com');



INSERT INTO orders (user_id, delivery_address) VALUES
(1, '45 Galaxy Apartments, Mumbai'),
(2, '78 Green Meadows, Delhi'),
(3, '12 Sunrise Towers, Kolkata'),
(4, '89 Silver Heights, Bengaluru'),
(5, '34 Horizon Plaza, Hyderabad'),
(6, '67 Willow Creek, Pune'),
(7, '90 Orchid Enclave, Chennai'),
(8, '23 Emerald Residency, Jaipur');

-- Joins
-- 1. Inner Join
SELECT o.order_id, u.first_name, i.item_name, oi.quantity, oi.price
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN items i ON oi.item_id = i.item_id;

-- 2. Left Join
SELECT u.first_name, u.last_name, o.order_id, oi.quantity
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id;

-- 3. Right Join
SELECT oi.order_id, i.item_name, c.category_name
FROM order_items oi
RIGHT JOIN items i ON oi.item_id = i.item_id
RIGHT JOIN categories c ON i.category_id = c.category_id;


-- 4. Full Outer Join (Using Union)
SELECT o.order_id, i.item_name
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN items i ON oi.item_id = i.item_id
UNION
SELECT o.order_id, i.item_name
FROM orders o
RIGHT JOIN order_items oi ON o.order_id = oi.order_id
RIGHT JOIN items i ON oi.item_id = i.item_id;


-- 5. Self Join
SELECT u1.first_name AS user_1, u2.first_name AS user_2
FROM users u1, users u2
WHERE u1.user_id <> u2.user_id;


-- Windows Functions
-- 1. Ranking By Reveneue
WITH UserRevenue AS (
    SELECT
        u.first_name,
        SUM(oi.price * oi.quantity) AS total_revenue
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY u.user_id
)
SELECT
    first_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS `rank`
FROM UserRevenue;

-- Cumulative Revenue by Payment Date
SELECT DATE(p.paid_at) AS date, SUM(p.amount) AS daily_revenue,
       SUM(SUM(p.amount)) OVER (ORDER BY DATE(p.paid_at)) AS cumulative_revenue
FROM payments p
GROUP BY DATE(p.paid_at);

-- Row Number for Order
SELECT o.order_id, u.first_name, ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY o.created_at) AS row_num
FROM orders o
JOIN users u ON o.user_id = u.user_id;

-- Percentile Revenue Contribution
SELECT i.item_name, SUM(oi.price * oi.quantity) AS total_revenue,
       PERCENT_RANK() OVER (ORDER BY SUM(oi.price * oi.quantity) DESC) AS percentile
FROM items i
JOIN order_items oi ON i.item_id = oi.item_id
GROUP BY i.item_id;

-- Lag Function for Order Analysis
SELECT o.order_id, o.created_at,
       LAG(o.created_at, 1) OVER (PARTITION BY o.user_id ORDER BY o.created_at) AS previous_order_date
FROM orders o;

-- 1. Total Revenue from All Orders
SELECT SUM(price * quantity) AS total_revenue
FROM order_items;

-- 2. Revenue by Item
SELECT i.item_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
GROUP BY i.item_name
ORDER BY total_revenue DESC;

-- 3. Revenue by Payment Method
SELECT p.payment_method, SUM(p.amount) AS total_revenue
FROM payments p
GROUP BY p.payment_method;

-- 4. Daily Revenue
SELECT DATE(p.paid_at) AS date, SUM(p.amount) AS daily_revenue
FROM payments p
GROUP BY DATE(p.paid_at)
ORDER BY date;

-- 5. Orders and Revenue by User
SELECT
    u.first_name,
    u.last_name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id
ORDER BY total_revenue DESC;

-- 6. Revenue by Category
SELECT c.category_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
JOIN categories c ON i.category_id = c.category_id
GROUP BY c.category_name;

-- 7. Items Ordered by Category
SELECT c.category_name, i.item_name, SUM(oi.quantity) AS total_quantity_ordered
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
JOIN categories c ON i.category_id = c.category_id
GROUP BY c.category_name, i.item_name
ORDER BY total_quantity_ordered DESC;

-- 8. Top Customers by Orders
SELECT
    u.first_name,
    u.last_name,
    COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY total_orders DESC
LIMIT 5;

-- 9. Customer Details with Orders
SELECT
    u.first_name,
    u.last_name,
    u.email,
    o.order_id,
    o.delivery_address,
    SUM(oi.price * oi.quantity) AS total_spent
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN users u ON o.user_id = u.user_id
GROUP BY o.order_id;
