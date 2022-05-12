
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

// return distinct pkg_man
MATCH (n:Package)
WITH DISTINCT n.pkgman AS properties
RETURN properties

// return count of unique named packages
MATCH (n:Package)
WITH DISTINCT n.name AS names
RETURN COUNT(names)

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