import json

f = open("tools/snyk-check/order_by_pckg_managers.json", "r", encoding='utf-8-sig')

data = json.load(f)

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


output_json = [x for x in data if x['url'] not in bad_urls]

json.dump(output_json, open("tools/snyk-check/order_by_pckg_managers_clean.json", "w"), indent=4)
