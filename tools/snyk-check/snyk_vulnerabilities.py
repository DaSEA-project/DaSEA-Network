
# importing module
from dataclasses import dataclass
from typing import List
from pandas import *
import requests
import json

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
  print(r.status_code)
  if r.status_code == 200:
    data = r.json()['vulnerabilities']
    print(data)
    return data


def main():
  packages_with_vulnerabilities = []
  # reading CSV file
  # data = read_csv("neo-data/order_by_pckg_managers.csv")

  # Opening JSON file
  with open('neo-data/order_by_pckg_managers.json', encoding='utf-8-sig') as json_file:
      data = json.load(json_file)
      for i in range(len(data)):
        packages_with_vulnerabilities = packages_with_vulnerabilities + data[i]['names']


  # with open('neo-data/order_by_pckg_managers.json', encoding='utf-8-sig') as json_file:
  #     data = json.load(json_file)
  #     for i in range(len(data)):
  #       for j in range(len(data[i]['names'])):
  #         pkg_name = data[i]['names'][j]['name']
  #         pkg_manager = data[i]['names'][j]['pkgman']
  #         if(pkg_manager == "clojars"):
  #           packages_with_vulnerabilities.append(pkg_name)

  # printing list data
  print('Packages:', len(packages_with_vulnerabilities))
  # for package in packages_with_vulnerabilities:
  #   pkg_name = package['name']
  #   print('Package:', pkg_name)
  #   print('Vulnerabilities:')
  #   package = PackageWithVulnerabilities(pkg_name, _check_pkg_vulnerabilities(pkg_name))
  #   packages_with_vulnerabilities.append(package)
  #   print('\n')


if __name__ == "__main__":
    main()
