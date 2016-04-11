# Phylogenetics_scripts

## Check if a SNP falls within a protein coding gene. SNPs with high FST values, as determined by for instance BayeScan (http://cmpg.unibe.ch/software/BayeScan/), could be used as input.

Usage: perl **snp_in_GFF3.pl** \<snps.txt\> \<annotation.gff3\>

**snps.txt** contains two columns; scaffold/contig name and snp position

**annotation.gff3** must be in GFF3 format, without introns specifically listed
