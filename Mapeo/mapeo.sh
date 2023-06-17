#!/bin/sh

# Se indexa el hologenoma y se realiza el mapeo
bwa index -a is hologenoma_dsub.fa
bwa mem -t 4 -M -R '@RG\tID:D1EFBACXX_4_8\tPL:ILLUMINA\tLB:896D\tPU:I979\tSM:OF28' index/holo_dsub.fa OF28_read1_paired_trim20.fastq.gz OF28_read2_paired_trim20.fastq.gz > OF28.sam

# Se pasa de sam a bam
samtools view -Sb OF28.sam > OF28.bam

# Se ordena el archivo bam por coordenadas
samtools sort -o OF28_sorted.bam OF28.bam

# Se indexa el archive bam y obtenemos un archive bai
samtools index OF28_sorted.bam

# Se elimina los duplicados
samtools rmdup -S OF28_sorted.bam OF28_sorted_rmdup.bam

# Se indexa el archive bam y obtenemos un archive bai
samtools index OF28_sorted_rmdup.bam

#Se realiza una estadistica del mapeo
samtools flagstat OF28_sorted_rmdup.bam
