### BEDTOOLS ###
# intersecting tripsacum indidividuals with repeats blasted to reference genome to compare relative abundance of repeats

# blasting each repeat sequence to reference genome
rule blast:
    input:
        query = config["repeat_fasta"],
        db = "data/genome/v1/Tripsacum_db"
    threads: 4
    output:
        config["blast"]
    run:
        shell("blastn -query {input.query} -db {input.db} \
        -outfmt '7 qseqid sseqid length qlen slen qstart qend sstart send evalue' \
        -out {output} -num_threads {threads}")
         

# convert 47 individual BAMs to .bed file for comparison to repeat.bed
rule bamtobed:
    input:
        config["indiv_bam"]
    params:
        temp = "data/interm/rg_bam/temp1.{bam}.bed",
    output:
        full = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed",
        cut = config["indiv_bed"]
    run:
        shell("module load bedtools")
        shell("bedtools bamtobed -i {input} > {params.temp}")
        shell("sort -k1,1 -k2,2n {params.temp} > {output.full}")
        shell("cut -f 1-3 {output.full} > {output.cut}")
        shell("rm {params.temp}")

# merge individual.bed files to remove overlapping regions
rule mergebed:
    input:
        config["indiv_bed"]
    output:
        config["indiv_bed_merg"]
    run:
        shell("module load bedtools")
        shell("bedtools merge -c 1 -o count -i {input} > {output}")

# for every intersect found between two files, a per base pair coverage is reported for file A (as of v2.24.0)
# https://bedtools.readthedocs.io/en/latest/content/tools/coverage.html
rule coverage:
    input:
        repeat = config["repeat_bed"],
        indiv = config["indiv_bed_merg"]
    output:
        "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed" 
    run:
        shell("bedtools coverage -a {input.indiv} -b {input.repeat} -d > {output}")
rule zipcov:
    input:
        "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed"
    output:
        config["coverage"]
    run:
        shell("gzip {input}")
 
# takes the average cover per region of intersection using R script 
rule avg_cov_test:
    input:
        "data/coverage/raw_data/180knob/12836_16.180knob.coverage.bed"
    output:
        "data/coverage/average/180knob/12836_16.180knob.avg_cov.bed"
    script:
        "scripts/avg_cov/avg_repeat_coverage.snaketest.R"
