#!/usr/bin/env bash

echo "The following will take some time! Go do something else..."
echo ""
echo "(1/4) Creating neo_pkg.csv..."
# python3 tools/neo4j-import/packages_to_neo.py \
#         dasea_data/alire/alire_packages_05-17-2022.csv \
#         dasea_data/cargo/cargo_packages_05-17-2022.csv\
#         dasea_data/chromebrew/chromebrew_packages_05-17-2022.csv \
#         dasea_data/clojars/clojars_packages_05-19-2022.csv \
#         dasea_data/conan/conan_packages_05-17-2022.csv \
#         dasea_data/fpm/fpm_packages_05-17-2022.csv \
#         dasea_data/homebrew/homebrew_packages_05-17-2022.csv \
#         dasea_data/luarocks/luarocks_packages_05-17-2022.csv \
#         dasea_data/nimble/nimble_packages_05-17-2022.csv \
#         dasea_data/npm/npm_packages_05-17-2022.csv \
#         dasea_data/rubygems/rubygems_packages_05-17-2022.csv \
#         dasea_data/vcpkg/vcpkg_packages_05-17-2022.csv \
#         dasea_data/ports/freebsd12/freebsd12_packages_05-17-2022.csv \
#         dasea_data/ports/netbsd9/netbsd9_packages_05-17-2022.csv \
#         dasea_data/ports/openbsd69/openbsd69_packages_05-17-2022.csv \
#         > tools/neo4j-import/out/neo_pkg.csv
echo ""
echo "(2/4) Creating neo_ver.csv..."
python3 tools/neo4j-import/version_nodes_to_neo.py \
        dasea_data/alire/alire_versions_05-17-2022.csv \
        dasea_data/cargo/cargo_versions_05-17-2022.csv\
        dasea_data/chromebrew/chromebrew_versions_05-17-2022.csv \
        dasea_data/clojars/clojars_versions_05-19-2022.csv \
        dasea_data/conan/conan_versions_05-17-2022.csv \
        dasea_data/fpm/fpm_versions_05-17-2022.csv \
        dasea_data/homebrew/homebrew_versions_05-17-2022.csv \
        dasea_data/luarocks/luarocks_versions_05-17-2022.csv \
        dasea_data/nimble/nimble_versions_05-17-2022.csv \
        dasea_data/rubygems/rubygems_versions_05-17-2022.csv \
        dasea_data/vcpkg/vcpkg_versions_05-17-2022.csv \
        dasea_data/npm/npm_versions_05-17-2022.csv \
        dasea_data/ports/freebsd12/freebsd12_versions_05-17-2022.csv \
        dasea_data/ports/netbsd9/netbsd9_versions_05-17-2022.csv \
        dasea_data/ports/openbsd69/openbsd69_versions_05-17-2022.csv \
        > tools/neo4j-import/out/neo_ver.csv
echo ""
echo "(3/4) Creating version neo_ver_rels.csv..."
# python3 tools/neo4j-import/version_rels_to_neo.py \
#         dasea_data/alire/alire_versions_05-17-2022.csv \
#         dasea_data/cargo/cargo_versions_05-17-2022.csv\
#         dasea_data/chromebrew/chromebrew_versions_05-17-2022.csv \
#         dasea_data/clojars/clojars_versions_05-19-2022.csv \
#         dasea_data/conan/conan_versions_05-17-2022.csv \
#         dasea_data/fpm/fpm_versions_05-17-2022.csv \
#         dasea_data/homebrew/homebrew_versions_05-17-2022.csv \
#         dasea_data/luarocks/luarocks_versions_05-17-2022.csv \
#         dasea_data/nimble/nimble_versions_05-17-2022.csv \
#         dasea_data/npm/npm_versions_05-17-2022.csv \
#         dasea_data/rubygems/rubygems_versions_05-17-2022.csv \
#         dasea_data/vcpkg/vcpkg_versions_05-17-2022.csv \
#         dasea_data/ports/freebsd12/freebsd12_versions_05-17-2022.csv \
#         dasea_data/ports/netbsd9/netbsd9_versions_05-17-2022.csv \
#         dasea_data/ports/openbsd69/openbsd69_versions_05-17-2022.csv \
#         > tools/neo4j-import/out/neo_ver_rels.csv
echo ""
echo "(4/4) Creating dependency neo_deps.csv..."
# python3 tools/neo4j-import/deps_to_neo.py \
#         dasea_data/alire/alire_dependencies_05-17-2022.csv \
#         dasea_data/cargo/cargo_dependencies_05-17-2022.csv\
#         dasea_data/chromebrew/chromebrew_dependencies_05-17-2022.csv \
#         dasea_data/clojars/clojars_dependencies_05-19-2022.csv \
#         dasea_data/conan/conan_dependencies_05-17-2022.csv \
#         dasea_data/fpm/fpm_dependencies_05-17-2022.csv \
#         dasea_data/homebrew/homebrew_dependencies_05-17-2022.csv \
#         dasea_data/luarocks/luarocks_dependencies_05-17-2022.csv \
#         dasea_data/nimble/nimble_dependencies_05-17-2022.csv \
#         dasea_data/npm/npm_dependencies_05-17-2022.csv \
#         dasea_data/rubygems/rubygems_dependencies_05-17-2022.csv \
#         dasea_data/vcpkg/vcpkg_dependencies_05-17-2022.csv \
#         dasea_data/ports/freebsd12/freebsd12_dependencies_05-17-2022.csv \
#         dasea_data/ports/netbsd9/netbsd9_dependencies_05-17-2022.csv \
#         dasea_data/ports/openbsd69/openbsd69_dependencies_05-17-2022.csv \
#         > tools/neo4j-import/out/neo_deps.csv

neo4j stop
# neo4j-admin import \
#            --database=neo4j \
#            --nodes=tools/neo4j-import/out/neo_pkg.csv \
#            --nodes=tools/neo4j-import/out/neo_ver.csv \
#            --relationships=tools/neo4j-import/out/neo_ver_rels.csv \
#            --relationships=tools/neo4j-import/out/neo_deps.csv \
#            --skip-bad-relationships \
#            --multiline-fields=true \
#            --max-memory=2G \
#            --force
# neo4j start

neo4j-admin import \
           --database=neo4j \
           --nodes=tools/neo4j-import/out/neo_ver.csv \
           --multiline-fields=true \
           --max-memory=2G \
           --force
neo4j start