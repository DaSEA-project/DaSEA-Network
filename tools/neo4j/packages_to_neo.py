import csv
import sys
import hashlib


def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = (
        ":ID,name,pkgman,:LABEL"
    )
    print(header_line)
    for fname in fnames:
        with open(fname) as fp:
            csv_reader = csv.reader(fp, delimiter=",")
            next(csv_reader)  # Skip the header line
            for row in csv_reader:
                (
                    idx,
                    name,
                    pkgman
                ) = row[0:3]
                csv_writer.writerow(
                    (
                        generateFixedHash('package'+idx+pkgman.lower()),
                        name,
                        pkgman,
                        "Package",
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
