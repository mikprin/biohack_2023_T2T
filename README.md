
## Goals

Goal of this repository is to analyse potential to find multicopy nucleotide sequences that where  unique in HG38 genome assembly and are multicopy in T2T genome assembly. 
We are doing it using an external kmc utility. Fining k=75,150... Kmers and then aligning them in the original genome. Then using resulted data to check if we can align them in newer T2T assembly. 
How to use this repository?
Due to lack of time there are a reason to launch this software steps. 
Step 1. Obtaining and renaming Hg38 and T2T assembly. 
Step 2. 
Launching kmc utility and obtaining all kmers. 
Step 3. Converting kmers in the fas file and feeding them to BWA aligner.

## Usage
Step 1:

First, you need to install the dependencies. You can do it using the following command:
```
./scripts/ubuntu_dependencies.sh # CLI for Ubuntu
scripts/get_genomes.sh # Download and unpack genome in correct form.
./scripts/get_kmc.sh # Not ready yet
```

Now you are ready to download the data and run the pipeline. You can do it using the following command:
```
./scripts/get_genomes.sh
```

Step 2:

Now you are ready to run kmc the pipeline. You can do it using the following command:
```
scripts/run_kmc.sh 
```
This step will generate multiple kmers sets such as `results/kmc/${genome}_k${k}.txt` and `results/kmc/${genome}_k${k}_histogram.txt` this is a set of k-mers of length `k`.

Step 3/.

Use BWE aliner to search for exact matches in genome. Assuming genome was downloaded using ``


## Owerview

## Dependencies


## How to contact us
Telegram: @miksolo
Email: mikhail.solovyanov@gmail.com
### Genome:
You can download the genome from NCBI using the following command:
`scripts/get_genomes.sh`

in case you want to download it manually, you can use the following commands:

For T2T-CHM13v2
```
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_009914755.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_009914755.1.zip" -H "Accept: application/zip"
```

For GRCh38
```
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000001405.40/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCF_000001405.40.zip" -H "Accept: application/zip"
```