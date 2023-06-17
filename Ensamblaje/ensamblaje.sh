#!/bin/sh

#Obtenemos los reads para el ensamblaje del cromosoma U
#Obtenemos los reads proximos al punto de corte proximal
samtools view -b -h -o output_Ji.bam OF28_sorted_rmdup.bam "Drosophila_subobscura_J:"

#Obtenemos los reads proximos al punto de corte distal
samtools view -b -h -o output_Jf.bam OF28_sorted_rmdup.bam "Drosophila_subobscura_J:"

#Ordenamos los archivos bam obtenidos
samtools sort -n output_Ji.bam -o output_Jisorted.bam
samtools sort -n output_Jf.bam -o output_Jfsorted.bam

#Pasamos el archivos bam del punto proximal a fastq
samtools fastq -1 output_Jisorted_R1.fastq -2 output_Jisorted_R2.fastq -s output_Jisorted_singles.fastq output_Jisorted.bam

#Comprobamos los archivos
wc -l output_Jisorted_R1.fastq
wc -l output_Jisorted_R2.fastq
wc -l output_Jisorted_singles.fastq

#Pasamos el archivo bam del punto distal a fastq
samtools fastq -1 output_Jfsorted_R1.fastq -2 output_Jfsorted_R2.fastq -s output_Jf_singles.fastq output_Jfsorted.bam

#Comprobamos los archivos
wc -l output_Jfsorted_R1.fastq
wc -l output_Jfsorted_R2.fastq
wc -l output_Jfsorted_singles.fastq

#Extraemos los nombres de los singletons
cat output_Jisorted_singles.fastq | grep '^@HWI' > names_singles_Ji.txt
cat output_Jfsorted_singles.fastq | grep '^@HWI' > names_singles_Jf.txt

#Buscamos los singlestons en el archivo original
zcat OF28_read1_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Ji.txt) > unmappedJi_R1.fastq
zcat OF28_read2_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Ji.txt) > unmappedJi_R2.fastq
zcat OF28_read1_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Jf.txt) > unmappedJf_R1.fastq
zcat OF28_read2_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Jf.txt) > unmappedJf_R2.fastq

#Eliminamos --
cat unmappedJi_R1.fastq | sed '/^--/d' > output_unmappedJi_R1.fastq
cat unmappedJi_R2.fastq | sed '/^--/d' > output_unmappedJi_R2.fastq
cat unmappedJf_R1.fastq | sed '/^--/d' > output_unmappedJf_R1.fastq
cat unmappedJf_R2.fastq | sed '/^--/d' > output_unmappedJf_R2.fastq

#Unimos los reads
cat output_Jisorted_R1.fastq output_Jfsorted_R1.fastq output_unmappedJi_R1.fastq output_unmappedJf_R1.fastq > readsJ_R1.fastq
cat output_Jisorted_R2.fastq output_Jfsorted_R2.fastq output_unmappedJi_R2.fastq output_unmappedJf_R2.fastq > readsJ_R2.fastq

#Realizamos el ensamblaje de novo
spades.py -k 21,33,55,77 --careful -o spades_assemblyJ -1 readsJ_R1.fastq -2 readsJ_R2.fastq

#Control de calidad del ensamblaje
quast.py --output-dir quast contigs.fasta
cd quast | cat report.txt

#Obtenemos los reads para el ensamblaje del cromosoma U
#Obtenemos los reads proximos al punto de corte proximal
samtools view -b -h -o output_Ui.bam OF28_sorted_rmdup.bam "Drosophila_subobscura_U:7704784-7724784"

#Obtenemos los reads proximos al punto de corte distal
samtools view -b -h -o output_Uf.bam OF28_sorted_rmdup.bam "Drosophila_subobscura_U:16603873-16623873"

#Ordenamos los archivos bam obtenidos
samtools sort -n output_Ui.bam -o output_Uisorted.bam
samtools sort -n output_Uf.bam -o output_Ufsorted.bam

#Pasamos el archivos bam del punto proximal a fastq
samtools fastq -1 output_Uisorted_R1.fastq -2 output_Uisorted_R2.fastq -s output_Uisorted_singles.fastq output_Uisorted.bam

#Comprobamos los archivos
wc -l output_Uisorted_R1.fastq
wc -l output_Uisorted_R2.fastq
wc -l output_Uisorted_singles.fastq

#Pasamos el archivo bam del punto distal a fastq
samtools fastq -1 output_Ufsorted_R1.fastq -2 output_Ufsorted_R2.fastq -s output_Uf_singles.fastq output_Ufsorted.bam


#Comprobamos los archivos
wc -l output_Ufsorted_R1.fastq
wc -l output_Ufsorted_R2.fastq
wc -l output_Ufsorted_singles.fastq

#Extraemos los nombres de los singletons
cat output_Uisorted_singles.fastq | grep '^@HWI' > names_singles_Ui.txt
cat output_Ufsorted_singles.fastq | grep '^@HWI' > names_singles_Uf.txt

#Buscamos los singlestons en el archivo original
zcat OF28_read1_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Ui.txt) > unmappedUi_R1.fastq
zcat OF28_read2_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Ui.txt) > unmappedUi_R2.fastq
zcat OF28_read1_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Uf.txt) > unmappedUf_R1.fastq
zcat OF28_read2_paired_trim20.fastq.gz | grep -A3 -wFf <(sed 's/\/[12]$//' names_singles_Uf.txt) > unmappedUf_R2.fastq

#Eliminamos --
cat unmappedUi_R1.fastq | sed '/^--/d' > output_unmappedUi_R1.fastq
cat unmappedUi_R2.fastq | sed '/^--/d' > output_unmappedUi_R2.fastq
cat unmappedUf_R1.fastq | sed '/^--/d' > output_unmappedUf_R1.fastq
cat unmappedUf_R2.fastq | sed '/^--/d' > output_unmappedUf_R2.fastq

#Unimos los reads 
cat output_Uisorted_R1.fastq output_Ufsorted_R1.fastq output_unmappedUi_R1.fastq output_unmappedUf_R1.fastq > readsU_R1.fastq
cat output_Uisorted_R2.fastq output_Ufsorted_R2.fastq output_unmappedUi_R2.fastq output_unmappedUf_R2.fastq > readsU_R2.fastq

#Realizamos el ensamblaje de novo
spades.py -k 21,33,55,77 --careful -o spades_assemblyU -1 readsU_R1.fastq -2 readsU_R2.fastq

#Control de calidad del ensamblaje
quast.py --output-dir quast contigs.fasta
cd quast | cat report.txt

