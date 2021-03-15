#!/usr/bin/env python3

import sqlite3

def insertCart(conn, prod_id, prod_quantity):
    try:
        c = conn.cursor()

        c.execute("""SELECT * FROM cartItems WHERE productID=?""",(prod_id,))
        finder = c.fetchone()

        if finder is None:

            c.execute(""" INSERT INTO cartItems
                        (productID, productQuantity)
                        VALUES
                        (?, ?)""", (prod_id, prod_quantity,))
            conn.commit()
        
            print("Cart record succesfully inserted!")

            c.close()    
        else:
            print("Entry already found at: " + str(finder))
            print("Updating the quantity...")

            updateQuantity(conn, prod_id, prod_quantity)
            
            c.close() 

    except sqlite3.Error as e:
        print("Database failed to insert new values: " + str(e))

def insertFav(conn, prod_id):
    
    try:
        c = conn.cursor()
        
        c.execute("""SELECT * FROM favouriteItems WHERE productID=?""",(prod_id,))
        finder = c.fetchone()
        
        if finder is None:
            c.execute(""" INSERT INTO favouriteItems
                        (productID)
                        VALUES
                        (?)""", (prod_id,))
            conn.commit()
        
            print("Favourites record succesfully inserted!")

            c.close()
        else:
            print("Entry already found at: " + str(finder))
            
            c.close() 

    except sqlite3.Error as e:
        print("Database failed to insert new values: " + str(e))

def removeFav(conn, prod_id):
    try:
        c = conn.cursor()
        
        c.execute(""" DELETE FROM favouriteItems 
                    WHERE productID == (?)""", (prod_id,))
        conn.commit()
    
        print("Favourites record succesfully deleted!")

        c.close()
    
    except sqlite3.Error as e:
        print("Database failed to remove values: " + str(e))

def removeItem(conn, prod_id):
    try:
        c = conn.cursor()
        
        c.execute(""" DELETE FROM cartItems 
                    WHERE productID = (?)""", (prod_id,))
        conn.commit()
    
        print("Cart record succesfully deleted!")

        c.close()
    
    except sqlite3.Error as e:
        print("Database failed to remove values: " + str(e))

def updateQuantity(conn, prod_id, quantity):
    if quantity != 0:
        try:
            c = conn.cursor()
            
            c.execute(""" UPDATE cartItems SET productQuantity = (?) WHERE  
                        productID = (?)""", (quantity, prod_id))
            conn.commit()
          
            print("Cart record succesfully updated!")

            c.close()
        
        except sqlite3.Error as e:
            print("Database failed to remove values: " + str(e))
    else:
        print("Quantity is invalid!..Use 'remove cart item' instead")


def findProducts(conn, categ):
    try:
        c = conn.cursor()

        c.execute("""SELECT * FROM products WHERE categoryID=?""",(categ,))

        response = c.fetchall()

        #print(str(response))

        return response

    except sqlite3.Error as e:
        print("Error on finding records: " + str(e))
        
        return None
