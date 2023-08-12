#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "$DIR/../data"
cd "$DIR/../data"

echo "Downloading genomes..."
echo "Downloading GRCh38"

curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000001405.40/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_000001405.40.zip" -H "Accept: application/zip"

unzip GCF_000001405.40.zip
mv ncbi_dataset/data/GCF_000001405.40 ./GRCh38
rm -rf ncbi_dataset README.md

echo "Downloading T2T"
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_009914755.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_009914755.1.zip" -H "Accept: application/zip"
unzip GCF_009914755.1.zip
mv ncbi_dataset/data/GCF_009914755.1 ./T2T
rm -rf ncbi_dataset README.md
