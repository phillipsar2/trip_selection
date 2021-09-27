configfile: "config.yaml"

SKELETON = config["scaffolds"]
#scaffolds listed three per line, separated by commas within line
GHOST = list(SKELETON.split())
#GHOST- python list
BAM = glob_wildcards("data/merged_bams/{bam}.bam").bam

PEAR = glob_wildcards("data/bed_files/{pear}.FINAL.bed").pear


rule all:
    input:
        coverage = expand("data/coverage/{pear}/{bam}.{pear}.coverage.bed", bam = BAM, pear = PEAR)

include: "rules/bedtools.smk"

# generate coverage data for BAM files
rule qualimap:
    input:
        "data/raw_bams/{bam}_dedup.bam"
    output:
        "data/reports/bam_qualimaps/{bam}_stats/report.pdf"
    params:
        dir = "data/reports/bam_qualimaps/{bam}_stats"
    run:
        shell("qualimap bamqc -bam {input} -outdir {params.dir} -outformat PDF")

### CREATING AND FILTERING VCFs FROM BAM FILES ###

# generate VCFs from BAM files
rule vcf_gen:
    input:
        fasta="data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        bam="data/rg_bam/bam_list.txt"
    output:
        "data/vcf/raw_vcf/{ghost}.vcf.gz"
    params:
        region = "{ghost}"
    shell:
        """
        module load bcftools
        bcftools mpileup -Ou --annotate FORMAT/AD,FORMAT/DP -f {input.fasta} \
        -b {input.bam} -r {params.region} --threads 8 | bcftools call -mv -Oz -o {output}
        bcftools index -t {output}
        """

# add read groups to merged BAM file 
rule add_rg:
    input:
        "data/merged_bams/{bam}.bam"
    output:
        bam = touch("data/rg_bam/{bam}_add_rg.bam")
    params:
        tmp = "/scratch/julespor/addrg/{bam}",
        sample = "{bam}"
    run:
        shell("mkdir -p {params.tmp}")
        shell("gatk AddOrReplaceReadGroups \
        -I={input} \
        -O={output.bam} \
        -RGID=4 \
        -RGLB=lib1 \
        -RGPL=illumina \
        -RGPU=unit1 \
        -RGSM={params.sample} \
        --TMP_DIR {params.tmp} \
        --CREATE_INDEX=true")
        shell("rm -rf {params.tmp}")

# VCFs were actually in binary (bcf) format --> convert to compressed vcf before gatk SelectVariants
# not used in final processing (fixed issue down the line)
rule bcf_to_vcf:
    input:
        bcf = "data/vcf/raw_vcf/{ghost}.vcf"
    output:
        vcf = "data/vcf/compressed_vcf/{ghost}.vcf.gz"
    params:
        temp = "tmp.{ghost}.vcf.gz"
    shell:
        """
        bcftools index -f {input.bcf}
        bcftools view -O z -o {params.temp} {input.bcf}
        mv {params.temp} {output.vcf}
        bcftools index -t {output.vcf}
        """

# Select only bialleleic SNPs
rule get_snps:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/raw_vcf/{ghost}.vcf.gz" 
    output:
        "data/vcf/snps/{ghost}.snps.vcf.gz"
    shell:
        """
        module load GATK
        gatk SelectVariants \
        -R {input.ref} \
        -V {input.vcf} \
        -select-type SNP \
        --restrict-alleles-to BIALLELIC \
        -O {output}
        """

# Filtering diagnostics -- selected 3 vcfs to execute on bash
# Extract variant quality scores
# https://evodify.com/gatk-in-non-model-organism/
rule diagnostics:
    input:
        vcf = "data/vcf/snps/{ghost}.snps.vcf",
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta"
    output:
        "data/reports/variantstotable/{ghost}.snps.vcf.table"
    run:
        shell("gatk VariantsToTable \
        -R {input.ref} \
        -V {input.vcf} \
        -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F AD \
        -O {output}")

# Apply hard filtering following GATK best practices - remove low confidence sites
# https://gatk.broadinstitute.org/hc/en-us/articles/360035531112?id=23216#2
# https://gatk.broadinstitute.org/hc/en-us/articles/360037499012?id=3225
rule hard_filter:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/snps/{ghost}.snps.vcf.gz"
    output:
        filt =  "data/vcf/hard_filter/{ghost}.filtered.snps.vcf.gz",
#filt=low quality sites are labeled but not removed
        exclude = "data/vcf/hard_filter/{ghost}.filtered.nocall.snps.vcf.gz"
#exclude=low quality sites removed
    run:
        shell("gatk VariantFiltration \
        -V {input.vcf} \
        -filter \"QUAL < 30.0\" --filter-name \"QUAL30\" \
        -filter \"MQ < 20.0\" --filter-name \"MQ20\" \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true  --restrict-alleles-to BIALLELIC -O {output.exclude}")

# filtering for different genotype depths; removes indidivuals at a site 
rule depth_filter1:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/hard_filter/{ghost}.filtered.nocall.snps.vcf.gz"
    output:
        vcf = "data/vcf/depth_filter/DP2_4/{ghost}.DP2_4.filtered.nocall.snps.vcf.gz",
        nocall = "data/vcf/max_no_call/DP2_4/{ghost}.maxnocall.DP2_4.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 4\" \
        -G-filter-name [DP_2-4] \
        --set-filtered-genotype-to-no-call true \
        -O {output.vcf}")
        shell("gatk SelectVariants -V {output.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule depth_filter2:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/hard_filter/{ghost}.filtered.nocall.snps.vcf.gz"
    output:
        vcf = "data/vcf/depth_filter/DP2_8/{ghost}.DP2_8.filtered.nocall.snps.vcf.gz",
        nocall = "data/vcf/max_no_call/DP2_8/{ghost}.maxnocall.DP2_8.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 8\" \
        -G-filter-name [DP_2-8] \
        --set-filtered-genotype-to-no-call true \
        -O {output.vcf}")
        shell("gatk SelectVariants -V {output.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule depth_filter3:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/hard_filter/{ghost}.filtered.nocall.snps.vcf.gz"
    output:
        vcf = "data/vcf/depth_filter/DP2_12/{ghost}.DP2_12.filtered.nocall.snps.vcf.gz",
        nocall = "data/vcf/max_no_call/DP2_12/{ghost}.maxnocall.DP2_12.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 12\" \
        -G-filter-name [DP_2-12] \
        --set-filtered-genotype-to-no-call true \
        -O {output.vcf}")
        shell("gatk SelectVariants -V {output.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

#ambiguitiy with bgzip = silenced on 8/16
"""
rule depth_filter4:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/hard_filter/{ghost}.filtered.nocall.snps.vcf.gz"
    output:
        vcf = "data/vcf/depth_filter/DP1_12/{ghost}.DP1_12.filtered.nocall.snps.vcf.gz",
        nocall = "data/vcf/max_no_call/DP1_12/{ghost}.maxnocall.DP1_12.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 1 || DP > 12\" \
        -G-filter-name [DP_1-12] \
        --set-filtered-genotype-to-no-call true \
        -O {output.vcf}")
        shell("gatk SelectVariants -V {output.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")
""" 

# remove individuals filtered in depth filter
rule passed_depth1:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/depth_filter/DP2_4/{ghost}.DP2_4.filtered.nocall.snps.vcf.gz"
    output:
        "data/vcf/depth_filter/passed/DP2_4/{ghost}.DP2_4.filtered.PASSED.vcf.gz"
    run:
        shell("gatk SelectVariants \
        -R {input.ref} \
        -V {input.vcf} \
        --set-filtered-gt-to-nocall true \
        --exclude-filtered true \
        -O {output}")

rule passed_depth2:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/depth_filter/DP2_8/{ghost}.DP2_8.filtered.nocall.snps.vcf.gz"
    output:
        "data/vcf/depth_filter/passed/DP2_8/{ghost}.DP2_8.filtered.PASSED.vcf.gz"
    run:
        shell("gatk SelectVariants \
        -R {input.ref} \
        -V {input.vcf} \
        --set-filtered-gt-to-nocall true\
        --exclude-filtered true \
        -O {output}")

rule passed_depth3:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/depth_filter/DP2_12/{ghost}.DP2_12.filtered.nocall.snps.vcf.gz"
    output:
        "data/vcf/depth_filter/passed/DP2_12/{ghost}.DP2_12.filtered.PASSED.vcf.gz"
    run:
        shell("gatk SelectVariants \
        -R {input.ref} \
        -V {input.vcf} \
        --set-filtered-gt-to-nocall true\
        --exclude-filtered true \
        -O {output}")

rule passed_depth4:
    input:
        ref = "data/genome/Tripsacum_dactyloides-southern_hifiasm-bionano_scaffolds_v1.0.fasta",
        vcf = "data/vcf/depth_filter/DP1_12/{ghost}.DP1_12.filtered.nocall.snps.vcf.gz"
    output:
        "data/vcf/depth_filter/passed/DP1_12/{ghost}.DP1_12.filtered.PASSED.vcf.gz"
    run:
        shell("gatk SelectVariants \
        -R {input.ref} \
        -V {input.vcf} \
        --set-filtered-gt-to-nocall true\
        --exclude-filtered true \
        -O {output}")

# merge VCFs 
rule gzip:
    input:
        "data/vcf/max_no_call/DP1_12/{ghost}.maxnocall.DP1_12.filtered.snps.vcf.gz"
    output:
        "data/vcf/max_no_call/DP1_12/{ghost}.maxnocall.DP1_12.filtered.snps.vcf"
    run:
        shell("gzip -d {input}")

rule bgzip:
    input:
        "data/vcf/max_no_call/DP1_12/{ghost}.maxnocall.DP1_12.filtered.snps.vcf"
    output:
        "data/vcf/max_no_call/DP1_12/{ghost}.maxnocall.DP1_12.filtered.snps.vcf.gz"
    run:
        shell("bgzip {input}")
        shell("tabix {output}")

rule merge_vcf:
    input:
        expand(config["final_vcf"], ghost = GHOST)
    output:
        "data/vcf/final/ALL.DP1_12.filtered.snps.vcf.gz"
    run:
        shell("module load bcftools")
        shell("bcftools concat {input} -Oz -o {output}")

### Making matrices to calculate genotype depth in polyploids ###

# extract allele depth using GATK Variants to table 
rule extract_depth:
    input:
        vcf = "data/vcf/final/ALL.DP1_12.filtered.snps.vcf.gz",
        ref = config["ref"]
    output:
        "data/reports/variantstotable/ALL.DP1_12.filtered.snps.AD.table"
    run:
        shell("module load R java maven")
        shell("module load GATK")
        shell("gatk VariantsToTable \
        -R {input.ref} \
        -V {input.vcf} \
        -F CHROM -F POS \
        -GF AD \
        -O {output}")
