---
layout: default
title: Home
---

Este pipeline é um pipeline para detecção e chamada de variantes germinativas a partir de arquivos de sequenciamento FASTQs. Ele irá realizar uma validação nos dados dos FASTQs, o merge (cat dos arquivos FASTQs), alinhamento (usando BWA mem) e chamada de variantes (baseado na Ferramenta Freebayes).

- fqlib is a library to generate and validate FASTQ file pairs [link](https://github.com/stjude/fqlib).
- bwa is a library for NGS alignment against large reference genomes [link](http://bio-bwa.sourceforge.net/).
- freebayes is a Bayesian genetic variant detector designed to find small polymorphisms, specifically SNPs (single-nucleotide polymorphisms), indels (insertions and deletions), MNPs (multi-nucleotide polymorphisms), and complex events (composite insertion and substitution events) smaller than the length of a short-read sequencing alignment [link](https://github.com/freebayes/freebayes).

Este pipeline é parte do [Varstation][https://varstation.com/] desenvolvido pelo time de bioinformática no [Hospital Israelita Albert Einstein](https://einstein.br/)

## Como executar

Este pipeline pode executado usando [Cromwell](http://cromwell.readthedocs.io/en/stable/):

```bash
java -jar cromwell-<version>.jar run -i inputs.json germline-varcall-dna.wdl
```
Este pipeline também pode ser executando o [Oliver](https://stjudecloud.github.io/oliver/) desenvolvido pelo St. Jude Cloud Team.

```bash
oliver submit germline-varcall-dna.wdl inputs.json
```

### Inputs

Os Inputs de entrada são disponibilizados via arquivo. Os inputs obrigatórios são descritos abaixo
e o template contendo todos os inputs podem ser gerados por meio da ferramenta Womtool descrito em
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
Para uma visão geral de todas as entradas disponíveis, leia [esta página](./inputs.html).



```json
{
    "GermlineVarcallDna.sampleInputs": {
      "sampleName": "Nome da Amostra sem espacos",
      "sampleId": "Id da amostra",
      "fastqs1": [
        "path dos arquivos fastqs R1"
      ],
      "fastqs2": [
        "path dos arquivos fastqs R2"
      ]

    },
    "GermlineVarcallDna.bwaIndex":{
      "fastaFile": "genoma de referencia formato fasta",
      "indexFiles":[
        "lista de arquivos de índices necessários para execução do bwa (gerados a partir do bwa build index)"
      ]
    },
    "GermlineVarcallDna.reference": "path do arquivo de genoma de referência para chamada de variantes em formato fasta",
    "GermlineVarcallDna.reference_idx": "path do índice do genoma de referência para chamada de variantes" ,
    "GermlineVarcallDna.intervals": "path do arquivo de intervalos em formato chr: start end (.list ou .bed)"
}
```

Alguns inputs adicionais opcionais:

```json
{
  "GermlineVarcallDna.bwaThreads": "Número de threads para rodar o alinhamento do BWA"
}
```

O diretório de saída deve ser configurado usndo o `options.json`. Visualize [a documentação cromwell](
https://cromwell.readthedocs.io/en/stable/wf_options/Overview/) para mais informações.

Exemplo de arquivo `options.json`:
```JSON
{
"final_workflow_outputs_dir": "my-analysis-output",
"use_relative_output_paths": true,
"default_runtime_attributes": {
  "docker_user": "$EUID"
  }
}
```

### Exemplo

Abaixo um exemplo real do input JSON para o pipeline.

```json
{
    "GermlineVarcallDna.sampleInputs": {
      "sampleName": "SAMPLE",
      "sampleId": 0,
      "fastqs1": [
        "tests/data/SAMPLE_S8_L001_R1_001.fastq.gz"
      ],
      "fastqs2": [
        "tests/data/SAMPLE_S8_L001_R2_001.fastq.gz"
      ]

    },
    "GermlineVarcallDna.bwaIndex":{
      "fastaFile": "tests/data/reference/bwa/reference_example.fasta",
      "indexFiles":[
        "tests/data/reference/bwa/reference_example.fasta.amb",
        "tests/data/reference/bwa/reference_example.fasta.ann",
        "tests/data/reference/bwa/reference_example.fasta.bwt",
        "tests/data/reference/bwa/reference_example.fasta.pac",
        "tests/data/reference/bwa/reference_example.fasta.sa"
      ]
    },
    "GermlineVarcallDna.bwaThreads": 1,
    "GermlineVarcallDna.reference": "tests/data/reference/bwa/reference_example.fasta",
    "GermlineVarcallDna.reference_idx": "tests/data/reference/bwa/reference_example.fasta.fai",
    "GermlineVarcallDna.intervals": "tests/data/BRCA.list"
}
```


### Requisitos e versões de ferramentas
Os pipelines do Varstation usam imagens docker para garantir reproducibilidade. Isto significa que os pipelines irão executar em quaisquer arquiteturas que possuam o docker instalados.

Para mais informações sobre as configurações do docker, mais informações em [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

As imagens de nosso projeto estão no nosso [repositório de containers](https://github.com/Varstation/containers).

### Output

O pipeline irá liberar o arquivo de alinhamento pelo BWA em formato .bam e também irá prover um VCF contendo as variantes detectadas pela ferramenta Freebayes.

- **SAMPLE_NAME.freebayes.vcf**: Arquivo VCF com as variantes detectadas pela etapa de chamada de variantes.

- **SAMPLE_NAME.aln.bam**: Arquivo de alinhamento BAM da amostra.

- **SAMPLE_NAME.aln.bam.bai**: Arquivo de índice do alinhamento BAM da amostra.

## Contato
<p>
Para qualquer dúvidas sobre executar este workflow ou requisições de features, por favor entre em contato com 
<a href='https://github.com/varstation/wdl-demo-pipeline/issues'>github issue tracker</a>
</p>