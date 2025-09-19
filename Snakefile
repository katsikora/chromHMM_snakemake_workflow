################################config files ############################################

configfile: "config/config.yaml"
configfile: "organisms/mm10_gencodeM19.yaml"

#######################################################################################

wildcard_constraints:
    k = [ str(x) for x in range(config["min_states"],config["max_states"]+1)]


include: "snakefiles/segment.smk"
include: "snakefiles/enrichments.smk"


