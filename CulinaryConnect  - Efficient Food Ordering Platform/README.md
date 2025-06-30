# OrderSphere - Efficient Food Ordering Platform

## Overview

OrderSphere is a dynamic and user-friendly web application for ordering a wide range of delicious dishes. It features a responsive frontend and a powerful Flask-based backend, making it easy for users to browse, add items to their cart, and place orders seamlessly. Additionally, it includes MySQL database integration for order management.

---

## Features

### User Features
1. Browse dishes by categories:
   - Veg Dishes
   - Non-Veg Dishes
   - Egg Dishes
   - Starters
   - Desserts
2. Add items to the cart with a single click.
3. View and manage cart items.
4. Place orders with a specified delivery address.
5. Get real-time feedback after placing an order.

### Admin Features
1. Manage order data stored in a MySQL database.
2. Access and retrieve all placed orders with details like item quantity, price, and delivery address.

---

## Requirements

### Software
1. Python 3.x
2. MySQL Server

### Python Libraries
- Flask
- mysql-connector-python

---

## Setup Instructions

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd order-sphere
````

### Step 2: Install Dependencies

Install the required Python libraries:

```bash
pip install -r requirements.txt
```

### Step 3: Configure the MySQL Database

1. Create a MySQL database (e.g., `FoodSphereDB`).
2. Use the following schema to set up the database:

```sql
CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    delivery_address VARCHAR(255),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
```

3. Update the `create_connection` function in `app_index.py` with your MySQL credentials:

```python
def create_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',  # Replace with your MySQL username
        password='YOUR_PASSWORD',  # Replace with your MySQL password
        database='FoodSphereDB'
    )
```

### Step 4: Run the Backend

Start the Flask application:

```bash
python app_index.py
```

### Step 5: Launch the Frontend

1. Open your browser and navigate to `http://127.0.0.1:5000/`.
2. Explore the app, add items to your cart, and place orders.

---

## Project Files

### Backend

1. `app_index.py`: Contains the Flask backend for handling API requests.
2. `requirements.txt`: Lists all required Python libraries.

### Frontend

1. `index.html`: The main HTML page for the Order Sphere web app.
2. `static/`: Contains images and CSS for the app.

### Database

1. MySQL database with tables for items, orders, and order items.

---

## Output

1. **Order Confirmation**: Users receive real-time feedback after placing an order.
2. **Database Integration**: Orders and their details are stored in a MySQL database for future reference.

---

## Future Enhancements

1. **User Authentication**: Add login and signup functionality.
2. **Order History**: Enable users to view past orders.
3. **Admin Panel**: Provide an interface for admins to manage items and view analytics.
4. **Advanced Visualizations**: Use Power BI or another visualization tool to analyze sales and customer data.
