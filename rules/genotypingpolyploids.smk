### Making matrices to calculate genotype depth in polyploids ###

# extract allele depth from each final VCF using GATK Variants to table
rule extractAD:
    input:
        vcf = "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf.gz",
        ref = config["ref"]
    output:
        "data/reports/AD/uncut/{scaf}.maxnocall.DP1_8.filtered.snps.AD.table"
    run:
        shell("module load R java maven")
        shell("module load GATK")
        shell("gatk VariantsToTable \
        -R {input.ref} \
        -V {input.vcf} \
        -F CHROM -F POS \
        -GF AD \
        -O {output}")
# removing chrom and position columns to condense AD tables
rule cut:
    input:
        "data/reports/AD/uncut/{scaf}.maxnocall.DP1_8.filtered.snps.AD.table"
    output:
        "data/reports/AD/{scaf}.final.DP1_8.AD.table"
    run:
        shell("cut -f 3-44 {input} > {output}")

# create alternative and total allele count matrices for each unmerged vcf along with error file
rule unzip:
    input:
        "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf.gz"
    output:
        "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf"
    run:
        shell("gunzip -d {input}")

rule create_input:
    input:
        vcf = "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf"
    output:
        alt = "{scaf}.alt.txt",
        tot = "{scaf}.tot.txt",
        err = "{scaf}.err.txt",
        sam = "{scaf}.sample_names.txt",
        loci = "{scaf}.loci_positions.txt"
    script:
        "createinput.snake.R"

rule move_input:
    input:
        alt = "{scaf}.alt.txt",
        ref = "{scaf}.tot.txt",
        err = "{scaf}.err.txt",
        sam = "{scaf}.sample_names.txt",
        loci = "{scaf}.loci_positions.txt",
        vcf = "data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf"
    output:
        alt = "data/ebg/input/{scaf}.alt.txt",
        ref = "data/ebg/input/{scaf}.tot.txt",
        err = "data/ebg/input/{scaf}.err.txt",
        samp = "data/ebg/input/{scaf}.sample_names.txt",
        loci = "data/ebg/input/{scaf}.loci_positions.txt"
    run:
        shell("mv {input.alt} data/ebg/input/")
        shell("mv {input.ref} data/ebg/input/")
        shell("mv {input.err} data/ebg/input/")
        shell("mv {input.samp} data/ebg/input/")
        shell("mv {input.loci} data/ebg/input/")
        shell("gzip {input.vcf}")

# run ebg on each scaffold individually
rule diseq_ebg:
    input:
        alt = "data/ebg/input/{scaf}.alt.txt",
        tot = "data/ebg/input/{scaf}.tot.txt",
        err = "data/ebg/input/{scaf}.err.txt",
        samp = "data/ebg/input/{scaf}.sample_names.txt",
        loci = "data/ebg/input/{scaf}.loci_positions.txt"
    output:
# allele frequencies
#        freq = "data/ebg/output/{scaf}-diseq-freqs.txt",
# inbreeding coefficients
#        F = "data/ebg/output/{scaf}-diseq-F.txt",
# estimated genotypes
#        geno = "data/ebg/output/{scaf}-diseq-genos.txt",
# genotype likelihood 
        PL = "data/ebg/output/{scaf}-diseq-PL.txt"
    params:
        prefix = "data/ebg/output/{scaf}-diseq"    
    shell:
        """
        sample=`wc -l {input.samp}`
        loci=`wc -l {input.loci}`
        polyploid-genotyping/ebg/ebg diseq \
        -p 4 \
        -n $sample \
        -l $loci \
        -t {input.tot} \
        -a {input.alt} \
        -e {input.err} \
        -iters 1000 \
        --prefix {params.prefix}
        """
