import os
import re

def collect_segmentation_results(wildcards):
    # Get the output directory from the completed checkpoint
    output_dir = checkpoints.segmentBam.get(**wildcards).output[0]
    pattern = re.compile(r"(.+)_segments\.bed$")
    files = []

    for fname in os.listdir(output_dir):
        match = pattern.match(fname)
        if match:
            files.append(os.path.join(output_dir, fname))
    return files

def get_groups(wildcards):
    output_dir = checkpoints.segmentBam.get(**wildcards).output[0]
    groups = []
    for fname in os.listdir(output_dir):
        if fname.endswith("_segments.bed"):
            group = fname[:-len("_segments.bed")]
            groups.append(group)
    return groups


def get_batches(wildcards):
    # Get checkpoint output (bam_chunks directory)
    checkpoint_output = glob_wildcards(os.path.join(checkpoint_output, "bam_list_{batch}")).batch

    # Extract all batch names (based on chunked files)
    return glob_wildcards(f"{checkpoint_output}/bam_list_*").batch


rule overlapEnrichment:
    input: re.sub(r"\s+", "",f"model_{wildcards.k}_output/{wildcards.group}_segments.bed"),
           dir(input_bed)
    output: "model_{k}_output/{group}_state_enrichments.txt"
    modulefile: "chromhmm/1.25"
    shell: """
        ChromHMM.sh OverlapEnrichment {input[0]} {input[1]} {output}
        """

rule neighbourhoodEnrichment:
    input: re.sub(r"\s+", "",f"model_{wildcards.k}_output/{wildcards.group}_segments.bed"),
        TSS_bed
    output: "model_{k}_output/{group}_TSS_enrichment.txt"
    modulefile: "chromhmm/1.25"
    shell: """
        ChromHMM.sh NeighborhoodEnrichment {input[0]} {input[1]} {output}
        """

