Scripts:
vcf_conversion_annotated.sh = first attempt of conversion of single BAM file to VCF file(contains notes)
	single file: AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam
	first run: job_id: 31567351 FAIL exit code: 1 
vcf_conversion_test.sh = second attempt of conversion of single BAM file to VCF file
	single file: AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam
	changes from test1: substituted in ~, removed \, no space between -- and annotate
	first run: job_id: 31568083 FAIL exit code: 1 
	changes from first run: changed pathway for -D,-e and -o
	second run: job _id: 31568864 FAIL exit code: 255
		could not open reference genome
                could not read input file: unknown file type 
	changes from second run: full pathway for all files
	third run: job_id: 31572040  FAIL exit code: 255
		could not index reference file compressed w/ gzip, use bgzip
		could not read input file: unknown file type
	changes from third run: ref_genome_prep and prep2 were created, and removed .gz in ref name
	fourth run: 31809469 FAIL exit code: 255
		Could not parse tag "" in "FORMAT/AD,"
		Failed to read from standard input: unknown file type
	changes: moved placement of --annotate
	fifth fun: 31810983 FAILED exit code:255
		Could not parse tag "" in "FORMAT/AD,"
		Failed to read from standard input: unknown file type
	changes: put "" around FORMATjvfn
	sixth run: 31850727 FAILED exit code: 255 
		Could not parse tag " FORMAT/DP" in "FORMAT/AD, FORMAT/DP"
		Failed to read from standard input: unknown file type
	changes: removed space between FORMAT/AD, and FORMAT/DP
	seventh run: 31850809 COMPLETED exit code: 0 
vcf_conversion_ALL.sh = converts all BAM files to vcf
	first run: 31993514 CANCELLED
		rand for too long, decided to run as snakemake workflow instead 
ref_genome_prep.sh = creates index file and dictionary file for Tripsacum reference genome and compresses reference file 
		for use in snp_calling_test2
	first run: job_id: 31784747 FAIL exit code: 3 
		could not open reference file for gunzip or faidx
		did create dictionary file
	***gunzip successfully unzipped file which explains why gunzip did not work, and why samtools could not find file (it's name changed)
ref_genome_prep2.sh = just creates index (after file was unzipped and dictionary was created)
	first run: 31809137 COMPLETED exit code:0
bam_qualimap_test.sh = qualimap analysis for single BAM file
	file: AN20TSCR000001_CKDL200167244-1a-D701-AK1680_HMHFTDSXY_L4_srt_dedup.bam
	first run: 31895528 FAIl exit code: 127
		WARNING: qualimap/2.1.1 cannot be loaded due to missing prereq.
		HINT: the following module must be loaded first: R
	changes: module load R 
	second run: 31895636 COMPLETED exit code: 0
		files created named: report.pdf and genome_results.txt --> need to figure out way to create unique name for each file (basename?)
bam_qualimap_ALL.sh = qualimap analysis for all BAM files 
	first run: 31945510  
	
