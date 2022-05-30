# Tools

This directory contains tools for manipulating data into Neo4j format.

## `neo_bulk_import.sh`

> Tool to import CSV data into Neo4j graph database.

### How-to use

1. Install Neo4j community server for your OS. Add the path to the bin-folder to your $PATH.
   a. Also make sure you have the latest version of Java Runtime installed.
2. Place data in the `dasea_data/`directory and correct file paths in `neo_bulk_import.sh` if necessary.
3. From the project root run `bash tools/neo4j-import/neo_bulk_import.sh`. Takes around 20 minutes.
4. Once done - go to http://localhost:7474/browser/ and explore data. Example queries can be found [here](https://github.com/DaSEA-project/DaSEA-Network/blob/main/tools/neo4j-import/queries.md).

```
DaSEA-Network
├── data/
│   ├── conan/
|   |   └── xyz
|   ├── vcpkg/
|   |   └── xyz
|   └── fpm/
|       └── xyz
└── tools/
    └── neo_bulk_import.sh
```
