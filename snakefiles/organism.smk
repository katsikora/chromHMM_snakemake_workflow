org_dict={
         "mm10": "https://zenodo.org/records/17531909/files/mm10.tgz?download=1"
         }

rule download_tgz:
    input: org_dict[organism]
    output: temp("organisms/" + organism + ".tgz")
    shell: """
            cd organisms && wget {input}
           """

rule extract_archive:
    input: "organisms/" + organism + ".tgz"
    output: "organisms/" + organism + "/input_bed/rmsk.bed",
            "organisms/"+organism+"/chrom_sizes.tsv"
    shell: """
        tar xzvf {input}
           """
