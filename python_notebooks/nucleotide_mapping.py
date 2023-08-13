from Bio import SeqIO
import os, sys
from collections import defaultdict
from tqdm import tqdm
import pickle

# File path
script_path = os.path.abspath(__file__)

genome_filename = os.path.join(os.path.dirname(script_path), '../data/GRCh38/GRCh38_genome.fna')
# genome_filename = "/uftp/users/gkhegai/hackaton/assembly/grch38_assembly/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna"

transfer_chr_pos = {
    f'{i}':i for i in range(1, 23)
}
transfer_chr_pos['X'] = 23
transfer_chr_pos['Y'] = 24

k = 150

def desciption_handle(description):
    chrom = description.split()[6][:-1]
    return transfer_chr_pos[chrom]

def reverse_complement(dna: str) -> str:
    comp = {"A": "T", "C": "G", "G": "C", "T": "A"}
    return "".join(
        comp[base] if not base.islower() else comp[base].upper()
        for base in reversed(dna)
    )


def canonical_form(kmer: str) -> str:
    rev_comp = reverse_complement(kmer)
    return kmer if kmer < rev_comp else rev_comp


def get_kmers_positions(genome: str, k: int) -> dict[str, list[int]]:
    kmers = defaultdict(list)
    genome_length = len(genome)
    for i in tqdm(range(genome_length - k + 1)):
        kmer = genome[i : i + k].upper()
        if ("N" not in kmer) and (kmer in kmer_non_unique_t2t) and not (kmer in kmer_non_unique_grch38):
            kmers[canonical_form(kmer)].append(i)
    return kmers


def get_kmers_positions_custom(genome: str, k: int) -> dict[str, list[int]]:
#     kmers = defaultdict(list)
    genome_length = len(genome)
    for i in tqdm(range(genome_length - k + 1)):
        kmer = genome[i : i + k].upper()
        if ("N" not in kmer) and (kmer in kmer_non_unique_t2t) and not (kmer in kmer_non_unique_grch38):
            kmer_positions[canonical_form(kmer)].append(i+desciption_currecnt)


def find_substring_in_file(file_path, target_substring):
    with open(file_path, 'r') as file:
        for line in file:
            if target_substring in line:
                return True
    return False

kmer_file_path = '/uftp/users/gkhegai/hackaton/results'

kmer_non_unique_grch38 = set()
with open(f'{kmer_file_path}/HG38_k{k}.txt') as f:
    for line in tqdm(f):
        kmer_non_unique_grch38.add(line.split()[0])
        
kmer_non_unique_t2t = set()
with open(f'{kmer_file_path}/T2T_k{k}.txt') as f:
    for line in tqdm(f):
        kmer_non_unique_t2t.add(line.split()[0])


kmer_positions = defaultdict(list)

with open(genome_filename) as f:
    for genome_record in SeqIO.parse(f, "fasta"):
        if genome_record.name.startswith('NC_00'):
            desciption_currecnt = int(genome_record.name.split('.')[0][-2:])*10**9
#             desciption_currecnt = desciption_handle(genome_record.description)*10**9
            genome_sequence = str(genome_record.seq)
            get_kmers_positions_custom(genome_sequence, k)
        
with open('/uftp2/Datasets/hackaton/dict_{k}.pickle', 'wb') as f:
    pickle.dump(kmer_positions, f)