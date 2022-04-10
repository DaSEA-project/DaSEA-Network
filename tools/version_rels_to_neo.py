import csv
import sys
import hashlib


def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = ":START_ID,:END_ID,:TYPE"
    print(header_line)
    for fname in fnames:
        pkgman = fname.split("/")[-1].split("_")[0]
        with open(fname) as fp:
            csv_reader = csv.reader(fp, delimiter=",")
            next(csv_reader)  # Skip the header line
            for row in csv_reader:
                (
                    idx,
                    pkg_idx,
                    
                ) = row[0:2]
                
                csv_writer.writerow(
                    (
                        generateFixedHash('package'+pkg_idx+pkgman.lower()),
                        generateFixedHash('version'+idx+pkgman.lower()),
                        "HAS_VERSION",
                    )
                )

def generateFixedHash(value):
    encoded = value.encode("utf-8")
    hash_object = hashlib.sha256(encoded)
    hex_dig = hash_object.hexdigest()
    return hex_dig

if __name__ == "__main__":
    deps_csv_file = sys.argv[1:]
    main(deps_csv_file)
