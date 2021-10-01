version 1.0

# SampleInputs holds sample information and input data.
# The sampleId and sampleName are required, while library (Sequencing Library),
# platform (Sequencing Platform) and isControl (wether is control sample or not),
# are optional.
# Input data can be paired-end or single-end FASTQ files, separated by lane,
# or a CSV file listing FASTQ files, one line for each lane, unmapped BAM files,
# separated by lane or read-group, single BAM file, VCF files, separated by 
# different variant caller tools. Each variant type has its own input: 
# snvVcf for Single Nucleotide Variant, cnvVcf for Copy Number Variant and 
# svVcf for Structural Variant.
struct SampleInputs {
    Int sampleId
    String sampleName
    String? library
    String? platform
    Boolean? isControl

    Array[File]? fastqs1
    Array[File]? fastqs2

    Array[File]? unmappedBams
    File? alignedBam

    Array[File]? snvVcfs
    Array[File]? cnvVcfs
    Array[File]? svVcfs
}

# ReferenceGenome holds information about reference genomes and their dependencies.
# The files refFasta, refFastaIndex and refDict are fixed by genome, while
# BWA indices differ according to BWA version and will be handled at pipeline level.
# The BED files exonsBed, transcriptsBed and genomeBed are used for metrics calculation,
# while VCFs dbsnpVcf and knownSitesVcfs (with their respective indices) are
# required for base recalibration and additional QC steps. The GTF/GFF annotation and
# its index are used as visual reference for IGV and also to generate Annovar's gene
# annotation database.
struct ReferenceGenome {
    String version
    File refFasta
    File refFastaIndex
    File refDict

    File exonsBed
    File transcriptsBed
    File genomeBed

    File dbsnpVcf
    File dbsnpVcfIndex
    Array[File] knownSitesVcfs
    Array[File] knownSitesVcfIndices

    File annotation
    File annotationIndex
}

# PipelineSettings brings settings based on user input for a pipeline.
# The flag sampleProcessingType can be panel, exome or genome. The BED
# targetBed contains genomic intervals for variant calling and QC,
# and may represent targets for targeted sequencing. It should point
# to a default if not provided by the user.
struct PipelineSettings {
    String sampleProcessingType
    File? targetBed
}

# AnnotationSettings provides annotation resources for executing annotation
# tools (eg. ANNOVAR).
struct AnnotationSettings {
    String annovarBuildver
    String annovarProtocol
    String annovarOperation
    String annovarArgument
    Array[File] annovarHumandb
    Array[File] annovarScripts
}
