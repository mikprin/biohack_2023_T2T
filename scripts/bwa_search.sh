#!/usr/bin/env bash
# CWD
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Input file
INPUT="$1"
INPUT_FILE=$(realpath "$INPUT")
NAME=$(basename "$INPUT_FILE")
DATA_PATH=$(realpath "$DIR/../data")



genomes=(T2T,GRCh38)
genome='T2T'


if [ ! -f "$DATA_PATH/${genome}/${genome}_genome.fna.sa" ]; then
    echo "Index not found for ${genome}. Indexing ${genome}"
    (cd "$DATA_PATH/${genome}" && bwa index "${genome}_genome.fna")
fi

# loop
# for genome in "${genomes[@]}"; do
#     echo "Processing ${genome}"
#     if [ ! -f "$DATA_PATH/${genome}/${genome}_genome.fna.sa" ]; then
#         echo "Index not found for ${genome}. Indexing ${genome}"
#         (cd "$DATA_PATH/${genome}" && bwa index "${genome}_genome.fna")
#     fi
# done

INDEX_PATH=$(realpath "$DATA_PATH/${genome}/${genome}_genome.fna")
echo "Indexing done."
# Directories

# KMC
KMC_DIR=$(realpath "$DIR/../kmc/bin")
export PATH="$PATH:$KMC_DIR"
KMC_RESULTS_DIR=$(realpath "$DIR/../results/kmc")

# BWA results
BWA_DIR=$(realpath "$DIR/../results/bwa_search")
mkdir -p "$BWA_DIR"

cd "$BWA_DIR"

# Convert txt to fasta
CONVERTED_FASTA="$BWA_DIR/$NAME.fasta"
awk '{ print ">"NR"\n"$1 }' $INPUT_FILE.txt > $CONVERTED_FASTA

cpu_count=$(nproc)
echo "Using $cpu_count threads"


bwa mem -a -t $cpu_count "$DATA_PATH/${genome}/${genome}_genome.fna"  $CONVERTED_FASTA > $BWA_DIR/$NAME.sam &&\
samtools view -S -b $BWA_DIR/$NAME.sam | samtools sort | bedtools bamtobed > $BWA_DIR/$NAME.bed