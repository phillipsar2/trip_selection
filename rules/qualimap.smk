### Qualimap ###
# generate coverage data for BAM files

# http://qualimap.conesalab.org/doc_html/command_line.html
# https://sites.google.com/a/brown.edu/bioinformatics-in-biomed/qualimap-command-line

rule qualimap:
    input:
        "data/interm/rg_bam/{bam}.dedup.add_rg.bam"
    output:
        "data/reports/qualimap/{bam}_stats/report.pdf"
    params:
        dir = "data/reports/qualimap/{bam}_stats"
    shell:
        """qualimap bamqc -bam {input} --java-mem-size=4G -outdir {params.dir} -outformat PDF"""
