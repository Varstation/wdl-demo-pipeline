#!/usr/bin/env bash

set -e
wget -c https://wdl-poc-ci.s3.amazonaws.com/SAMPLE_S8_L001_R1_001.fastq.gz
wget -c https://wdl-poc-ci.s3.amazonaws.com/SAMPLE_S8_L001_R2_001.fastq.gz

mkdir -p ./reference/bwa
cd reference
cd bwa

wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.amb
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.ann
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.bwt
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.fai
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.pac
wget -c https://wdl-poc-ci.s3.amazonaws.com/reference/bwa/reference_example.fasta.sa
