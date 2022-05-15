
// Get all :Package-nodes that has the <name> equals glib
MATCH (n:Package{name: 'glib'})
RETURN n.pkgman

// Get all :Package-nodes where the value of the name property occurs at least twice, while also returning which package manager they are in
MATCH (n:Package)
WITH n.name AS name, collect(n.pkgman) AS pkgmans, COUNT(*) AS count
WHERE count > 1
RETURN name, pkgmans;

// Count all unique versions where pkg name and pkgman is a composite key
MATCH (n:Version)
WITH collect([n.pkg_name, n.pkgman]) AS nodes_list
UNWIND nodes_list AS nodes
RETURN count(nodes);

// return all distinct pkg_man
MATCH (n:Package)
WITH DISTINCT n.pkgman AS properties
RETURN properties

// return count of unique named packages
MATCH (n:Package)
WITH DISTINCT n.name AS names
RETURN COUNT(names)

// return distinct homepages for :Packages
MATCH (n:Package{name: 'emoji'}) --> (v:Version)
WITH DISTINCT v.homepage AS homepages
RETURN homepages



MATCH (n:Package)
WITH n.name AS name, collect(n.pkgman) AS pkgmans, count(*) AS count WHERE count > 1
CALL {
    WITH p
    MATCH (p)-->(v:Version)
    WITH DISTINCT v.homepage AS homepages
    RETURN homepages
}
WHERE homepageCount = 1
RETURN name, pkgmans;



////////////////////////////
// NON IDENTIFIED QUERIES //
////////////////////////////

MATCH (n:Package) --> (v:Version)
WITH v.repo AS repo, collect(n) AS nodes, count(*) AS count
WHERE count > 1 AND repo IS NOT NULL
RETURN repo, nodes, count;

MATCH (n:Package) --> (v:Version)
WITH v.repo AS repo
WHERE repo IS NOT NULL
RETURN repo;

// count of unique names
MATCH (n:Person)
CALL {
    WITH n.name AS name, collect(n.pkgman) AS pkgmans, COUNT(*) AS count
    WHERE count > 1
    RETURN name, pkgmans;
}
RETURN count(n)


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