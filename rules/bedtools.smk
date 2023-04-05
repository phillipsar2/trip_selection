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
# remove secondary alignments from BAM files
rule align_filt:
    input:
        config["indiv_bam"]
    output:
        "data/repeat_abundance/tmp/{bam}.primary.bam.gz"
    params:
        tmp = "data/repeat_abundance/tmp/{bam}.primary.bam"
    run:
#        shell("module load samtools")
        shell("samtools view -F 2048 -bo {params.tmp} {input}")
        shell("gzip {params.tmp}")

# convert filtered BAM files to bed files, sort, and remove duplicate positions (same chrom, start, stop)
# COMMENTED OUT ON: 04/04/23
# REASON: the output is the same as the output for the rule gzip below 
"""
rule bam2bed:
    input:
        "data/repeat_abundance/tmp/{bam}.primary.bam.gz"
    output:
#        bed = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed.gz",
        rmdup = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed.gz"
    params:
        tmp0 = "data/repeat_abundance/tmp/{bam}.primary.bam",
        tmp1 = "data/repeat_abundance/bed_files/indiv/{bam}.unsorted.bed",
        tmp2 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed",
        tmp3 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed"
    run:
#        shell("module load bedtools")
        shell("gzip -d {input}")
        shell("bedtools bamtobed -i {params.tmp0} > {params.tmp1}")
        shell("sort -k1,1 -k2,2n -k3,3n {params.tmp1} > {params.tmp2}")
        shell("sort -k1,1 -k2,2n -k3,3n -u {params.tmp2} > {params.tmp3}")
        shell("gzip {params.tmp0}")
        shell("gzip {params.tmp2}")
        shell("gzip {params.tmp3}")
        shell("rm {params.tmp1}")
"""
# i had issue with this rule where two jobs would try to work on the same input,
# this created problems with trying to unzip an already unzipped file, trying to
# zip a file another rule is using, etc
# SOO I unzipped all the inputs, and I'll rezip them when I'm done (see rule gzip below)
rule intersect:
    input:
        in1 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed",
        in2 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed",
        repeat = "data/repeat_abundance/bed_files/repeat/snake/{te}.final.bed"
    output:
        out1 = "data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.bed.gz",
        out2 = "data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.rmdup.bed.gz"
    params:
#        in1 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed",
#        in2 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed",
        tmp1 = "data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.bed",
        tmp2 = "data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.rmdup.bed"
    run:
#        shell("module load bedtools")
#        shell("gzip -d {input.in1}")
#        shell("gzip -d {input.in2}")
        shell("bedtools intersect -u -f 0.5 -s \
        -a {input.in1} -b {input.repeat} \
        > {params.tmp1}")
        shell("bedtools intersect -u -f 0.5 -s \
        -a {input.in2} -b {input.repeat} \
        > {params.tmp2}")
        shell("gzip {params.tmp1}")
        shell("gzip {params.tmp2}")
#        shell("gzip {params.in1}")
#        shell("gzip {params.in2}")

rule gzip:
    input:
        in1 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed",
        in2 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed"
    output:
        out1 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed.gz",
        out2 = "data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed.gz"
    run:
        shell("gzip {input.in1}")
        shell("gzip {input.in2}")
