version 1.0

# Copyright (c) 2021 Varsomics & Hospital Israelita Albert Einstein

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import "wdl-tasks/validate-inputs.wdl" as validate
import "wdl-structs/structs.wdl"
import "merge.wdl"
import "alignment.wdl"
import "varcall.wdl"

workflow GermlineVarcallDna {

  input {
        SampleInputs sampleInputs
        BwaIndex  bwaIndex
        Int bwaThreads = 1
        File reference
        File reference_idx
        File ? intervals

  }

    call validate.ValidateInputs {
        input:
            sampleName = sampleInputs.sampleName,
            fastqs1 = sampleInputs.fastqs1,
            fastqs2 = sampleInputs.fastqs2,

    }

    if (defined(sampleInputs.fastqs1) && defined(sampleInputs.fastqs2)) {
        Array[File] fastqs1 = select_first([sampleInputs.fastqs1])
        Array[File] fastqs2 = select_first([sampleInputs.fastqs2])
        String outputPrefix = sub(basename(fastqs1[0]), "_L001_R1_001.fastq.gz", "")

        call merge.Merge {
            input:
                readsToMergeFwd = fastqs1,
                readsToMergeRev = fastqs2,
                outputPrefix = outputPrefix
        }

        call alignment.BwaMem {
            input:
                read1 = Merge.trimmedReadsFwd,
                read2 = Merge.trimmedReadsRev,
                bwaIndex  = bwaIndex,
                outputPrefix = outputPrefix,
                threads = bwaThreads,
                memoryGb = 4
        }
        call varcall.FreeBayes {
            input:
                reference = reference,
                reference_idx = reference_idx,
                intervals  = intervals,
                outputPrefix = outputPrefix,
                bam_file = BwaMem.outputBam,
                bam_idx_file = BwaMem.outputBai
        }

    }

    parameter_meta {
        # inputs
        sampleInputs:{description:"Sample Inputs metadata including name, id, and fastqs", category: "required"}
        sampleName: {description: "The sample name", category: "required"}
        bwaIndex: {description: "The BWA index, including (optionally) a .alt file.", category: "required"}
        outputPrefix: {description: "The prefix of the output files, including any parent directories.", category: "required"}
        reference: {description:"Reference sequence file.", category: "required"}
        reference_idx: {description: "Reference sequence index (.fai).", category: "required"}
        intervals: {description: "A bed file describing the regions to call variants for.", category: "common"}
        bwaThreads: {description: "The number of threads to use for alignment.", category: "advanced"}
    }
}