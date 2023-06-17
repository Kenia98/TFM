#!/bin/sh

java -jar /usr/share/java/trimmomatic-0.39.jar PE -phred33 D1EFBACXX_4_8_1.fastq.gz D1EFBACXX_4_8_2.fastq.gz OF28_read1_paired_trim20.fastq.gz OF28_read1_unpaired_trim20.fastq.gz OF28_read2_paired_trim20.fastq.gz OF28_read2_unpaired_trim20.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:75

