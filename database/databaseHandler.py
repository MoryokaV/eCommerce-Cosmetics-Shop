#!/usr/bin/env python3

import sqlite3
from sqlite3 import Error
import sys
import excelFetch


#Establishing  connection
conn = None

try:
    conn = sqlite3.connect("products.db")
except Error as e:
    print("Error on connecting to database: " + e)

selector = str(sys.argv[1])


if selector == "pull":
    excelFetch.pull(conn)
else:
    print(" - Unknown Command - ")



conn.commit()
conn.close()
