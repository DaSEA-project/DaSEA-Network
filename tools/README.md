# Tools

This directory contains tools for manipulating data into Neo4j format.

## `neo_bulk_import.sh`

> Tool to import CSV data into Neo4j graph database.

### How-to use

1. Install Neo4j community server for your OS. Add the path to the bin-folder to your $PATH.
2. Place data in the `data/`directory.
3. Run `neo_bulk_import.sh`. Takes around 1 minute.
4. Once done - go to http://localhost:7474/browser/ and explore data.

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
