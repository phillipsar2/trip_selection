configfile: "config.yaml"
import pandas as pd

# WILD CARDS 
### names of raw unmerged sequence reads 
READ = glob_wildcards("data/raw/{read}_1.fq.gz").read
### merge bam files - file contains a list of genotype followed by two sequence names to be merged
file = pd.read_table("bamstomerge.tsv", sep = "\t", header = 0)
MERGE_A = list(file.Merge_A)
MERGE_B = list(file.Merge_B)
GENO = list(file.Genotype)
### names of merged bam files + 1 file that did not need to be merged (sequenced once)
BAM = glob_wildcards("data/interm/rg_bam/{bam}.dedup.add_rg.bam").bam
### scaffold groupings for vcf files based on relative size of scaffolds 
SCAFFOLD = config["scaffolds"]
SCAF = list(SCAFFOLD.split())
### scaffolds that after all filters still contains snps
CONTAINSSNPS = config["contains_snps"]
SNPS = list(CONTAINSSNPS.split())
### name of Ecotype_Indiv of 42 Tripsacum individuals 
ECO = glob_wildcards("data/repeat_abundace/coverage/helitron/{eco}.helitron.flipped.coverage.bed.gz").eco
### names of all repeats used for analysis, including TEs
REPEATCLASS = config["repeat"]
REPEAT = list(REPEATCLASS.split())
### K values for entropy admixture estimates
KCLUSTERS = ["2", "3", "4", "5", "6", "7", "8"]
### chain number for entropy runs (also used as seed)
CHAIN = ["1", "2", "3"]
### TEs to be intersected with indiv.bed files to assess repeat abundance
TE = ["allTE", "helitron", "LTR", "TIR"]

rule all:
    input:
# snpcalling rules
#        align_and_sort = expand("data/interm/sorted_bam/{read}.sorted.bam", read = READ)
#        mark_dups = expand("data/interm/mark_dups/{read}.dedup.bam", read = READ)
#        merge = expand("data/interm/merge/{geno}.{mergeA}.{mergeB}.merged.dedup.bam", zip, geno = GENO, mergeA = MERGE_A, mergeB = MERGE_B)
#        add_rg = expand("data/interm/rg_bam/{bam}.dedup.add_rg.bam", bam = BAM)
#        vcf_gen = expand("data/vcf/raw_vcf/{scaf}.vcf.gz", scaf = SCAF),
#        get_snps = expand("data/vcf/snps/{scaf}.snps.vcf.gz", scaf = SCAF)
#        hard_filt = expand("data/vcf/hard_filter/{scaf}.filtered.2.snps.vcf.gz", scaf = SCAF),
#        hard_excl = expand("data/vcf/hard_filter/{scaf}.nocall.filtered.2.snps.vcf.gz", scaf = SCAF)
#        dp_filt1 = expand("data/vcf/depth_filter/DP2_4/{scaf}.DP2_4.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_filt2 = expand("data/vcf/depth_filter/DP2_8/{scaf}.DP2_8.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_filt3 = expand("data/vcf/depth_filter/DP2_12/{scaf}.DP2_12.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_filt4 = expand("data/vcf/depth_filter/DP1_12/{scaf}.DP1_12.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_filt5 = expand("data/vcf/depth_filter/DP1_8/{scaf}.DP1_8.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_excl1 = expand("data/vcf/depth_filter/DP2_4/{scaf}.nocall.DP2_4.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_excl2 = expand("data/vcf/depth_filter/DP2_8/{scaf}.nocall.DP2_8.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_excl3 = expand("data/vcf/depth_filter/DP2_12/{scaf}.nocall.DP2_12.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_excl4 = expand("data/vcf/depth_filter/DP1_12/{scaf}.nocall.DP1_12.filtered.snps.vcf.gz", scaf = SCAF),
#        dp_excl5 = expand("data/vcf/depth_filter/DP1_8/{scaf}.nocall.DP1_8.filtered.snps.vcf.gz", scaf = SCAF)
#        maxnocall1 = expand("data/vcf/max_no_call/DP2_4/{scaf}.maxnocall.DP2_4.filtered.snps.vcf.gz", scaf = SCAF)
#        maxnocall2 = expand("data/vcf/max_no_call/DP2_8/{scaf}.maxnocall.DP2_8.filtered.snps.vcf.gz", scaf = SCAF),
#        maxnocall3 = expand("data/vcf/max_no_call/DP2_12/{scaf}.maxnocall.DP2_12.filtered.snps.vcf.gz", scaf = SCAF),
#        maxnocall4 = expand("data/vcf/max_no_call/DP1_12/{scaf}.maxnocall.DP1_12.filtered.snps.vcf.gz", scaf = SCAF),
#        maxnocall5 = expand("data/vcf/max_no_call/DP1_8/{scaf}.maxnocall.DP1_8.filtered.snps.vcf.gz", scaf = SCAF)
#        merge_vcf = expand("data/vcf/final/ALL.DP1_8.filtered.snps.vcf.gz")
# genotypingpolyploids rules
#        subsetAD = expand("data/reports/AD/{ghost}.final.AD.table", ghost = GHOST)
#        cut = expand("data/reports/AD/{scaf}.final.DP1_8.AD.table", scaf = SCAF)
#        alt = expand("data/ebg/input/{scaf}.alt.txt", scaf = SCAF),
#        tot = expand("data/ebg/input/{scaf}.tot.txt", scaf = SCAF)
#        err = expand("data/ebg/input/{scaf}.err.txt", scaf = SCAF)
#        sample = expand("data/ebg/input/{scaf}.loci_positions.txt", scaf = SCAF)
#        ebg = expand("data/ebg/output/{scaf}-diseq-PL.txt", scaf = SCAF)
#        gl_matrix = expand("data/ebg/output/{snps}-GL.txt", snps = SNPS)
#        traceplots = expand("data/entropy/output/traceplots.k{kclusters}.c{chain}.pdf", kclusters = KCLUSTERS, chain = CHAIN)
#        rhat = expand("data/entropy/output/rstat.k{kclusters}.txt", kclusters = KCLUSTERS)
# bedtools rules
#        bamtobed1 = expand("data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed", bam = BAM),
#        bamtobed2 = expand("data/repeat_abundance/bed_files/indiv/{bam}.sorted.cut.bed", bam = BAM)
#        mergebed = expand("data/repeat_abundance/bed_files/indiv/{bam}.sorted.cut.merged.bed", bam = BAM)
#        remo_alt = expand("data/repeat_abundance/coverage/{rclass}/{bam}.{rclass}.noalt.flipped.coverage.bed.gz", bam = BAM, rclass = RCLASS)
#        rmdup_bed = expand("data/repeat_abundance/bed_files/indiv/{bam}.sorted.rmdup.bed.gz", bam = BAM)
        TEintersect1 = expand("data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.bed.gz", bam = BAM, te = TE),
        TEintersect2 = expand("data/repeat_abundance/intersect/{te}/{bam}.{te}.intersect.rmdup.bed.gz", bam = BAM, te = TE), 
        #gzip_bed_file = expand("data/repeat_abundance/bed_files/indiv/{bam}.sorted.bed.gz", bam = BAM)
# qualimap
#        expand("data/reports/qualimap/{bam}_stats/report.pdf", bam = BAM)

# Rules
#include: "rules/snpcalling.smk"
include: "rules/bedtools.smk"
#include: "rules/genotypingpolyploids.smk"
#include: "rules/qualimap.smk"
