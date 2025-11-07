# chromHMM_snakemake_workflow

To create the main conda environment, run ```mamba env create -f env.yaml```.
After activating the environment and updating the config file, run workflow with:
```snakemake --cores 1 --use-envmodules``` . The workflow is currently configured to run locally.

The organism is set in the config file under configs/config.yaml. Annotation files can be pointed to in the config as well, else they will be fetched from zenodo. Currently, only mm10 is supported.
