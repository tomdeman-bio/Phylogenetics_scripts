# Phylogenetics_scripts

## Check if a SNP falls within a protein coding gene. SNPs with high FST values determined by [BayeScan](http://cmpg.unibe.ch/software/BayeScan/) can be used as input.

### Usage 
    perl snp_in_GFF3.pl <snps.txt> <annotation.gff3>

**snps.txt** contains two columns; scaffold/contig name and snp position

**annotation.gff3** must be in GFF3 format, without introns specifically listed

Output: contains three columns; scaffold/contig name, snp position, and gene identifier.
**A fourth column is created when SNP is in an exon or when the SNP falls in two separate genes (e.g. overlapping genes). When        fourth column is absent, SNP lays in an intron**


## Check if a genomic range falls within a protein coding gene using [bedmap](https://bedops.readthedocs.io/en/latest/content/reference/statistics/bedmap.html). A range with high FST, small pi or negative Tajima's D can be used as input. 

### Usage
    bedmap --skip-unmapped --echo --echo-map-id --delim '\t' negative_tajimasD_range.bed Genes.bed > genes.txt
    
    sed y/\;/$"\n"/ genes.txt | sort | uniq > genes_uniq.txt

## Calculate average LD scores for SNPs in 1000 bp regions and move with a 500 bp sliding window using [Plink](http://pngu.mgh.harvard.edu/~purcell/plink/) output. 

### Usage 
    perl Calc_mean_LD_sliding_window.pl <Plink output file> <scaffold length>
    
    
## Estimate how many nucleotide positions of a given mapping reference are covered by at least 5 reads (needs sorted BAM files as input) using [Bedtools genomecov](http://bedtools.readthedocs.io/en/latest/content/tools/genomecov.html)

```bash
for i in `ls example/location/bam-files/*.sorted.bam`; 
do
    echo "working on:" $i
    bedtools genomecov -ibam $i -bga -g mapping_reference_length.file > $i.len.txt
done

for i in `ls example/location/bam-files/*.txt`; do perl calc_covered_bp_genomecov.pl $i > "$i".overview; done

```


## Filter SNPs that passed your filter settings

```bash
for i in `ls example/location/vcf-files/*.vcf`; do echo "$i";  perl filter_snp_from_vcf.pl $i > "$i".snpcount; done

```
