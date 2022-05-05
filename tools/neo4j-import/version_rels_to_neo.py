import csv
import sys

def unfussy_reader(csv_reader):
    while True:
        try:
            yield next(csv_reader)
        except csv.Error:
            continue

def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = ":START_ID,:END_ID,:TYPE"
    print(header_line)
    for fname in fnames:
        pkgman = fname.split("/")[-1].split("_")[0]
        with open(fname) as fp:
            csv_reader = csv.reader(fp, delimiter=",")
            next(csv_reader)  # Skip the header line
            reader = unfussy_reader(csv_reader)
            for row in reader:
                try:
                    (
                        idx,
                        pkg_idx
                    ) = row[0:2]
                except:
                    continue
                csv_writer.writerow(
                    (
                        f'package'+pkg_idx+pkgman.lower(),
                        f'version'+idx+pkgman.lower(),
                        "HAS_VERSION",
                    )
                )
            


if __name__ == "__main__":
    deps_csv_file = sys.argv[1:]
    main(deps_csv_file)
