#!/usr/bin/env bash

echo "The following will take some time! Go do something else..."
echo ""
echo "(1/4) Creating neo_pkg.csv..."
python3 tools/neo4j-import/packages_to_neo.py \
        data/alire/alire_packages_04-29-2022.csv \
        data/cargo/cargo_packages_04-29-2022.csv\
        data/chromebrew/chromebrew_packages_04-29-2022.csv \
        data/clojars/clojars_packages_04-29-2022.csv \
        data/conan/conan_packages_04-29-2022.csv \
        data/fpm/fpm_packages_04-29-2022.csv \
        data/homebrew/homebrew_packages_04-29-2022.csv \
        data/luarocks/luarocks_packages_04-29-2022.csv \
        data/nimble/nimble_packages_03-18-2022.csv \
        data/vcpkg/vcpkg_packages_04-29-2022.csv \
        data/ports/freebsd11/freebsd11_packages_04-28-2022.csv \
        data/ports/netbsd9/netbsd9_packages_04-28-2022.csv \
        data/ports/openbsd69/openbsd69_packages_04-28-2022.csv \
        > data/out/neo_pkg.csv
echo ""
echo "(2/4) Creating neo_ver.csv..."
python3 tools/neo4j-import/version_nodes_to_neo.py \
        data/alire/alire_versions_04-29-2022.csv \
        data/cargo/cargo_versions_04-29-2022.csv\
        data/chromebrew/chromebrew_versions_04-29-2022.csv \
        data/clojars/clojars_versions_04-29-2022.csv \
        data/conan/conan_versions_04-29-2022.csv \
        data/fpm/fpm_versions_04-29-2022.csv \
        data/homebrew/homebrew_versions_04-29-2022.csv \
        data/luarocks/luarocks_versions_04-29-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/vcpkg/vcpkg_versions_04-29-2022.csv \
        data/ports/freebsd11/freebsd11_versions_04-28-2022.csv \
        data/ports/netbsd9/netbsd9_versions_04-28-2022.csv \
        data/ports/openbsd69/openbsd69_versions_04-28-2022.csv \
        > data/out/neo_ver.csv
echo ""
echo "(3/4) Creating version neo_ver_rels.csv..."
python3 tools/neo4j-import/version_rels_to_neo.py \
        data/alire/alire_versions_04-29-2022.csv \
        data/cargo/cargo_versions_04-29-2022.csv\
        data/chromebrew/chromebrew_versions_04-29-2022.csv \
        data/clojars/clojars_versions_04-29-2022.csv \
        data/conan/conan_versions_04-29-2022.csv \
        data/fpm/fpm_versions_04-29-2022.csv \
        data/homebrew/homebrew_versions_04-29-2022.csv \
        data/luarocks/luarocks_versions_04-29-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/vcpkg/vcpkg_versions_04-29-2022.csv \
        data/ports/freebsd11/freebsd11_versions_04-28-2022.csv \
        data/ports/netbsd9/netbsd9_versions_04-28-2022.csv \
        data/ports/openbsd69/openbsd69_versions_04-28-2022.csv \
        > data/out/neo_ver_rels.csv
echo ""
echo "(4/4) Creating dependency neo_deps.csv..."
python3 tools/neo4j-import/deps_to_neo.py \
        data/alire/alire_dependencies_04-29-2022.csv \
        data/cargo/cargo_dependencies_04-29-2022.csv\
        data/chromebrew/chromebrew_dependencies_04-29-2022.csv \
        data/clojars/clojars_dependencies_04-29-2022.csv \
        data/conan/conan_dependencies_04-29-2022.csv \
        data/fpm/fpm_dependencies_04-29-2022.csv \
        data/homebrew/homebrew_dependencies_04-29-2022.csv \
        data/luarocks/luarocks_dependencies_04-29-2022.csv \
        data/nimble/nimble_dependencies_03-18-2022.csv \
        data/vcpkg/vcpkg_dependencies_04-29-2022.csv \
        data/ports/freebsd11/freebsd11_dependencies_04-28-2022.csv \
        data/ports/netbsd9/netbsd9_dependencies_04-28-2022.csv \
        data/ports/openbsd69/openbsd69_dependencies_04-28-2022.csv \
        > data/out/neo_deps.csv

#neo4j stop
#neo4j-admin import \
#            --database=neo4j \
#            --nodes=data/out/neo_pkg.csv \
#            --nodes=data/out/neo_ver.csv \
#            --relationships=data/out/neo_ver_rels.csv \
#            --relationships=data/out/neo_deps.csv \
#            --skip-bad-relationships \
#            --multiline-fields=true \
#            --max-memory=2G \
#            --force
#neo4j start