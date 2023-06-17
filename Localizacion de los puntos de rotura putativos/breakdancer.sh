#!/bin/sh

# Se crea el archivo de estadisticas necesario para la ejecucion de breakdancer
perl bam2cfg.pl -g -h /home/kenia/TFM/mapping/mappeo/OF28_sorted_rmdup.bam > OF28_inv.cfg

# Se ejecuta breakdancer por cada cromosoma
breakdancer-max -o Drosophila_subobscura_J OF28_inv.cfg > output_J
breakdancer-max -o Drosophila_subobscura_U OF28_inv.cfg > output_U

