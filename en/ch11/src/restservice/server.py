#!/usr/bin/env python

from flask import Flask, jsonify, request
import json

colors = json.load(file('colors.json', 'r'))

app = Flask(__name__)

@app.route('/colors', methods = ['GET'])
def get_colors():
    return jsonify( { "data" :  colors })

@app.route('/colors/<name>', methods = ['GET'])
def get_color(name):
    for color in colors:
        if color["name"] == name:
            return jsonify( color )
    return jsonify( { 'error' : True } )


@app.route('/colors', methods= ['POST'])
def create_color():
    print('create color')
    color = {
        'name': request.json['name'],
        'value': request.json['value']
    }
    colors.append(color)
    return jsonify( color ), 201

@app.route('/colors/<name>', methods= ['PUT'])
def update_color(name):
    success = False
    for color in colors:
        if color["name"] == name:
            color['value'] = request.json.get('value', color['value'])
            return jsonify( color )
    return jsonify( { 'error' : True } )

@app.route('/colors/<name>', methods=['DELETE'])
def delete_color(name):
    success = False
    for color in colors:
        if color["name"] == name:
            colors.remove(color)
            return jsonify(color)
    return jsonify( { 'error' : True } )

    
if __name__ == '__main__':
    app.run(debug = True)
    