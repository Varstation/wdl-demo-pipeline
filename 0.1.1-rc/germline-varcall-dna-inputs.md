---
layout: default
title: "Inputs: GermlineVarcallDna"
---

# Inputs para GermlineVarcallDna

Abaixo está descrito uma visão gerão de todos os inputs disponíveis em
GermlineVarcallDna.


## Inputs obrigatórios
<dl>
<dt id="GermlineVarcallDna.bwaIndex"><a href="#GermlineVarcallDna.bwaIndex">GermlineVarcallDna.bwaIndex</a></dt>
<dd>
    <i>struct(fastaFile : File, indexFiles : Array[File]) </i><br />
    The BWA index, including (optionally) a .alt file.
</dd>
<dt id="GermlineVarcallDna.reference"><a href="#GermlineVarcallDna.reference">GermlineVarcallDna.reference</a></dt>
<dd>
    <i>File </i><br />
    Reference sequence file.
</dd>
<dt id="GermlineVarcallDna.reference_idx"><a href="#GermlineVarcallDna.reference_idx">GermlineVarcallDna.reference_idx</a></dt>
<dd>
    <i>File </i><br />
    Reference sequence index (.fai).
</dd>
<dt id="GermlineVarcallDna.sampleInputs"><a href="#GermlineVarcallDna.sampleInputs">GermlineVarcallDna.sampleInputs</a></dt>
<dd>
    <i>struct(alignedBam : File?, cnvVcfs : Array[File]?, fastqs1 : Array[File]?, fastqs2 : Array[File]?, isControl : Boolean?, library : String?, platform : String?, sampleId : Int, sampleName : String, snvVcfs : Array[File]?, svVcfs : Array[File]?, unmappedBams : Array[File]?) </i><br />
    Sample Inputs metadata including name, id, and fastqs
</dd>
</dl>

## Outras entradas padrões
<dl>
<dt id="GermlineVarcallDna.BwaMem.readgroup"><a href="#GermlineVarcallDna.BwaMem.readgroup">GermlineVarcallDna.BwaMem.readgroup</a></dt>
<dd>
    <i>String? </i><br />
    A readgroup identifier.
</dd>
<dt id="GermlineVarcallDna.FreeBayes.output_filename"><a href="#GermlineVarcallDna.FreeBayes.output_filename">GermlineVarcallDna.FreeBayes.output_filename</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>outputPrefix + '.freebayes.vcf'</code><br />
    VCF output file name Default is prefix + vcf.
</dd>
<dt id="GermlineVarcallDna.FreeBayes.userString"><a href="#GermlineVarcallDna.FreeBayes.userString">GermlineVarcallDna.FreeBayes.userString</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"-4 -q 15 -F 0.03"</code><br />
    An optional parameter which allows the user to specify additions to the command line at run time.
</dd>
<dt id="GermlineVarcallDna.intervals"><a href="#GermlineVarcallDna.intervals">GermlineVarcallDna.intervals</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to call variants for.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.alignedBam"><a href="#GermlineVarcallDna.ValidateInputs.alignedBam">GermlineVarcallDna.ValidateInputs.alignedBam</a></dt>
<dd>
    <i>File? </i><br />
    The aligned bam file
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.unmappedBams"><a href="#GermlineVarcallDna.ValidateInputs.unmappedBams">GermlineVarcallDna.ValidateInputs.unmappedBams</a></dt>
<dd>
    <i>Array[File]? </i><br />
    Array of unmapped bam files
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateSingle.fastq2"><a href="#GermlineVarcallDna.ValidateInputs.ValidateSingle.fastq2">GermlineVarcallDna.ValidateInputs.ValidateSingle.fastq2</a></dt>
<dd>
    <i>File? </i><br />
    Fastq R2.
</dd>
</dl>

## Inputs avançados
<details>
<summary> Exibir/Esconder </summary>
<dl>
<dt id="GermlineVarcallDna.BwaMem.compressionLevel"><a href="#GermlineVarcallDna.BwaMem.compressionLevel">GermlineVarcallDna.BwaMem.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default (Padrão):</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="GermlineVarcallDna.BwaMem.dockerImage"><a href="#GermlineVarcallDna.BwaMem.dockerImage">GermlineVarcallDna.BwaMem.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"quay.io/biocontainers/mulled-v2-ad317f19f5881324e963f6a6d464d696a2825ab6:c59b7a73c87a9fe81737d5d628e10a3b5807f453-0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="GermlineVarcallDna.BwaMem.sortMemoryPerThreadGb"><a href="#GermlineVarcallDna.BwaMem.sortMemoryPerThreadGb">GermlineVarcallDna.BwaMem.sortMemoryPerThreadGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default (Padrão):</i> <code>2</code><br />
    The amount of memory for each sorting thread in gigabytes.
</dd>
<dt id="GermlineVarcallDna.BwaMem.sortThreads"><a href="#GermlineVarcallDna.BwaMem.sortThreads">GermlineVarcallDna.BwaMem.sortThreads</a></dt>
<dd>
    <i>Int? </i><br />
    The number of threads to use for sorting.
</dd>
<dt id="GermlineVarcallDna.bwaThreads"><a href="#GermlineVarcallDna.bwaThreads">GermlineVarcallDna.bwaThreads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default (Padrão):</i> <code>1</code><br />
    The number of threads to use for alignment.
</dd>
<dt id="GermlineVarcallDna.FreeBayes.cpu"><a href="#GermlineVarcallDna.FreeBayes.cpu">GermlineVarcallDna.FreeBayes.cpu</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default (Padrão):</i> <code>1</code><br />
    Number of CPUs to use at runtime.
</dd>
<dt id="GermlineVarcallDna.FreeBayes.dockerImage"><a href="#GermlineVarcallDna.FreeBayes.dockerImage">GermlineVarcallDna.FreeBayes.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"quay.io/biocontainers/freebayes:1.3.2--py37hc088bd4_0"</code><br />
    Docker image for running the varcaller.
</dd>
<dt id="GermlineVarcallDna.FreeBayes.memory"><a href="#GermlineVarcallDna.FreeBayes.memory">GermlineVarcallDna.FreeBayes.memory</a></dt>
<dd>
    <i>Float </i><i>&mdash; Default (Padrão):</i> <code>12</code><br />
    GB of RAM to use at runtime.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateAligned.dockerImage"><a href="#GermlineVarcallDna.ValidateInputs.ValidateAligned.dockerImage">GermlineVarcallDna.ValidateInputs.ValidateAligned.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"776722213159.dkr.ecr.sa-east-1.amazonaws.com/picard-slim:2.23.8"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateAligned.picardPath"><a href="#GermlineVarcallDna.ValidateInputs.ValidateAligned.picardPath">GermlineVarcallDna.ValidateInputs.ValidateAligned.picardPath</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"/bin/picard.jar"</code><br />
    The path for the Picard jar executable file.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidatePaired.dockerImage"><a href="#GermlineVarcallDna.ValidateInputs.ValidatePaired.dockerImage">GermlineVarcallDna.ValidateInputs.ValidatePaired.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"welliton/fqlib:0.7.0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateSingle.dockerImage"><a href="#GermlineVarcallDna.ValidateInputs.ValidateSingle.dockerImage">GermlineVarcallDna.ValidateInputs.ValidateSingle.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"welliton/fqlib:0.7.0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateUnmapped.dockerImage"><a href="#GermlineVarcallDna.ValidateInputs.ValidateUnmapped.dockerImage">GermlineVarcallDna.ValidateInputs.ValidateUnmapped.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"776722213159.dkr.ecr.sa-east-1.amazonaws.com/picard-slim:2.23.8"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="GermlineVarcallDna.ValidateInputs.ValidateUnmapped.picardPath"><a href="#GermlineVarcallDna.ValidateInputs.ValidateUnmapped.picardPath">GermlineVarcallDna.ValidateInputs.ValidateUnmapped.picardPath</a></dt>
<dd>
    <i>String </i><i>&mdash; Default (Padrão):</i> <code>"/bin/picard.jar"</code><br />
    The path for the Picard jar executable file.
</dd>
</dl>
</details>




