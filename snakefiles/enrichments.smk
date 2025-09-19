def collect_segmentation_results():
    a
    _segments.bed
    new wildcard: group
    return(a)


rule overlapEnrichment:
    input: collect_segmentation_results(),
           dir(input_bed)
    output: "model_{k}_output/{group}_state_enrichments.txt"
    modulefile: "chromhmm/1.25"
    shell: """
        ChromHMM.sh OverlapEnrichment {input[0]} {input[1]} {output}
        """

rule neighbourhoodEnrichment:
    input: collect_segmentation_results(),
        TSS_bed
    output: "model_{k}_output/{group}_TSS_enrichment.txt"
    modulefile: "chromhmm/1.25"
    shell: """
        ChromHMM.sh NeighborhoodEnrichment {input[0]} {input[1]} {output}
        """

