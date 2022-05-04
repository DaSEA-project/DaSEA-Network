"""
This script loads in data from a csv that contain data about what packages refer to other packages that
do not exist in the current ecosystem. Prints result to stdout for now.
"""
import pandas as pd
from neo4j import GraphDatabase

def load_csv_data(path):
    df = pd.read_csv(path)
    target_name_pkgs = df['target_name']
    unique_target_name_pkgs = set(target_name_pkgs)
    return [s.strip() for s in set(unique_target_name_pkgs)]

def check_if_pkg_exists(pkg_name, driver_session):
        result = driver_session.run(
            "MATCH (pkg:Package {name: $name}) RETURN pkg.pkgman",
            name=pkg_name
        )
        return result.data()


def main():
    csv_files = [
        'data/research/alire_output.csv',
        'data/research/luarocks_output.csv',
        'data/research/nimble_output.csv',
        'data/research/openbsd_output.csv',
    ]
    uri = "bolt://localhost:7687"
    driver = GraphDatabase.driver(uri, auth=("neo4j", "admin"))
    d = []
    with driver.session() as session:
        for csv_file in csv_files:
            pkgman = csv_file.split("/")[-1].split("_")[0]
            packages = load_csv_data(csv_file)
            for package in packages:
                result = check_if_pkg_exists(package, session)
                if result:
                    print(f'{package} does not exist in {pkgman}, but exists in:')
                    print(result)
                    d.append(result)
                    print()
                    print()


if __name__ == "__main__":
    main()
    