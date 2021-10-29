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


task Merge {

    runtime {
        docker: "biowdl/curl"
    }

    output {
        File out = "output.csv"
    }

    command {
        cat ${sep = ' ' readsToMergeFwd} > ${outputPrefix}.merged_R1.fastq.gz
        cat ${sep = ' ' readsToMergeRev} > ${outputPrefix}.merged_R2.fastq.gz
    }

    runtime {
        docker: dockerImage
    }

    output {
      File trimmedReadsFwd = "${outputPrefix}.merged_R1.fastq.gz"
      File trimmedReadsRev = "${outputPrefix}.merged_R2.fastq.gz"
    }

    parameter_meta {
        # Inputs:
        readsToMergeFwd: {description:"The first-end fastq file.", category: "required"}
        readsToMergeRev: {description: "The second-end fastq file.", category: "required"}
        outputPrefix: {description: "Output prefix for the fastq files.", category: "required"}
        dockerImage: {description: "Docker Image for Merge the fastq files", category: "advanced"}

    }

}
