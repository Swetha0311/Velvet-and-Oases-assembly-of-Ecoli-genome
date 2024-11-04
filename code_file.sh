#!/bin/bash

#create a directory 
mkdir Ecoli

#load the modules
module load sra-toolkit
module load fastqc
module load velvet
module load oases

#prefetch the SRA file
prefetch SRR21904868

#use fasterq dump 
fasterq-dump SRR21904868.sra

#use fastqc for quality check 
fastqc SRR21904868_1.fastq SRR21904868_1.fastq

#use velvet module 
velveth size_53 53 -fastq SRR21904868_1.fastq SRR21904868_2.fastq && velvetg $output_dir -exp_cov auto
velveth size_19 19 -fastq SRR21904868_1.fastq SRR21904868_2.fastq && velvetg $output_dir -exp_cov auto 
velveth size_61 61 -fastq SRR21904868_1.fastq SRR21904868_2.fastq && velvetg $output_dir -exp_cov auto 
velveth size_81 81 -fastq SRR21904868_1.fastq SRR21904868_2.fastq && velvetg $output_dir -exp_cov auto 
#Parameters used - -exp_cov: automatically estimates each contig coverage.
output: Logs, Roadmaps, Sequences, contigs.fa

#use the oases module 
oases size_53 -cov_cutoff auto 
oases size_19 -cov_cutoff auto
oases size_61 -cov_cutoff auto
oases size_81 -cov_cutoff auto
#Parameters used - -cov_cutoff auto - automatically estimates the low contigs

#use the grep command to find the total number of contigs 
grep -c '^>' contigs.fa

#use the grep and awk commands to get the total length of the contigs
grep -v ">" contigs.fa | awk '{ sum += length($0) } END { print sum }'

#use the code to get the lengths for each of the contigs 
cat contigs.fa | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > length_53.txt
