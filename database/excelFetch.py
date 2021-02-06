#!/usr/bin/env python3

import pandas as pd
import sqlite3
from sqlite3 import Error

def createTable(conn, table):
    try:
        c = conn.cursor()

        c.execute(table)
    except Error as e:
        print("Failed to create table: " + e)

def pull(conn):

    excel = pd.read_excel("list.xlsx", sheet_name = None)

    #print(pd.DataFrame(excel))

    for sheet in excel:
        #excel[sheet].dropna(how = 'any', axis = 0) # delete all the null records ... doesn't work 

        excel[sheet].to_sql(sheet, conn, index = False, if_exists = 'replace')
        
        #print(type(excel[sheet]))
        #print(sheet)

    sql_create_favouriteItems_table = """ CREATE TABLE IF NOT EXISTS favouriteItems (
                                           productID integer NOT NULL
                                        ); """ 

    createTable(conn, sql_create_favouriteItems_table)


