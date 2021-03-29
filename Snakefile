rule all:
    input:
        "data/vcf/vcf_scaf_1.vcf"
rule vcf_gen:
    input:
        fasta="data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        bam="data/raw_bams/bam_list.txt"
    output:
        "data/vcf/vcf_scaf_1.vcf"
    params:
        region="scaf_1"
    run:
        shell("module load bcftools")
        shell("bcftools mpileup -Ou --annotate FORMAT/AD,FORMAT/DP -f {input.fasta} -b {input.bam} -r {params.region} | bcftools call -mv -Oz -o {output}")



#configfile: "scaffold_config.yaml"

#rule all: 
#    input:
#        expand("data/vcf/vcf_{pumpkin}.vcf", pumpkin = config["scaffolds"])

#rule vcf_gen:
#    input:
#        fasta="data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
#        bam="data/raw_bams/bam_list.txt"
#    output:
#        "data/vcf/vcf_{pumpkin}.vcf"
#    params:
#        region="{pumpkin}"
##last attempt: TypeError in line 15 of /group/jrigrp10/tripsacum_dact/Snakefile:
##              unhashable type: 'dict'
#   shell:
#        "module load bcftools"
#       "bcftools mpileup -Ou --annotate FORMAT/AD,FORMAT/DP -f {input.fasta} \
#       -b {input.bam} -r {params.region} | bcftools call -mv -Oz -o {output}"

#rule qualimaps:
#    input:
#	expand("data/raw_bams/{sample}.bam", sample = config["bams"]
###could I then just add the path to the raw bams to my config file?
#    output:
#       "data/bam_qualimaps/{sample}_report.pdf"
#    shell:
#        "module load R"
#        "module load qualimaps"
#        "qualimaps bamqc -bam {input} -outfile {output} -outformat PDF"
