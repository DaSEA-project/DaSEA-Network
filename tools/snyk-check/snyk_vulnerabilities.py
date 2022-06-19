
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
NVD_API = ""
@dataclass
class PackageWithVulnerabilities():
  name: str
  vulnerabilities: List[any]

# Find Snyk vulnerabilities
def _check_pkg_vulnerabilities_snyk(pkg_name):
  # Get vulnerabilities
  url = SNYK_REGISTRY.format(pkg_name=pkg_name)
  r = requests.get(url, headers=HEADERS)
  if r.status_code == 200:
    data = r.json()['vulnerabilities']
    print(data)

    # return data


def main():
  cross_ecosystem_packages = []

  # Opening JSON file
  with open('./order_by_pckg_managers_clean.json', encoding='utf-8-sig') as json_file:
      data = json.load(json_file)
      # for i in range(len(data)):
      #   cross_ecosystem_packages = cross_ecosystem_packages + data[i]['names']
      for i in range(len(data)):
        if i == 2:
          break
        cross_ecosystem_packages.append(data[i])

  print(cross_ecosystem_packages)
  # with open('neo-data/order_by_pckg_managers.json', encoding='utf-8-sig') as json_file:
  #     data = json.load(json_file)
  #     for i in range(len(data)):
  #       for j in range(len(data[i]['names'])):
  #         pkg_name = data[i]['names'][j]['name']
  #         pkg_manager = data[i]['names'][j]['pkgman']
  #         if(pkg_manager == "clojars"):
  #           packages_with_vulnerabilities.append(pkg_name)

  # printing list data
  print('Packages:', len(cross_ecosystem_packages))
  for package in cross_ecosystem_packages:
    packages_with_vulnerabilities = []
    # print(package)
    pkg_url = package['url']
    print('Package:', pkg_url)
    pkg_names_mapping = package['names']
    # print('Package exists as', pkg_names_mapping)
    for pkg in pkg_names_mapping:
      print('Vulnerabilities:')
      print('Package name:', pkg['name'])
      print('Package manager:', pkg['pkgman'])
      package = PackageWithVulnerabilities(pkg['name'], _check_pkg_vulnerabilities_snyk(pkg['name']))
      packages_with_vulnerabilities.append(package)
      print('\n')


if __name__ == "__main__":
    main()
