#!/bin/bash

# Call this script to obtain the correct orientations of the reads from PacBio (need to change the input and output files based on requirements)
ruby ~/projects/mock_community/get_correct_orientation.rb

# For filtering the low quality reads, -fastq_qmax 50 says that 50 is the maximum quality possible, -fastq_maxee_rate 1.0 says that the reads which have expected error more than 1.0 are to be removed. 
usearch -fastq_filter BEI_Mock_Even_Oriented.fastq -fastq_qmax 50 -fastqout BEI_Mock_Even_Oriented_Filtered.fastq -fastq_maxee_rate 1.0

# For dereplication, -sizeout says that we want the size of each annotation in the header. 
usearch -derep_fulllength BEI_Mock_Even_Oriented_Filtered.fastq -fastaout BEI_Mock_Even_Oriented_Filtered_Derep.fasta -sizeout -minseqlength 64

# For sorting the reads based on the length
usearch -sortbysize BEI_Mock_Even_Oriented_Filtered_Derep.fasta -fastaout BEI_Mock_Even_Oriented_Filtered_Derep_Sorted.fasta

# For clustering the OTU's, -otus option stamds for the name of the output file in fasta format, -uparseout stands for the name of the file from uparse, -sizein and -sizeout says that size annotation is present in the input file and is required in the output file.
usearch -cluster_otus BEI_Mock_Even_Oriented_Filtered_Derep_Sorted.fasta -otus BEI_Mock_OTU.fasta -uparseout BEI_Mock_uparse_out.up -relabel OTU_ -sizein -sizeout

# For filtering the chimeric reads, using the gold database, -nonchimeras needs the name of the file without the chimeric reads                              
usearch -uchime_ref BEI_Mock_OTU.fasta -db ~/projects/mock_community/gold.fa -strand plus -nonchimeras BEI_Mock_OTU_nonchimera.fasta

# Call this script for converting the format of the fasta file for making it suitable for creating a OTU table (need to change the input and output files based on requirements)
ruby ~/drive5_py/fastq_strip_barcode_relabel_mod.rb

# For mapping the reads to the OTUS's, using the gold db, -id 0.97 says that we want 97% similarity between the reads and the reference sequence in order for mapping to occur
usearch -usearch_global BEI_Mock_OTU_nonchimera_edit.fasta -db ~/projects/mock_community/gold.fa -strand plus -id 0.97 -uc BEI_readmap.uc

# For converting the uc file into an OTU table in txt
python ~/drive5_py/uc2otutab.py BEI_readmap.uc > BEI_OTU_Table