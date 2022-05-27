import csv
import sys
import logging

logging.basicConfig(filename='./example.log', encoding='utf-8', level=logging.DEBUG)

def unfussy_reader(csv_reader):
    yield next(csv_reader)

def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = (
        ":ID,pkg_name,pkgman,version,:LABEL,url"
    )
    print(header_line)
    for fname in fnames:
        pkgman = fname.split("/")[-1].split("_")[0]
        with open(fname) as fp:
            csv_reader = csv.reader((x.replace('\0', '') for x in fp), delimiter=",")
            next(csv_reader)  # Skip the header line
            for row in csv_reader:
                try:
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
                except ValueError as e:
                    logging.DEBUG(e)
                    raise e
                url = ""
                if repo:
                    url = repo
                elif homepage:
                    url = homepage
                csv_writer.writerow(
                    (
                        f'version'+idx+pkgman.lower(),
                        name,
                        pkgman.lower(),
                        version,
                        "Version",
                        url
                    )
                )



if __name__ == "__main__":
    projects_csv_file = sys.argv[1:]
    main(projects_csv_file)
