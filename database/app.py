#!/usr/bin/env python3

from flask import Flask, jsonify
import json
import uiFetch
import databaseHandler

app = Flask(__name__)

json_file = {}

conn = databaseHandler.connectDatabase()

@app.route('/')
def index():
    finder = uiFetch.findProducts(conn, 1) #this i need input for categ arg
    
    print(str(finder))

    return str(finder)
    

if __name__ == '__main__':
    app.run()
