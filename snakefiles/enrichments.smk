import os
import re

rule overlapEnrichment:
    input: "model_{k}_output/{group}_{k}_segments.bed",
           config["input_bed"]
    output: "model_{k}_output/{group}_{k}_state_enrichments.txt"
    params:
        prefix = "model_{k}_output/{group}_{k}_state_enrichments"
    envmodules: "chromhmm/1.25"
    shell: """
        ChromHMM.sh OverlapEnrichment {input[0]} {input[1]} {params.prefix}
        """

rule neighbourhoodEnrichment:
    input: "model_{k}_output/{group}_{k}_segments.bed",
        config["TSS_bed"]
    output: "model_{k}_output/{group}_{k}_TSS_enrichment.txt"
    params:
        prefix = "model_{k}_output/{group}_{k}_TSS_enrichment"
    envmodules: "chromhmm/1.25"
    shell: """
        ChromHMM.sh NeighborhoodEnrichment {input[0]} {input[1]} {params.prefix}
        """

#rule done_all:
#    input: expand("model_{k}_output/{group}_TSS_enrichment.txt",k=num_states,group=get_groups()),
#        expand("model_{k}_output/{group}_state_enrichments.txt",k=num_states,group=get_groups())
#    output: touch("done.all")
