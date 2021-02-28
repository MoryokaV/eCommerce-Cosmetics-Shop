#!/usr/bin/env python3

import sqlite3
from sqlite3 import Error
import sys
import excelFetch
from tableModels import sql_tables

def initialize(conn):     
    try:
        c = conn.cursor()
        
        for table in sql_tables:
            c.execute(table)
        
        excelFetch.pull(conn)
    except Error as e:
        print("Failed to create table: " + e)


#Establishing  connection
conn = None

try:
    conn = sqlite3.connect("models.db")
except Error as e:
    print("Error on connecting to database: " + e)

selector = str(sys.argv[1])


if selector == "initialize":
   initialize(conn)
elif selector == "pull":
    excelFetch.pull(conn)
elif selector == "add":
    selector = str(sys.argv[2])
    if selector == "favourites":
        productID == str(sys.argv[3])
        #do something
    elif selector == "cart":
        productID = str((sys.argv[3])
        quantity = str(sys.argv[4])
        #do something
    else:
        print("add: Invalid args!")
else:
    print(" - Unknown Command - ")



conn.commit()
conn.close()
