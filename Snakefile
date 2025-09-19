################################config files ############################################

configfile: "config/config.yaml"
configfile: "organisms/mm10_gencodeM19.yaml"

#######################################################################################

#wildcard_constraints:
#    k = [ str(x) for x in range(config["min_states"],config["max_states"]+1)]
num_states = [ str(x) for x in range(config["min_states"],config["max_states"]+1)]

include: "snakefiles/segment.smk"
include: "snakefiles/enrichments.smk"

rule all:
    input:
        expand("model_{k}_output/{group}_segments.bed",k=num_states,group=get_groups()),
        expand("model_{k}_output/{group}_state_enrichments.txt",k=num_states,group=get_groups()),
        expand("model_{k}_output/{group}_TSS_enrichment.txt",k=num_states,group=get_groups())
