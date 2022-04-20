import pandas as pd
from glob import glob, iglob
from neo4j import GraphDatabase


def importData(driver):
    dirs = glob("../data/*/", recursive=False)
    for d in dirs:
        print("Importing data from: " + d)
        files = [*iglob(f'{d}/*.csv')]
        if len(files) > 3:
            print(f"{d} has more than 3 files")
            continue

        for file in files:
            pkgman = file.split("/")[-1].split("_")[0]
            abs_file = "/".join(file.split("/")[-2:])
            print(f"Importing {abs_file}")
            if "dependencies" in file:
                df = pd.read_csv(file)
                with driver.session() as session:
                    for index, row in df.iterrows():
                        try:
                            if index % 100 == 0: # Print status every 100 packages
                                print(f"Importing dependency {index}...")
                            session.write_transaction(
                                lambda tx: tx.run(
                                    "MERGE (p_source:Package {name: $source_name, pkgman: $source_pkgman}) "
                                    "MERGE (p_target:Package {name: $target_name, pkgman: $target_pkgman}) "
                                    "MERGE (v_source:Version {version: $source_version, name: $source_name, pkgman: $source_pkgman}) "
                                    "MERGE (v_target:Version {version: $target_version, name: $target_name, pkgman: $source_pkgman}) "
                                    "MERGE (p_source)-[:HAS_VERSION]->(v_source) "
                                    "MERGE (p_target)-[:HAS_VERSION]->(v_target) "
                                    "MERGE (v_source)-[:DEPENDS_ON]->(p_target)",
                                    source_name=row['source_name'],
                                    source_pkgman=pkgman,
                                    target_name=row['target_name'],
                                    target_pkgman=pkgman,
                                    source_version=row['source_version'],
                                    target_version=row['target_version']
                                )
                            )
                        except Exception as e:
                            print(e)
                            continue


def clear_db(driver):
    with driver.session() as session:
        session.run("MATCH (n) DETACH DELETE n")


uri = "bolt://localhost:7687"
driver = GraphDatabase.driver(uri, auth=("neo4j", "admin"))


# main function
if __name__ == "__main__":
    clear_db(driver)
    importData(driver)