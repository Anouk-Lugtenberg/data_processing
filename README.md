# Dataprocessing

## Usage
Snakemake pipeline for three Java programs that analyse DNA mutations found by Dutch genomic laboratories.

## How to get set-up?

Firstly: clone or fork this repository.

Secondly: the pipeline uses two external data sources.

### 1. Docker program
The Docker program can be downloaded from https://github.com/fdlk/vkgl. It should be running on localhost:1234 for this program to work.

### 2. Reference genome
A reference genome (.fa) and its indexed file (.fa.fai) should be stored locally. It can be downloaded from http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch37/.

In the config.yaml file the location of the fasta_file should be pointing at your own locally stored reference genome. 

After this simply run 'snakemake' in a terminal.

## Contact
Anouk Lugtenberg, ahclugtenberg@gmail.com
