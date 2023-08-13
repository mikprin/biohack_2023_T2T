#!/bin/bash

MAX_MEMORY=$(free -h | awk '/Mem/ {print $7}' | grep -o '[0-9.]*')

echo "Using: $MAX_MEMORY Gb of memory"

# Working with directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
data_folder=$(realpath "$DIR/../data")

kmc_results_folder="$DIR/../results/kmc"
mkdir -p "$kmc_results_folder"
kmc_results_folder=$(realpath "$DIR/../results/kmc")

echo "Setting up kmc results folder... $kmc_results_folder"
mkdir -p "$kmc_results_folder/temp"
cd "$kmc_results_folder"


# Arrays for k and genome values
k_values=(75 100 150 200 250)
genomes=('GRCh38' 'T2T')

# Nested loop
for genome in "${genomes[@]}"; do
    for k in "${k_values[@]}"; do
        echo "Processing ${genome} with k=${k}"
        # realpath "$data_folder/${genome}/${genome}_genome.fna"
        echo "Running: kmc -v -k${k} -fm -m9 $data_folder/${genome}/${genome}_genome.fna $kmc_results_folder/${genome}_k${k} ./temp -j${genome}_k${k}.logs> $kmc_results_folder/${genome}_k${k}.log"
        kmc -v -k${k} -fm -m$MAX_MEMORY $data_folder/${genome}/${genome}_genome.fna $kmc_results_folder/${genome}_k${k} ./temp -j${genome}_k${k}.logs> $kmc_results_folder/${genome}_k${k}.log
        # kmc -v -k${k} -fm -m9 $data_folder/${genome}/${genome}_genome.fna $kmc_results_folder/${genome}_k${k} ./temp -j${genome}_k${k}.logs> $kmc_results_folder/${genome}_k${k}.log 2>&1
        kmc_tools "transform $kmc_results_folder/${genome}_k${k} dump $kmc_results_folder/${genome}_k${k}.txt histogram $kmc_results_folder/${genome}_k${k}_hist.txt"
    done
done
