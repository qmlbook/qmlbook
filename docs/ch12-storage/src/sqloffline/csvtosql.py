import csv
import sqlite3 

db = sqlite3.connect('cities.db')
db.execute('''DROP TABLE IF EXISTS cities''')
db.execute('''CREATE TABLE cities (city text, country text, population text, area text, flag text)''')
db.text_factory = str
fp = file("cities.csv")
r = csv.reader(fp, delimiter=';')
for row in r:
	db.execute('INSERT INTO cities VALUES (?, ?, ?, ?, ?)', row)
db.commit()
db.close()
