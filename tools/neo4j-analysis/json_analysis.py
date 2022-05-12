import json
import codecs
import csv
import pandas as pd

NEO_VER_CSV = 'data/out/neo_ver.csv'
NEO_OUT_JSON = 'data/input/records.json'
df = pd.read_csv(NEO_VER_CSV)

def get_csv_data(file_path):
    with open(file_path) as f:
        data = csv.reader(f)
    return data

jsonData = json.load(codecs.open('data/input/records.json', 'r', 'utf-8-sig'))
# csv_reader = csv.reader(NEO_VER_CSV, delimiter=",")

# for row in jsonData:
#     print(f'{row["name"]} {row["pkgmans"]}')
#     for pkgman in row["pkgmans"]:
#         pass
    
df2 = df[df['pkg_name'] == 'airspy']
print(df2)