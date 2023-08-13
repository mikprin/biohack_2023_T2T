#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

data_folder=$(realpath "$DIR/../data")
mkdir -p "$data_folder"
cd "$data_folder"

echo "Setting up genomes..."

if [ -f "$data_folder/GCF_000001405.40.zip" ]; then
    echo "GRCh38 exists."
    # Perform actions on the file if it exists
else
    echo "File does not exist."
    echo "Downloading GRCh38"
    # Perform actions if the file does not exist
    curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000001405.40/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_000001405.40.zip" -H "Accept: application/zip"
fi

unzip GCF_000001405.40.zip
mv ncbi_dataset/data/GCF_000001405.40 ./GRCh38
mv $data_folder/GRCh38/GCF_000001405.40_GRCh38.p14_genomic.fna ./GRCh38/GRCh38_genome.fna
rm -rf ncbi_dataset README.md

if [ -f "$data_folder/GCF_009914755.1.zip" ]; then
    echo "T2T zip exists."
    # Perform actions on the file if it exists
else
    echo "T2T zip does not exist."
    echo "Downloading T2T"
    # Perform actions if the file does not exist
    curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_009914755.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_009914755.1.zip" -H "Accept: application/zip"
fi

unzip GCF_009914755.1.zip
mv ncbi_dataset/data/GCF_009914755.1 ./T2T
mv $data_folder/T2T/GCF_009914755.1_T2T-CHM13v2.0_genomic.fna ./T2T/T2T_genome.fna
rm -rf ncbi_dataset README.md
