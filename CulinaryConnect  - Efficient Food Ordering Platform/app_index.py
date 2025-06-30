from flask import Flask, request, jsonify, render_template, url_for
import mysql.connector

app = Flask(__name__)

# Database connection function
def create_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',  # Replace with your MySQL username
        password='YOUR_PASSWORD',  # Replace with your MySQL password
        database='FoodSphereDB'
    )

# Home route
@app.route('/')
def home():
    return render_template('index.html')

# Place an order route
@app.route('/place_order', methods=['POST'])
def place_order():
    connection = None
    cursor = None
    try:
        # Log incoming data
        order_data = request.get_json()
        print("Received order data:", order_data)

        cart = order_data.get('cart')
        address = order_data.get('address')

        if not cart or not address:
            print("Cart or address is missing")
            return jsonify({"error": "Cart is empty or address is missing."}), 400

        # Establish database connection
        connection = create_connection()
        cursor = connection.cursor()

        # Insert order
        cursor.execute("""
            INSERT INTO orders (user_id, delivery_address)
            VALUES (%s, %s)
        """, (1, address))  # Assuming a default user_id = 1
        order_id = cursor.lastrowid
        print("Order ID:", order_id)

        # Insert each item into order_items
        for item in cart:
            item_name = item.get('name')
            quantity = item.get('quantity', 1)  # Default quantity = 1 if missing

            if not item_name or quantity <= 0:
                print(f"Invalid item data: {item}")
                return jsonify({"error": "Invalid item data."}), 400

            cursor.execute("SELECT item_id, price FROM items WHERE item_name = %s", (item_name,))
            result = cursor.fetchone()

            if not result:
                print(f"Item not found: {item_name}")
                return jsonify({"error": f"Item '{item_name}' not found in the database."}), 404

            item_id, price = result
            cursor.execute("""
                INSERT INTO order_items (order_id, item_id, quantity, price)
                VALUES (%s, %s, %s, %s)
            """, (order_id, item_id, quantity, price))

        # Commit transaction
        connection.commit()
        print("Order placed successfully")
        return jsonify({"message": "Order placed successfully!"}), 200

    except mysql.connector.Error as e:
        print("Database error:", e)
        return jsonify({"error": str(e)}), 500

    except Exception as e:
        print("Application error:", e)
        return jsonify({"error": str(e)}), 500

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

# Get all orders route
@app.route('/orders', methods=['GET'])
def get_orders():
    connection = None
    cursor = None
    try:
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute("""
            SELECT o.order_id, o.delivery_address, oi.item_id, oi.quantity, oi.price
            FROM orders o
            JOIN order_items oi ON o.order_id = oi.order_id
        """)
        orders = cursor.fetchall()
        return jsonify({"orders": orders}), 200

    except mysql.connector.Error as e:
        print("Database error:", e)
        return jsonify({"error": str(e)}), 500

    except Exception as e:
        print("Application error:", e)
        return jsonify({"error": str(e)}), 500

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

if __name__ == '__main__':
    app.run(debug=True)
