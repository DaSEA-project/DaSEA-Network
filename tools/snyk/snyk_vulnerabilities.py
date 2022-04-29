
# importing module
from pandas import *
import requests

HEADERS = {
    "User-Agent": "DaSEA Research Project (Please don't ban, https://dasea.org)",
    "From": "daseaITU@gmail.com",
}
SNYK_REGISTRY = "https://security.snyk.io/api/listing?search={pkg_name}&type=any"



# Find vulnerabilities
def _check_pkg_vulnerabilities(pkg_name):
  # Get vulnerabilities
  url = SNYK_REGISTRY.format(pkg_name=pkg_name)
  r = requests.get(url, headers=HEADERS)
  print(r.status_code)
  print(r.json())

  return r.json()


def main():
  # reading CSV file
  data = read_csv("data/research/pkg_in_multiple_ecosytems.csv")

  # converting column data to list
  package_names = data['name'].tolist()

  # printing list data
  print('Packages:', package_names)
  for package in package_names:
    print('Package:', package)
    print('Vulnerabilities:')
    _check_pkg_vulnerabilities(package)
    print('\n')


if __name__ == "__main__":
    main()
