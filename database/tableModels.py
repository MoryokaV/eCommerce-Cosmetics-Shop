#!/usr/bin/env python3 

import sqlite3

sql_favouriteItems_table = """ CREATE TABLE IF NOT EXISTS favouriteItems (
                                           productID integer NOT NULL
                                    ); """

sql_cartItems_table = """ CREATE TABLE IF NOT EXISTS cartItems (
                                           productID integer NOT NULL,
                                           productQuantity integer NOT NULL
                                    ); """

sql_tables = [sql_favouriteItems_table, sql_cartItems_table]
