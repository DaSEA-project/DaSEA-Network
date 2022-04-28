#!/usr/bin/env bash

echo "The following will take some time! Go do something else..."
echo ""

python3 tools/packages_to_neo.py \
        data/cargo/cargo_packages_03-18-2022.csv\
        data/fpm/fpm_packages_03-18-2022.csv \
        data/alire/alire_packages_03-18-2022.csv \
        data/chromebrew/chromebrew_packages_03-18-2022.csv \
        data/conan/conan_packages_03-18-2022.csv \
        data/homebrew/homebrew_packages_03-18-2022.csv \
        data/nimble/nimble_packages_03-18-2022.csv \
        data/vcpkg/vcpkg_packages_03-18-2022.csv \
        > data/out/neo_pkg.csv

python3 tools/version_nodes_to_neo.py \
        data/cargo/cargo_versions_03-18-2022.csv\
        data/fpm/fpm_versions_03-18-2022.csv \
        data/alire/alire_versions_03-18-2022.csv \
        data/chromebrew/chromebrew_versions_03-18-2022.csv \
        data/conan/conan_versions_03-18-2022.csv \
        data/homebrew/homebrew_versions_03-18-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/vcpkg/vcpkg_versions_03-18-2022.csv \
        > data/out/neo_ver.csv

python3 tools/version_rels_to_neo.py \
        data/cargo/cargo_versions_03-18-2022.csv\
        data/fpm/fpm_versions_03-18-2022.csv \
        data/alire/alire_versions_03-18-2022.csv \
        data/chromebrew/chromebrew_versions_03-18-2022.csv \
        data/conan/conan_versions_03-18-2022.csv \
        data/homebrew/homebrew_versions_03-18-2022.csv \
        data/nimble/nimble_versions_03-18-2022.csv \
        data/vcpkg/vcpkg_versions_03-18-2022.csv \
        > data/out/neo_ver_rels.csv

python3 tools/deps_to_neo.py \
        data/cargo/cargo_dependencies_03-18-2022.csv\
        data/fpm/fpm_dependencies_03-18-2022.csv \
        data/alire/alire_dependencies_03-18-2022.csv \
        data/chromebrew/chromebrew_dependencies_03-18-2022.csv \
        data/conan/conan_dependencies_03-18-2022.csv \
        data/homebrew/homebrew_dependencies_03-18-2022.csv \
        data/nimble/nimble_dependencies_03-18-2022.csv \
        data/vcpkg/vcpkg_dependencies_03-18-2022.csv \
        > data/out/neo_deps.csv

neo4j stop
neo4j-admin import \
            --database=neo4j \
            --nodes=data/out/neo_pkg.csv \
            --nodes=data/out/neo_ver.csv \
            --relationships=data/out/neo_ver_rels.csv \
            --relationships=data/out/neo_deps.csv \
            --skip-bad-relationships \
            --force
neo4j start