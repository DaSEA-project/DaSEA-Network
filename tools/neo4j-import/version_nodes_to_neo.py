import csv
import sys
import hashlib


def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = (
        ":ID,pkg_name,pkgman,version,:LABEL,homepage,repo"
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
                    version,
                    _,
                    _,
                    homepage,
                    repo
                ) = row[0:8]
                csv_writer.writerow(
                    (
                        f'version'+idx+pkgman.lower(),
                        name,
                        pkgman,
                        version,
                        "Version",
                        repo,
                        homepage
                    )
                )



if __name__ == "__main__":
    projects_csv_file = sys.argv[1:]
    main(projects_csv_file)
