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


# -------------------------------------------------------------------------------------------------
# Package Name: FreeBayes
# Task Summary: FreeBayes is a Bayesian genetic variant detector
# Tool Name: FreeBayes
# Documentation: https://github.com/ekg/freebayes
# ---------------------------

task FreeBayes {
  input {

    File reference
    File reference_idx

    File ? intervals

    String outputPrefix
    File bam_file
    File bam_idx_file

    String userString = "-4 -q 15 -F 0.03"

    Float memory = 12
    Int cpu = 1

    String output_filename = outputPrefix + '.freebayes.vcf'

    String dockerImage = "quay.io/biocontainers/freebayes:1.3.2--py37hc088bd4_0"

  }

  command {
    set -Eeuxo pipefail;
    test -f ~{bam_idx_file}
    freebayes \
      -f ~{reference} \
      ~{"-t " + intervals} \
      ~{bam_file} \
      ~{userString} \
      -v ~{output_filename};
  }

  output {
    File vcf_file = "~{output_filename}"
  }

  runtime {
    memory: memory + " GB"
    cpu: cpu
    docker: dockerImage

  }

  parameter_meta {
        reference: {description:"Reference sequence file.", category: "required"}
        reference_idx: {description: "Reference sequence index (.fai).", category: "required"}
        intervals: {description: "One or more genomic intervals over which to operate.", category: "required"}
        bam_file: {description: "Sorted BAM file.", category: "required"}
        bam_idx_file: {description: "Sorted BAM index file.", category: "required"}
        output_filename: {description: "VCF output file name Default is prefix + vcf.", category: "common"}
        userString: {description: "An optional parameter which allows the user to specify additions to the command line at run time.", category: "common"}
        memory: {description: "GB of RAM to use at runtime.", category: "advanced"}
        cpu: {description: "Number of CPUs to use at runtime.", category: "advanced"}
        dockerImage: {description: "Docker image for running the varcaller.", category: "advanced"}
  }

}