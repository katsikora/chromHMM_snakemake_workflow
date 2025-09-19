rule binarizeBam:
    input: 
        bam_dir = input_dir,
        sample_table = cellmarkfiletable,
        chrom_sizes = chrom_sizes #from organism.yaml, require
    output: temp(dir("binarizedBams"))
    params:
    modulefile: "chromhmm/1.25"
    log: "logs/binarizeBam.log"
    shell: """
        ChromHMM.sh BinarizeBam -paired {input.chrom_sizes} {input.bam_dir} {input.sample_table} {output} 2>{log}
        """

def collect_binarized_bams():
    a
    return a


rule segmentBam:
    input:
        binarizedBams = collect_binarized_bams()
    output:
        dir("model_{k}_output")
    params:
        num_states = lambda wildcards: wildcards.k,
        genome = genome,
        binarizedBams = "binarizedBams"
    modulefile: "chromhmm/1.25"
    shell: """
        ChromHMM.sh LearnModel {params.binarizedBams} {output} {params.num_states} {params.genome}
        """

