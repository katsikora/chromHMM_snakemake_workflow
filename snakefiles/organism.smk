storage:
    provider="http",
    retrieve=False

org_dict={
         "mm10": "https://zenodo.org/records/17531909/files/mm10.tgz"
         }

rule download_tgz:
    input: storage.http(org_dict[organism], keep_local=True)
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
