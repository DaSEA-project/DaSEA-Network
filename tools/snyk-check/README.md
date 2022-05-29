# Snyk Study

This directory contains a script for extracting package vulnerabilities info from the [Snyk API](https://security.snyk.io/api/listing)

## `snyk_vulnerabilities.py`

> Script to extract vulnerabilities

### How-to use

1. Place the results from the Neo4J extraction of cross-ecosystem packages into the `neo-data` directory
2. From the project root run `python tools/snyk-check/snyk_vulnerabilities.py`.
