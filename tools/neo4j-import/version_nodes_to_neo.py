import csv
import sys
import logging

logging.basicConfig(filename='./example.log', encoding='utf-8', level=logging.DEBUG)

bad_urls =[
    "https://github.com//",
    "http://github.com",
    "https://github.com",
    "https://github.com/",
    "http://example.com",
    "http://github.com/",
    "http://www.google.com",
    "https://example.com",
    "https://",
    "http://google.com",
    "https://google.com",
    "http://www.github.com",
    "http://www.example.com",
    "https://www.google.com",
    "...",
    "https://gitlab.com/",
    "https://www.github.com",
    "http://example.com/",
]

def clean_url(url):
    if url in bad_urls:
        return ""
    return url

def main(fnames):
    csv_writer = csv.writer(sys.stdout)

    header_line = (
        ":ID,uid,pkg_name,pkgman,version,:LABEL,url"
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
                    url = clean_url(repo)
                elif homepage:
                    url = clean_url(homepage)
                if url.endswith(".git"):
                    url = url[:-4]

                csv_writer.writerow(
                    (
                        f'version'+idx+pkgman.lower(),
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
