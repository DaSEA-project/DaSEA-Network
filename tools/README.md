# Tools

This directory contains tools for manipulating data into Neo4j format.

## `neo_bulk_import.sh`

> Tool to import CSV data into Neo4j graph database.

### How-to use

Place data in the `data/`directory. Run `neo_bulk_import.sh`. Takes around 1 minute. Once done - go to http://localhost:7474/browser/ and see data.

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
