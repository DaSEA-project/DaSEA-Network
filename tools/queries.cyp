
// Get all :Package-nodes that has the <name> equals glib
MATCH (n:Package{name: 'glib'})
RETURN n

// Get all :Package-nodes where the value of the name property occurs at least twice, while also returning the count and which nodes. 
MATCH (n:Package)
WITH n.name AS name, collect(n) AS nodes, count(*) AS count
WHERE count > 1
RETURN name, nodes, count;