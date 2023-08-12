#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


mkdir -p "$DIR/../kmc"

cd "$DIR/../kmc"

echo "Downloading kmc..."

wget https://github.com/refresh-bio/KMC/releases/download/v3.2.2/KMC3.2.2.linux.x64.tar.gz
tar -xzf KMC3.2.2.linux.x64.tar.gz


