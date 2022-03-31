# Tools

This directory contains tool related to the DaSEA Network.

## `neo_import.py`

> Tool to import CSV data into Neo4j graph database.

### How-to use
1) Install [Neo4j community server](https://neo4j.com/download-center/#community) for your OS. Add the path to the bin-folder to your $PATH.
2) In terminal, make sure the Neo4j server has started, by running the command `neo4j start`. It might take some seconds before it is ready.
3) Go to http://localhost:7474/ to ensure server has started successfully. You should be redirected to http://localhost:7474/browser
4) To import data, place CSV-files in the `import`-folder of your Neo4j-installation. Only dependency-files are required. See example below. Make sure that the files has _dependencues_ in its name.
5) Run the script `nep_import.py`. The script will print out every 100 iteration.

```
neo4j-community-4.4.4/
├── import/
│   ├── conan/
|   |   └── dependencies.csv
|   ├── vcpkg/
|   |   └── dependencies.csv
|   └── fpm/
|       └── dependencies.csv
└── bin/
    └── ...
```