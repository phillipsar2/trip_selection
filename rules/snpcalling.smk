### CREATING AND FILTERING VCFs FROM SEQUENCES ###
#### code modified from: https://github.com/phillipsar2/poa_genome
#### Thank you to Alyssa Phillips for reference code and her immense amount of guidance

# align reads to the reference genome
# module load bwa-mem2/2.2.1_x64-linux
rule bwa_map:
    input:
        ref = config["ref"],
        r1 = "data/raw/{read}_1.fq.gz",
        r2 = "data/raw/{read}_2.fq.gz"
    output:
        temp("data/interm/mapped_bam/{read}.mapped.bam")
    threads: 4
    shell:
        "bwa-mem2 mem -t {threads} {input.ref} {input.r1} {input.r2} |"
        "samtools view -Sb > {output}"
# take intermediate bam file, sorts and stores in different directory
# module load samtools/1.9 
rule samtools_sort: 
    input:
        config["map.bam"]
    output:
        config["sort.bam"]
    params:
        tmp = "/scratch/julespor/sort_bam/{read}"
    threads: 4
    run:
        shell("mkdir -p {params.tmp}")
        shell("samtools sort -T {params.tmp} -@ {threads} {input} > {output}")
        shell("rm -rf {params.tmp}")

# mark duplicate reads
## module load GATK/4.2.3.0
rule mark_dups:
    input:
        config["sort.bam"]
    output:
        bam = config["mark.dups"],
        metrics = "qc/mark_dup/{read}_metrics.txt"
    params:
        tmp = "/scratch/julespor/mark_dups/{read}"
    run:
        shell("mkdir -p {params.tmp}")
        shell("gatk MarkDuplicates \
        -I={input} \
        -O={output.bam} \
        --METRICS_FILE={output.metrics} \
        --CREATE_INDEX=true \
        -MAX_FILE_HANDLES=1000 \
        --ASSUME_SORT_ORDER=coordinate \
        --TMP_DIR={params.tmp}")
        shell("rm -rf {params.tmp}")

# merge sorted bams
rule merge_bams:
    input:
        A = "data/interm/mark_dups/{mergeA}.dedup.bam",
        B = "data/interm/mark_dups/{mergeB}.dedup.bam"
    output:
        config["merg.bam"]
    threads: 4
    shell:
        """samtools merge -@ {threads} {output} {input.A} {input.B}"""

"""
# add read groups to merged BAM file
rule add_rg:
    input:
        "data/interm/merge/{bam}.dedup.bam"
    output:
        bam = touch("data/interm/rg_bam/{bam}.dedup.add_rg.bam")
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
"""

# generate VCFs from BAM files
# https://samtools.github.io/bcftools/bcftools.html#call
# module load bcftools/1.10.2
rule vcf_gen:
    input:
        ref=config["ref"],
        bam=config["bam.list"]
    output:
        config["raw.vcf"]
    params:
        region = "{scaf}"
    shell:
        """
        module load bcftools
        bcftools mpileup -Ou --annotate FORMAT/AD,FORMAT/DP -f {input.ref} \
        -b {input.bam} -r {params.region} --threads 8 | bcftools call -mv -Oz -o {output}
        bcftools index -t {output}
        """

# Select only bialleleic SNPs
rule get_snps:
    input:
        ref = config["ref"],
        vcf = config["raw.vcf"]
    output:
        config["unfil.snps"]
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

# filtering primarily followed GATK's best practices for non-model organisms https://evodify.com/gatk-in-non-model-organism/

# Filtering diagnostics -- selected 3 vcfs to execute on bash instead
# Extract variant quality scores (used to detertmine criteria for hard filter) 
# https://gatk.broadinstitute.org/hc/en-us/articles/360037499012?id=3225
# https://gatk.broadinstitute.org/hc/en-us/articles/360037499012?id=3225 (from Alyssa)
"""
rule diagnostics:
    input:
        vcf = "data/vcf/snps/scaf_20,scaf_21.snps.vcf","data/vcf/snps/scaf_8.snps.vcf.gz","data/vcf/snps/scaf_111,scaf_112,scaf_113.snps.vcf.gz",
        ref = config["ref"]
    output:
        "data/reports/variantstotable/scaf_20_21.snps.vcf.table","data/reports/variantstotable/scaf_8.snps.vcf.table","data/reports/variantstotable/scaf_111_113.snps.vcf.table" 
    run:
        shell("gatk VariantsToTable \
        -R {input.ref} \
        -V {input.vcf} \
        -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F AD \
        -O {output}")
"""

# Apply hard filtering following GATK best practices - remove low confidence sites
# https://gatk.broadinstitute.org/hc/en-us/articles/360035531112?id=23216#2 https://gatk.broadinstitute.org/hc/en-us/articles/360037499012?id=3225
rule hard_filter:
    input:
        config["unfil.snps"]
    output:
        filt =  config["hard.filt"],
#       filt = low quality sites are labeled but not removed
        exclude = config["hard.excl"]
#       exclude = low quality sites removed
    run:
        shell("gatk VariantFiltration \
        -V {input} \
        -filter \"QUAL < 30.0\" --filter-name \"QUAL30\" \
        -filter \"MQ < 20.0\" --filter-name \"MQ20\" \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

# filtering for different genotype depths; removes indidivuals at a site
# compared 5 different depth options:
##### 2 - 4
##### 2 - 8
##### 2 - 12
##### 1 - 8 (chosen depth filter in the end)
##### 1 - 12
rule depth2_4:
    input:
        ref = config["ref"],
        vcf = config["hard.excl"]
    output:
        filt = "data/vcf/depth_filter/DP2_4/{scaf}.DP2_4.filtered.snps.vcf.gz",
        exclude = "data/vcf/depth_filter/DP2_4/{scaf}.nocall.DP2_4.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 4\" \
        -G-filter-name [DP_2-4] \
        --set-filtered-genotype-to-no-call true \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

rule depth2_8:
    input:
        ref = config["ref"],
        vcf = config["hard.excl"]
    output:
        filt = "data/vcf/depth_filter/DP2_8/{scaf}.DP2_8.filtered.snps.vcf.gz",
        exclude = "data/vcf/depth_filter/DP2_8/{scaf}.nocall.DP2_8.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 8\" \
        -G-filter-name [DP_2-8] \
        --set-filtered-genotype-to-no-call true \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

rule depth2_12:
    input:
        ref = config["ref"],
        vcf = config["hard.excl"]
    output:
        filt = "data/vcf/depth_filter/DP2_12/{scaf}.DP2_12.filtered.snps.vcf.gz",
        exclude = "data/vcf/depth_filter/DP2_12/{scaf}.nocall.DP2_12.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 2 || DP > 12\" \
        -G-filter-name [DP_2-12] \
        --set-filtered-genotype-to-no-call true \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

rule depth1_12:
    input:
        ref = config["ref"],
        vcf = config["hard.excl"]
    output:
        filt = "data/vcf/depth_filter/DP1_12/{scaf}.DP1_12.filtered.snps.vcf.gz",
        exclude = "data/vcf/depth_filter/DP1_12/{scaf}.nocall.DP1_12.filtered.snps.vcf.gz"
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 1 || DP > 12\" \
        -G-filter-name [DP_1-12] \
        --set-filtered-genotype-to-no-call true \
        -O {output.filt}") 
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

rule depth1_8:
    input:
        ref = config["ref"],
        vcf = config["hard.excl"]
    output:
        filt = config["dp.filt"],
        exclude = config["dp.excl"]
    run:
        shell("gatk VariantFiltration \
        -R {input.ref} \
        -V {input.vcf} \
        -G-filter \"DP < 1 || DP > 8\" \
        -G-filter-name [DP_1-8] \
        --set-filtered-genotype-to-no-call true \
        -O {output.filt}")
        shell("gatk SelectVariants -V {output.filt} --exclude-filtered true \
        -O {output.exclude}")

# max no call - set the maximum proportions of individuals at a site that can be missing (from the depth filter)
#               for the site to not be removed
# max no call fraction set to 20%
rule max_no_call2_4:
    input:
        vcf = "data/vcf/depth_filter/DP2_4/{scaf}.DP2_4.filtered.snps.vcf.gz"
    output:
        nocall = "data/vcf/max_no_call/DP2_4/{scaf}.maxnocall.DP2_4.filtered.snps.vcf.gz"
    run:
        shell("gatk SelectVariants -V {input.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule max_no_call2_8:
    input:
        vcf = "data/vcf/depth_filter/DP2_8/{scaf}.DP2_8.filtered.snps.vcf.gz"
    output:
        nocall = "data/vcf/max_no_call/DP2_8/{scaf}.maxnocall.DP2_8.filtered.snps.vcf.gz"
    run:
        shell("gatk SelectVariants -V {input.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule max_no_call2_12:
    input:
        vcf = "data/vcf/depth_filter/DP2_12/{scaf}.DP2_12.filtered.snps.vcf.gz"
    output:
        nocall = "data/vcf/max_no_call/DP2_12/{scaf}.maxnocall.DP2_12.filtered.snps.vcf.gz"
    run:
        shell("gatk SelectVariants -V {input.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule max_no_call1_12:
    input:
        vcf = "data/vcf/depth_filter/DP1_12/{scaf}.DP1_12.filtered.snps.vcf.gz"
    output:
        nocall = "data/vcf/max_no_call/DP1_12/{scaf}.maxnocall.DP1_12.filtered.snps.vcf.gz"
    run:
        shell("gatk SelectVariants -V {input.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

rule max_no_call1_8:
    input:
        vcf = config["dp.filt"]
    output:
        nocall = "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf.gz"
    run:
        shell("gatk SelectVariants -V {input.vcf} \
        --exclude-filtered true --max-nocall-fraction .2 -O {output.nocall}")

# merge VCFs
rule merge_vcf:
    input:
        expand(config["max.no.call"], scaf = SCAF)
    output:
        config["final.vcf"]
    run:
        shell("module load bcftools")
        shell("bcftools concat {input} -Oz -o {output}")

# VCFs had incorrect sample naming
## merged final VCF had samples renamed using bash script
rule resample:
    input:
        vcf = config["max.no.call"]
        sample.list = config["sample.list"]
    output:
        config["renamed.vcf"]
    run:
        shell("module load bcftools")
        shell("bcftools reheader -s {input.sample.list} \
        -o {output} {input.vcf}")
