import csv
import sys


def main(fnames):
    csv_writer = csv.writer(sys.stdout)
    csv.field_size_limit(sys.maxsize)

    header_line = ":START_ID,version,:END_ID,:TYPE"
    print(header_line)
    for fname in fnames:
        pkgman = fname.split("/")[-1].split("_")[0]
        with open(fname) as fp:
            csv_reader = csv.reader(fp, delimiter=",")
            next(csv_reader)  # Skip the header line
            for row in csv_reader:
                try: 
                        (
                            _,
                            source_idx,
                            target_idx,
                            _,
                            _,
                            _,
                            target_version,
                            
                        ) = row[0:7]
                        csv_writer.writerow(
                            (
                                f'version'+source_idx+pkgman.lower(),
                                f'"{target_version}"',
                                f'package'+target_idx+pkgman.lower(),
                                "DEPENDS_ON",
                            )
                        )
                except Exception as e:
                    print(e)
                    continue

if __name__ == "__main__":
    deps_csv_file = sys.argv[1:]
    main(deps_csv_file)
