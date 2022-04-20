import csv
import sys
import hashlib


def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = (
        ":ID,pkg_name,version,:LABEL"
    )
    print(header_line)
    for fname in fnames:
        pkgman = fname.split("/")[-1].split("_")[0]
        with open(fname) as fp:
            csv_reader = csv.reader(fp, delimiter=",")
            next(csv_reader)  # Skip the header line
            for row in csv_reader:
                (
                    idx,
                    _,
                    name,
                    version
                ) = row[0:4]
                csv_writer.writerow(
                    (
                        generateFixedHash('version'+idx+pkgman.lower()),
                        name,
                        version,
                        "Version"
                    )
                )

def generateFixedHash(value):
    encoded = value.encode("utf-8")
    hash_object = hashlib.sha256(encoded)
    hex_dig = hash_object.hexdigest()
    return hex_dig


if __name__ == "__main__":
    projects_csv_file = sys.argv[1:]
    main(projects_csv_file)
