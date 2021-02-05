#!/usr/bin/env python3

import pandas as pd
import sqlite3

db = sqlite3.connect("products.db")
excel = pd.read_excel("list.xlsx", sheet_name = None)

#print(pd.DataFrame(excel))

for sheet in excel:
    excel[sheet].to_sql(sheet, db, index = False)

db.commit()
db.close()
