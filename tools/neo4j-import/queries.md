# Cypher Queries

## Get all :Package-nodes that has the \<name> equals glib

```sql
MATCH (n:Package{name: 'glib'})
RETURN n.pkgman
```

## Get all :Package-nodes where the value of the name property occurs at least twice, while also returning which package manager they are in

```sql
MATCH (n:Package)
WITH n.name AS name, collect(n.pkgman) AS pkgmans, COUNT(*) AS count
WHERE count > 1
RETURN name, pkgmans;
```

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url, COLLECT(DISTINCT(n.pkgman)) AS pkgmans
WHERE size(pkgmans) > 1 AND url IS NOT NULL
RETURN names, url;
```

```sql
CALL {
    MATCH (n:Version)
    WITH COLLECT(distinct(n.uid)) as ids ,n.url AS urls, COLLECT(DISTINCT(n.pkgman)) AS pkgmans
    WHERE size(pkgmans) > 1 AND urls IS NOT NULL
    RETURN urls as uniq_urls, ids as ids
}
return uniq_urls, ids;
```

## Count all unique versions where pkg_name and pkgman is a composite key

```sql
MATCH (n:Version)
WITH collect([n.pkg_name, n.pkgman]) AS nodes_list
UNWIND nodes_list AS nodes
RETURN count(nodes);
```

## Return all distinct pkg_man

```sql
MATCH (n:Package)
WITH DISTINCT n.pkgman AS properties
RETURN properties
```

## Return count of unique named packages

```sql
MATCH (n:Package)
WITH DISTINCT n.name AS names
RETURN COUNT(names)
```

## Return distinct homepages for :Packages

```sql
MATCH (n:Package{name: 'emoji'}) --> (v:Version)
WITH DISTINCT v.homepage AS homepages
RETURN homepages
```

## Count of unique names

```sql
MATCH (n:Person)
CALL {
    WITH n.name AS name, collect(n.pkgman) AS pkgmans, COUNT(*) AS count
    WHERE count > 1
    RETURN name, pkgmans;
}
RETURN count(n)
```

## Playground

```sql
MATCH (n:Package) --> (v:Version)
WITH v.repo AS repo, collect(n) AS nodes, count(*) AS count
WHERE count > 1 AND repo IS NOT NULL
RETURN repo, nodes, count;

MATCH (n:Package) --> (v:Version)
WITH v.repo AS repo
WHERE repo IS NOT NULL
RETURN repo;


MATCH (n:Package{name: 'emoji'}) --> (v:Version)
WITH  v.homepage AS homepages, v.repo as repos
UNWIND homepages + repos as combinedurls
RETURN combinedurls


MATCH (n:Package)
WITH n.name AS name, collect(n.pkgman) AS pkgmans, COUNT(*) AS count
WHERE count > 7
CALL {
    WITH name
    MATCH (v:Version{pkg_name: name})
    WITH DISTINCT v.homepage AS homepages
    return homepages
}
UNWIND pkgmans AS pmans
RETURN name, homepages, pmans;
```

## GET package name with package manager combination for matching urls:

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url
WHERE size(names) > 1 AND url IS NOT NULL
RETURN names, url;
```

## Get also total packages count for the matching url:

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url
WHERE size(names) > 1 AND url IS NOT NULL
RETURN names, url, size(names) as total_pkgs;
```

## Take only for more than 1 ecosystem

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url, COLLECT(DISTINCT(n.pkgman)) AS pkgmans
WHERE size(pkgmans) > 1 AND url IS NOT NULL
RETURN names, url, pkgmans, size(names) as total_pkgs;
```

## Order by most packages

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url, COLLECT(DISTINCT(n.pkgman)) AS pkgmans
WHERE size(pkgmans) > 1 AND url IS NOT NULL
RETURN names, url, pkgmans, size(names) as total_pkgs
ORDER BY total_pkgs DESC;
```

## Check for specific cross-ecosystem package url

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url
WHERE url contains "https://github.com/Dav1dde/glad"
RETURN names, url;
```

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url
WHERE url contains "https://github.com/nayuki/"
RETURN names, url;
```

```sql
MATCH (n:Version)
WITH COLLECT(DISTINCT({name: n.pkg_name, pkgman: n.pkgman})) AS names, n.url AS url
WHERE url contains "https://github.com/gflags/gflags"
RETURN names, url;
```
