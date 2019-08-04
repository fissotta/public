#!/bin/bash
#Francisco Issotta
#fissotta@gmail.com

if [ ${#@} != 4 ]; then
    echo "Usage:"
    echo ""
    echo "bash bowtie2.sh reference.fasta reads_forward_R1_001.fastq reads_reverse_R2_001.fastq prefix"
    echo ""
fi

if [ ${#@} == 4 ]; then

IFS='.'
read -ra FASTA <<< "$1"
IFS=' '

bowtie2-build $1 $FASTA
bowtie2 -x $FASTA -1 $2 -2 $3 -S $4_$FASTA.sam --no-unal --threads 10
samtools view -bS $4_$FASTA.sam > $4_$FASTA.bam
samtools sort $4_$FASTA.sam > $4_$FASTA.sorted.sam
samtools index $4_$FASTA.sorted.sam
fi
