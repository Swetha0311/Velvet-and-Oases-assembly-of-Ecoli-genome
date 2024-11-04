Name: Swetha Yadavalli

Programming Language: Unix

Required files: SRR21904868.fasta

Required modules: 
sra-toolkit, fastqc, velvet and oases modules are required


Steps involved in the analysis:

1. Download the data from the SRA database with the SRA identifier SRR21904868. Download the fastq file given in the website. 

2. Create a new directory 
mkdir Ecoli

3. Load the required modules for the genome assembly which are sra-toolkit, fastqc, velvet, oases.
module load sra-toolkit
module load fastqc
module load velvet
module load oases

4. Prefetch the SRA file to retrieve the data
prefetch SRR21904868

5. Fasterq dump was then used to load two sets of fastq files of the same SRA 
fasterq dump SRR21904868

6. Fastqc was then used to check for the quality of both the fastq files
fastqc SRR21904868_1.fastq SRR21904868_2.fastq

7. After checking for the quality of the fastq files, it was observed that there were no poor quality sequences in both and the per base sequence quality, per base GC and N content quality were seen good. 

8. There was a memory allocation issue occurred which was resolved by submitting the sbatch script requesting for more memory. 

9. Run the velvet code with different kmers by creating a output directory for each kmer.
velveth $output_dir 53 -fastq SRR21904868_1.fastq SRR21904868_2.fastq && velvetg $output_dir -exp_cov auto 

10. After completing the velvet process, run the oases code for each kmers with the output directories for each created in the velvet step.
oases $output_dir -cov_cutoff auto

11. After running both the genomic assembly tools run the code using grep to check for the number of contigs by going into the output directories. 
grep -c '^>' contigs.fa

12. Also check for the total lengths of the contigs in each kmer by using the commands grep and awk. 
grep -v ">" contigs.fa | awk '{ sum += length($0) } END { print sum }'

Each length of the contig can be found in the contigs.fa file. 


13. Necessary files can be accessed in the output directories created. 


Number of Contigs and Length of Contigs for each kmer: 

Kmer 19 : Contigs - 327873   Contig Length - 17408324

Kmer 53 : Contigs - 32636    Contig Length - 3912403

Kmer 61 : Contigs - 26633    Contig Length - 2567327

Kmer 81 : Contigs - 315      Contig Length - 4783776


Output files : SRR21904868_1_fastqc.html, SRR21904868_2_fastqc.html, contigs.fa, transcripts.fa, Log
