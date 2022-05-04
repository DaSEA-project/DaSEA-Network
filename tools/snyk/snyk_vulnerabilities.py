
# importing module
from dataclasses import dataclass
from typing import List
from pandas import *
import requests

HEADERS = {
    "User-Agent": "DaSEA Research Project (Please don't ban, https://dasea.org)",
    "From": "daseaITU@gmail.com",
}
SNYK_REGISTRY = "https://security.snyk.io/api/listing?search={pkg_name}&type=any"

@dataclass
class PackageWithVulnerabilities():
  name: str
  vulnerabilities: List[any]

# Find vulnerabilities
def _check_pkg_vulnerabilities(pkg_name):
  # Get vulnerabilities
  url = SNYK_REGISTRY.format(pkg_name=pkg_name)
  r = requests.get(url, headers=HEADERS)

  return r.json()['vulnerabilities']


def main():
  packages_with_vulnerabilities = []
  # reading CSV file
  data = read_csv("tools/neo4j/export.csv")

  # converting column data to list
  package_names = data['name'].tolist()

  # printing list data
  print('Packages:', package_names)
  for pkg_name in package_names:
    print('Package:', pkg_name)
    print('Vulnerabilities:')
    package = PackageWithVulnerabilities(pkg_name, _check_pkg_vulnerabilities(pkg_name))
    packages_with_vulnerabilities.append(package)
    print('\n')


if __name__ == "__main__":
    main()
