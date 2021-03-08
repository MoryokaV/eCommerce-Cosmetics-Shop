#!/usr/bin/env python3

import sqlite3
from sqlite3 import Error
import sys
import excelFetch
from tableModels import sql_tables
import uiFetch

conn = None

def initialize(conn):     
    try:
        c = conn.cursor()
        
        #Workaround for inserting id field into an existing table

        c.execute("""CREATE TABLE productsList_copy(id integer primary key
                autoincrement, name TEXT, categoryID INTEGER, manufacter TEXT,
                price REAL, imagePath TEXT, shortDescription TEXT,
                longDescription TEXT)""")

        c.execute("""CREATE TABLE categoriesList_copy(id integer primary key
                autoincrement,name TEXT, imagePath TEXT)""")

        for table in sql_tables:
            c.execute(table)
        
        excelFetch.pull(conn)

        c.execute("""INSERT INTO productsList_copy(name, categoryID, manufacter,
                price, imagePath, shortDescription, longDescription) SELECT
                name, categoryID, manufacter, price, imagePath,
                shortDescription, longDescription FROM productsList""")

        c.execute("""INSERT INTO categoriesList_copy(name, imagePath) SELECT
                name, imagePath FROM categoriesList""")

        c.execute("""DROP TABLE productsList""")
        c.execute("""DROP TABLE categoriesList""")

        c.execute("""ALTER TABLE productsList_copy RENAME TO productsList""")
        c.execute("""ALTER TABLE categoriesList_copy RENAME TO categoriesList""")
        
        print("Initialization was made succesfully!")
        print("Your database is up-to-date")

    except Error as e:
        print("Failed to create table: " + str(e))


def connectDatabase():
    #Establishing  connection
    global conn

    try:
        conn = sqlite3.connect("models.db")

        print("Connection to databse has been established! \n Waiting for queries...")
    except Error as e:
        print("Error on connecting to database: " + e)

def cmdSelector():
    selector = str(sys.argv[1])

    if selector == "init":
       initialize(conn)
    elif selector == "pull":
        excelFetch.pull(conn)
    elif selector == "add":
        selector = str(sys.argv[2])
        if selector == "favourites":
            productID = int(sys.argv[3])
            
            uiFetch.insertFav(conn, productID)
        elif selector == "cart":
            productID = int(sys.argv[3])
            quantity = int(sys.argv[4])
            
            uiFetch.insertCart(conn, productID, quantity)
        else:
            print("add: Invalid args!")
    else:
        print(" - Unknown Command - ")


if __name__ == '__main__':
    connectDatabase()       
    cmdSelector()

conn.commit()
conn.close()
