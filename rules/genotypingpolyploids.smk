### Making matrices to calculate genotype depth in polyploids ###

# create alternative and total allele count matrices for each unmerged vcf along with error file
# to be used as input for EBG
rule unzip:
    input:
        config["renamed.vcf"]
    output:
        "data/vcf/final/rename/{scaf}.DP1_8.final.rename.vcf"
    run:
        shell("gunzip -d {input}")

rule create_input:
    input:
        vcf = "data/vcf/final/rename/{scaf}.DP1_8.final.rename.vcf"
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
        samp = "{scaf}.sample_names.txt",
        loci = "{scaf}.loci_positions.txt",
        vcf = "data/vcf/final/rename/{scaf}.DP1_8.final.rename.vcf"
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
        p = "4",
        prefix = "data/ebg/output/{scaf}-diseq"    
    shell:
        """
        sample=`wc -l {input.samp}`
        loci=`wc -l {input.loci}`
        polyploid-genotyping/ebg/ebg diseq \
        -p {params.p} \
        -n $sample \
        -l $loci \
        -t {input.tot} \
        -a {input.alt} \
        -e {input.err} \
        -iters 1000 \
        --prefix {params.prefix}
        """

# convert ebg PL output to GL matrix 
rule gl_mat:
    input:
        tot = "data/ebg/input/{snps}.tot.txt",
        geno = "data/ebg/input/{snps}.sample_names.txt",
        snps = "data/ebg/input/{snps}.loci_positions.txt",
        pl = "data/ebg/output/{snps}-diseq-PL.txt"
    output:
        "data/ebg/output/{snps}-GL.txt"
    shell:
        """
        Rscript scripts/ebg/ebg2glmatrix.R --tot {input.tot} -p 4 --geno {input.geno} -s {input.snps} {input.pl}
        """

# assessing convergence of entropy output by generating traceplots
rule trace_plot:
    input:
        "data/entropy/output/mcmc.20k.noNA.k{kclusters}.c{chain}.hdf5"
    output:
        "data/entropy/output/traceplots.k{kclusters}.c{chain}.pdf"
    script:
        "Rscript rules/assess.convergence.snake.R {input}"

# assessing convergence of entropy output by lookting at R^ statistic across 3 chains for a given K
rule r_hat:
    input:
        chain1 = "data/entropy/output/mcmc.20k.noNA.k{kclusters}.c1.hdf5",
        chain2 = "data/entropy/output/mcmc.20k.noNA.k{kclusters}.c2.hdf5",
        chain3 = "data/entropy/output/mcmc.20k.noNA.k{kclusters}.c3.hdf5"
    output:
        "data/entropy/output/rstat.k{kclusters}.txt"
    run:
        shell("module load bio3")
        shell("source activate entropy-2.0")
        shell("entropy -p q -s 4 {input.chain1} {input.chain2} {input.chain3} -o {output}")
