![](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)


# DaSEA Network
This code library aims to assist researchers in investigating cross-dependencies with a set of tools. These tools can be used to process and analyse the DaSEA dataset.

# Tools 

The `tools/` directory contains various tools to process and analyse the DaSEA dataset, that are describe below.

## [case-links](https://github.com/DaSEA-project/DaSEA-Network/tree/main/tools/case-links)

Use this tool to get all dependency links to missing packages within the same ecosystem.

## [neo4j-cross](https://github.com/DaSEA-project/DaSEA-Network/tree/main/tools/neo4j-cross)

This tool uses combined version information from all available ecosystems to determine if a package exists in more than one ecosystem based on the source code URL. 

## [neo4j-import](https://github.com/DaSEA-project/DaSEA-Network/tree/main/tools/neo4j-import)

This tool combines data from the DaSEA dataset into a format that can be imported into Neo4j.

## [snyk-check](https://github.com/DaSEA-project/DaSEA-Network/tree/main/tools/snyk-check)

_TBA_

# Data
Get the latest dataset from [dasea.org](https://dasea-project.github.io/DASEA/) or generate new datasets with the [DaSEA-Tool](https://github.com/DaSEA-project/DASEA) and place it in the data folder. Be aware that paths in scripts may vary from your operating system.

# Requirements

**Important:** Install Neo4j from [here](https://neo4j.com/docs/operations-manual/current/installation/)

Jupyter notebook install:
```
pip install notebook
```



# Copyright
GNU AFFERO GENERAL PUBLIC LICENSE
Version 3, 19 November 2007

Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/> 

Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.
