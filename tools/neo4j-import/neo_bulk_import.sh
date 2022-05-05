#!/usr/bin/env bash

echo "The following will take some time! Go do something else..."
echo ""

python3 tools/neo4j-import/packages_to_neo.py \
        data/cargo/cargo_packages_03-18-2022.csv\
        data/fpm/fpm_packages_03-18-2022.csv \
        data/alire/alire_packages_03-18-2022.csv \
        data/chromebrew/chromebrew_packages_03-18-2022.csv \
        data/conan/conan_packages_04-22-2022.csv \
        data/homebrew/homebrew_packages_03-18-2022.csv \
        data/nimble/nimble_packages_03-18-2022.csv \
        data/npm/npm_packages_04-27-2022.csv \
        data/vcpkg/vcpkg_packages_03-18-2022.csv \
        data/ports/freebsd11/freebsd11_packages_03-18-2022.csv \
        data/ports/netbsd9/netbsd9_packages_03-18-2022.csv \
        data/ports/openbsd69/openbsd69_packages_03-18-2022.csv \
        > data/out/neo_pkg.csv

python3 tools/neo4j-import/version_nodes_to_neo.py \
        data/cargo/cargo_versions_03-18-2022.csv\
        data/fpm/fpm_versions_03-18-2022.csv \
        data/alire/alire_versions_03-18-2022.csv \
        data/chromebrew/chromebrew_versions_03-18-2022.csv \
        data/conan/conan_versions_04-22-2022.csv \
        data/homebrew/homebrew_versions_03-18-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/npm/npm_versions_04-27-2022.csv \
        data/vcpkg/vcpkg_versions_03-18-2022.csv \
        data/ports/freebsd11/freebsd11_versions_03-18-2022.csv \
        data/ports/netbsd9/netbsd9_versions_03-18-2022.csv \
        data/ports/openbsd69/openbsd69_versions_03-18-2022.csv \
        > data/out/neo_ver.csv

python3 tools/neo4j-import/version_rels_to_neo.py \
        data/cargo/cargo_versions_03-18-2022.csv\
        data/fpm/fpm_versions_03-18-2022.csv \
        data/alire/alire_versions_03-18-2022.csv \
        data/chromebrew/chromebrew_versions_03-18-2022.csv \
        data/conan/conan_versions_04-22-2022.csv \
        data/homebrew/homebrew_versions_03-18-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/npm/npm_versions_04-27-2022.csv \
        data/vcpkg/vcpkg_versions_03-18-2022.csv \
        data/ports/freebsd11/freebsd11_versions_03-18-2022.csv \
        data/ports/netbsd9/netbsd9_versions_03-18-2022.csv \
        data/ports/openbsd69/openbsd69_versions_03-18-2022.csv \
        > data/out/neo_ver_rels.csv

python3 tools/neo4j-import/deps_to_neo.py \
        data/cargo/cargo_dependencies_03-18-2022.csv\
        data/fpm/fpm_dependencies_03-18-2022.csv \
        data/alire/alire_dependencies_03-18-2022.csv \
        data/chromebrew/chromebrew_dependencies_03-18-2022.csv \
        data/conan/conan_dependencies_04-22-2022.csv \
        data/homebrew/homebrew_dependencies_03-18-2022.csv \
        data/nimble/nimble_dependencies_03-18-2022.csv \
        data/npm/npm_dependencies_04-27-2022.csv \
        data/vcpkg/vcpkg_dependencies_03-18-2022.csv \
        data/ports/freebsd11/freebsd11_dependencies_03-18-2022.csv \
        data/ports/netbsd9/netbsd9_dependencies_03-18-2022.csv \
        data/ports/openbsd69/openbsd69_dependencies_03-18-2022.csv \
        > data/out/neo_deps.csv

neo4j stop
neo4j-admin import \
            --database=neo4j \
            --nodes=data/out/neo_pkg.csv \
            --nodes=data/out/neo_ver.csv \
            --relationships=data/out/neo_ver_rels.csv \
            --relationships=data/out/neo_deps.csv \
            --skip-bad-relationships \
            --multiline-fields=true \
            --force
neo4j start