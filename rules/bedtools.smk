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

# remove entries for alternate scaffolds from coverage.bed files from the 3 TE classes
rule filterTEcov:
    input:
        "data/repeat_abundance/coverage/{rclass}/{eco}.{rclass}.flipped.coverage.bed.gz"
    output:
        "data/repeat_abundance/coverage/{rclass}/{eco}.{rclass}.noalt.coverage.bed.gz"
    params:
        alt = "data/repeat_abundance/coverage/{rclass}/{eco}.{rclass}.flipped.coverage.bed",
        noalt = "data/repeat_abundance/coverage/{rclass}/{eco}.{rclass}.noalt.coverage.bed"
    run:
        shell("gunzip -d {input}")
        shell("grep -iv 'alt' {params.alt} > {params.noalt}")
        shell("gzip {params.temp2}")

# for every intersect found between two files, a per base pair coverage is reported for file A (as of v2.24.0)
# https://bedtools.readthedocs.io/en/latest/content/tools/coverage.html
# INCORRECT METHOD
rule coverage:
    input:
        repeat = config["repeat_bed"],
        indiv = config["indiv_bed_merg"]
    output:
        "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed.gz"
    params:
        temp = "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed"
    run:
        shell("bedtools coverage -a {input.repeat} -b {input.indiv} -d > {params.temp}")
        shell("gzip {params.temp}")

# sums the fifth column of the coverage.bed files --> sum of the per base coverage for all regions mapping to repeat region
### will I be able to have one rule for A coverage and B coverage files?? I want to keep the sums separate 
rule sum_coverage:
    input:
        "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed.gz"
    output:
        "data/repeat_abundance/coverage/sum/{repeat}/{bam}.{repeat}.sum.txt"
    params:
        temp = "data/repeat_abundance/coverage/{repeat}/{bam}.{repeat}.coverage.bed"
    run:
        shell("gunzip -d {input}")
        shell("echo '{params.temp} total repeat coverage' > {output}")
        shell("awk -F '\t' '{{sum += $5}} END {{print sum}}' {params.temp} >> {output}")
        shell("gzip {params.temp}")
