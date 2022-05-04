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
                pkgman = fname.split("/")[-1].split("_")[0]
                csv_writer.writerow(
                    (
                        f'package'+idx+pkgman.lower(),
                        name,
                        pkgman,
                        "Package",
                    )
                )


if __name__ == "__main__":
    projects_csv_file = sys.argv[1:]
    main(projects_csv_file)
