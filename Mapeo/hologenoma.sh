#!/bin/bash

# S.cerevisae
curl -O http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-2-1_20150113.tgz
tar -xvzf S288C_reference_genome_R64-2-1_20150113.tgz
cat S288C_reference_genome_R64-2-1_20150113/S288C_reference_sequence_R64-2-1_20150113.fsa | sed 's/^>.*\[chromosome=/>Saccharomyces_cerevisiae_/g' | sed 's/]//g' > S_cerevisiae.fasta
rm -r S288C_reference_genome_R64-2-1_20150113

# W. pipientis
curl -O ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_0_collection/wolbachia_endosymbiont_of_drosophila_melanogaster/dna/Wolbachia_endosymbiont_of_drosophila_melanogaster.ASM802v1.dna.chromosome.Chromosome.fa.gz
gunzip -c Wolbachia_endosymbiont_of_drosophila_melanogaster.ASM802v1.dna.chromosome.Chromosome.fa.gz | sed '/^>/s/.*/>W_pipientis/g'  > W_pipientis.fasta

# P.entomophila
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_2_collection/pseudomonas_entomophila_l48/dna/Pseudomonas_entomophila_l48.ASM2610v1.dna.toplevel.fa.gz
gunzip -c Pseudomonas_entomophila_l48.ASM2610v1.dna.toplevel.fa.gz | sed'/^>/s/.*/>P_entomophila/g'  > P_entomophila.fasta

# C.intestini
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_14_collection/commensalibacter_intestini_a911/dna/Commensalibacter_intestini_a911.ASM23144v1.dna.toplevel.fa.gz
gunzip -c Commensalibacter_intestini_a911.ASM23144v1.dna.toplevel.fa.gz | sed 's/>* .*/_C_intestini/g'  > C_intestini.fasta

# A.pomorum
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_5_collection/acetobacter_pomorum_dm001/dna/Acetobacter_pomorum_dm001.ASM19324v1.dna.toplevel.fa.gz
gunzip -c Acetobacter_pomorum_dm001.ASM19324v1.dna.toplevel.fa.gz | sed 's/>* .*/_A_pomorum/g'  > A_pomorum.fasta

# G.morbifer
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_24_collection/gluconobacter_morbifer_g707/dna/Gluconobacter_morbifer_g707.ASM23435v1.dna.nonchromosomal.fa.gz
gunzip -c Gluconobacter_morbifer_g707.ASM23435v1.dna.nonchromosomal.fa.gz | sed 's/>* .*/_C_morbifer/g'  > C_morbifer.fasta

# P. burhodogranariea
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_3_collection/providencia_burhodogranariea_dsm_19968/dna/Providencia_burhodogranariea_dsm_19968.ASM31485v2.dna.toplevel.fa.gz
gunzip -c Providencia_burhodogranariea_dsm_19968.ASM31485v2.dna.toplevel.fa.gz | sed 's/>* .*/_P_burhodogranariea/g'  > P_burhodogranariea.fasta

# P.alcalifaciens
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_18_collection/providencia_alcalifaciens_dmel2/dna/Providencia_alcalifaciens_dmel2.ASM31487v2.dna.toplevel.fa.gz
gunzip -c Providencia_alcalifaciens_dmel2.ASM31487v2.dna.toplevel.fa.gz | sed 's/>* .*/_P_alcalifaciens/g'  > P_alcalifaciens.fasta

# P.rettgeri
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_23_collection/providencia_rettgeri_dmel1/dna/Providencia_rettgeri_dmel1.ASM31483v2.dna.toplevel.fa.gz
gunzip -c Providencia_rettgeri_dmel1.ASM31483v2.dna.toplevel.fa.gz | sed's/>* .*/_P_rettgeri/g'  > P_rettgeri.fasta

# E.faecalis
curl -O ftp://ftp.ensemblgenomes.org/pub/release-32/bacteria/fasta/bacteria_72_collection/enterococcus_faecalis/dna/Enterococcus_faecalis.ASM69626v1.dna.toplevel.fa.gz
gunzip -c Enterococcus_faecalis.ASM69626v1.dna.toplevel.fa.gz | sed 's/>* .*//g'  > E_faecalis.fasta

# D.subobscura
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/refseq/invertebrate/Drosophila_subobscura/latest_assembly_versions/GCF_008121235.1_UCBerk_Dsub_1.0/GCF_008121235.1_UCBerk_Dsub_1.0_genomic.fna.gz
gunzip -c GCF_008121235.1_UCBerk_Dsub_1.0_genomic.fna.gz | sed 's/^>.*chromosome />Drosophila_subobscura_/g' | sed 's/, whole genome shotgun sequence$//g' | sed 's/^>NW.* UCBerk_Dsub_1.0 />Drosophila_subobscura_/g' | sed 's/^>NC.* 1A />Drosophila_subobscura_/g' | sed 's/,.*//g' > D_subobscura.fasta

# Eliminamos los archivos comprimidos
rm *gz

# Se crea un archivo multifasta con todas las secuencias, el cual será el hologenoma
cat D_subobscura.fasta S_cerevisiae.fasta A_pomorum.fasta C_intestini.fasta C_morbifer.fasta E_faecalis.fasta P_alcalifaciens.fasta P_burhodogranariea.fasta P_entomophila.fasta P_rettgeri.fasta W_pipientis.fasta > hologenoma_dsub.fa


