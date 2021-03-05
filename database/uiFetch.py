#!/usr/bin/env python3

import sqlite3

def insertCart(conn, prod_id, prod_quantity):
    
    try:
        c = conn.cursor()
        
        c.execute(""" INSERT INTO cartItems
                    (productID, productQuantity)
                    VALUES
                    (?, ?)""", (prod_id, prod_quantity,))
        conn.commit()
    
        print("Cart record succesfully inserted!")

        c.close()    

    except sqlite3.Error as e:
        print("Database failed to insert new values: " + e)


def insertFav(conn, prod_id):
    
    try:
        c = conn.cursor()
        
        c.execute(""" INSERT INTO favouriteItems
                    (productID)
                    VALUES
                    (?)""", (prod_id,))
        conn.commit()
    
        print("Favourites record succesfully inserted!")

        c.close()
    

    except sqlite3.Error as e:
        print("Database failed to insert new values: " + e)
