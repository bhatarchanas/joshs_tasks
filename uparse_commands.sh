#!/bin/bash

ruby get_correct_orientation.rb 
usearch -fastq_filter BEI_Mock_Even_Oriented.fastq -fastq_qmax 50 -fastqout BEI_Mock_Even_Oriented_Filtered.fastq -fastq_maxee 1.0 
