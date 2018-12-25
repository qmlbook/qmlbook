import csv
import json

fp = file('cities.csv', 'r')
reader = csv.DictReader(fp, delimiter=';')
data = []
for row in reader:
    data.append(row)

s = json.dumps(data, indent=4, sort_keys = True)

fp = file('cities.json', 'w')
fp.write(s)





