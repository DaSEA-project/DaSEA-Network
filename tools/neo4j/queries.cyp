
// Get all :Package-nodes that has the <name> equals glib
MATCH (n:Package{name: 'glib'})
RETURN n

// Get all :Package-nodes where the value of the name property occurs at least twice, while also returning the count and which nodes. 
MATCH (n:Package)
WITH n.name AS name, collect(n) AS nodes, count(*) AS count
WHERE count > 1
RETURN name, nodes, count;

// Count all unique versions where pkg name and pkgman is a composite key
MATCH (n:Version)
WITH collect([n.pkg_name, n.pkgman]) AS nodes_list
UNWIND nodes_list AS nodes
RETURN count(nodes);

MATCH (p:Package), (v:Version)
WITH p.name AS name, collect(p) AS nodes, count(*) AS count, collect(v.homepage) as homepage
WHERE count > 1
RETURN name, nodes, count, homepage;

MATCH (n:Version)
WITH n.pkg_name AS name, collect(distinct {n.pkg_name, n.pkgman}) AS nodes, count(*) AS count
WHERE count > 1
RETURN name, nodes, count;


MATCH (n:Version{pkgman: 'FPM'})
WITH n.pkg_name AS name, collect(n) AS nodes, count(*) AS count
WHERE count > 1
RETURN name, nodes, count;

MATCH (n:Version{pkgman: 'fpm'})
WITH collect([n.pkg_name, n.pkgman]) AS nodes
RETURN nodes;

MATCH (n:Version),(m:Package)
WITH collect([n.pkg_name, n.pkgman]) AS nodes
RETURN nodes;



╒══════════════════════════════════════════════════════════════════════╕
│"nodes"                                                               │
╞══════════════════════════════════════════════════════════════════════╡
│[["libdatetime","fpm"],["datetime","fpm"],["iso_varying_string","fpm"]│
│,["jsonff","fpm"],["M_calculator","fpm"],["M_match","fpm"],["M_color",│
│"fpm"],["M_history","fpm"],["M_io","fpm"],["M_msg","fpm"],["M_process"│
│,"fpm"],["M_strings","fpm"],["M_time","fpm"],["quaff","fpm"],["sqlitef│
│f","fpm"],["strff","fpm"],["vegetables","fpm"],["M_draw","fpm"],["M_kr│
│acken95","fpm"],["M_pixel","fpm"],["M_system","fpm"],["pointsets","fpm│
│"],["M_escape","fpm"],["fhash","fpm"],["mctc-gcp","fpm"],["mctc-lib","│
│fpm"],["mstore","fpm"],["s-dftd3","fpm"],["toml-f","fpm"],["M_CLI","fp│
│m"],["M_CLI2","fpm"],["dftd4","fpm"],["multicharge","fpm"],["finterp",│
│"fpm"],["forlab","fpm"],["functional","fpm"],["neural-fortran","fpm"],│
│["fpm","fpm"],["test-drive","fpm"],["nlopt-f","fpm"],["tblite","fpm"],│
│["fftpack","fpm"],["stdlib","fpm"]]                                   │
└──────────────────────────────────────────────────────────────────────┘


╒══════════════════════════════════════════════════════════════════════╕
│"nodes"                                                               │
╞══════════════════════════════════════════════════════════════════════╡
│[["libdatetime","fpm"],["datetime","fpm"],["iso_varying_string","fpm"]│
│,["jsonff","fpm"],["M_calculator","fpm"],["M_match","fpm"],["M_color",│
│"fpm"],["M_history","fpm"],["M_io","fpm"],["M_msg","fpm"],["M_process"│
│,"fpm"],["M_strings","fpm"],["M_time","fpm"],["quaff","fpm"],["sqlitef│
│f","fpm"],["strff","fpm"],["vegetables","fpm"],["M_draw","fpm"],["M_kr│
│acken95","fpm"],["M_pixel","fpm"],["M_system","fpm"],["pointsets","fpm│
│"],["M_escape","fpm"],["fhash","fpm"],["mctc-gcp","fpm"],["mctc-lib","│
│fpm"],["mstore","fpm"],["s-dftd3","fpm"],["toml-f","fpm"],["M_CLI","fp│
│m"],["M_CLI2","fpm"],["dftd4","fpm"],["multicharge","fpm"],["finterp",│
│"fpm"],["forlab","fpm"],["forlab","fpm"],["functional","fpm"],["neural│
│-fortran","fpm"],["fpm","fpm"],["test-drive","fpm"],["nlopt-f","fpm"],│
│["tblite","fpm"],["fftpack","fpm"],["stdlib","fpm"]]                  │
└──────────────────────────────────────────────────────────────────────┘