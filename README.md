# Phylogenetics_scripts

## Check if a SNP falls within a protein coding gene. SNPs with high FST values, determined by for instance [BayeScan](http://cmpg.unibe.ch/software/BayeScan/), could be used as input.

### Usage 
    perl snp_in_GFF3.pl <snps.txt> <annotation.gff3>

**snps.txt** contains two columns; scaffold/contig name and snp position

**annotation.gff3** must be in GFF3 format, without introns specifically listed

Output: contains three columns; scaffold/contig name, snp position, and gene identifier.
**A fourth column is created when SNP is in an exon or when the SNP falls in two separate genes (e.g. overlapping genes). When        fourth column is absent, SNP lays in an intron**


## Calculate average LD scores for SNPs in 1000 bp regions and move with a 500 bp sliding window using [Plink](http://pngu.mgh.harvard.edu/~purcell/plink/) output. 

### Usage 
    perl Calc_mean_LD_sliding_window.pl <Plink output file> <scaffold length>
