configfile: "config.yaml"

import os
from shutil import copy2

DATASETS = ['amc', 'erasmus', 'lumc', 'nki', 'radboud', 'umcg', 'umcu', 'vumc']

rule all:
    input: config["data_directory"] + '/vcfFiles/threeTier/conflictingPathogenicVersusBenign.txt'

rule create_vcf_files:
    input:
        input_file = config["data_directory"] + '/{dataset}/',
        jar_file = config["jar_directory"] + '/vkgl.jar',
        fasta_file = config["fasta_file"]
    output: config["data_directory"] + '/{dataset}/normalizedData/vkgl_{dataset}.vcf'
    run:
        shell('java -jar {input.jar_file} -i {input.input_file} -f {input.fasta_file} -convert')

rule make_dir_vcf_files:
    input:
        config["data_directory"] + '/{dataset}/normalizedData/vkgl_{dataset}.vcf'
    output:
        config["data_directory"] + '/vcfFiles/vkgl_{dataset}.vcf'
    params:
        directory = config["data_directory"] + '/vcfFiles'
    run:
        if not os.path.exists(params[0]):
            os.mkdir(params[0])
        for f in input:
            copy2(f, params[0])

rule create_consensus:
    input:
        input_files = expand(config["data_directory"] + '/vcfFiles/vkgl_{dataset}.vcf', dataset=DATASETS),
        input_directory = config["data_directory"] + '/vcfFiles',
        jar_file = config["jar_directory"] + '/vkgl_consensus.jar'
    output: config["data_directory"] + '/vcfFiles/consensus.txt'
    shell:
         'java -jar {input.jar_file} -i {input.input_directory}'

rule create_data_consensus:
    input:
        consensus_file = config["data_directory"] + '/vcfFiles/consensus.txt',
        jar_file = config["jar_directory"] + '/vkgl_data_consensus.jar'
    output: config["data_directory"] + '/vcfFiles/threeTier/conflictingPathogenicVersusBenign.txt'
    shell:
         'java -jar {input.jar_file} -c {input.consensus_file}'