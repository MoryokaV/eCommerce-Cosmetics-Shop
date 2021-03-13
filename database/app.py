#!/usr/bin/env python3

from flask import Flask, jsonify, request
import json
import uiFetch
import databaseHandler

app = Flask(__name__)

json_file = {}

conn = databaseHandler.connectDatabase()


@app.route('/')
def index():
    return "API designed for connecting Python backend with Flutter App - Code by Vlaviano"

@app.route('/find')
def finder():
    productID = request.args['productID']
    
    output = uiFetch.findProducts(conn, int(productID)) #this i need input for categ arg
    
    #print(str(output))
    #print(type(output)) #list
        
    return jsonify(output) 

if __name__ == '__main__':
    app.run(host = '192.168.0.163')
