#! /usr/bin/perl

# Written by Tom de Man
# Using vcftools output from --window-pi-step. Mean and stdev Pi calculation from 5000 bp bins 
# all '-nan' pi values are omitted

use strict;
use warnings;
use Statistics::Basic qw(:all);

my $pi = shift;
my $sum_pi = 0;
my $line = 0;
my $line_all = 0;
my @elements;

open PI, "$pi" || die "cannot open $pi for reading";

while (<PI>) {
	chomp;
	my @split_header = split (" ", $_);
	if ($split_header[0] !~ /CHROM/) {
		$line_all += 1;
		if ($split_header[4] !~ /-nan/) {
			$line += 1;
			push @elements, $split_header[4];
		}
	}
}

my $stddev = stddev(@elements);
my $mean = mean(@elements);

my $nan = $line_all - $line;
printf("%-25s %.7f\n", "mean Pi nucleotide diversity:", $mean);
print "---------------\n";
printf("%-25s %.7f\n", "stddev Pi nucleotide diversity:", $stddev);
print "---------------\n";
print "NaN lines not included in mean Pi calculation: $nan \n";		 
