#! /usr/bin/perl

# Written by Tom de Man
# Using vcftools output from --TajimaD, mean TajimaD calculation from 5000 bp bins. Also calculates the STDDEV of all non '-nan' TajimaD values

use strict;
use warnings;
use Statistics::Basic qw(:all);

my $td = shift;
my $sum_td = 0;
my $line = 0;
my $line_all = 0;
my @elements;

open TD, "$td" || die "cannot open $td for reading";

while (<TD>) {
	chomp;
	my @split_header = split (" ", $_);
	if ($split_header[0] !~ /CHROM/) {
		$line_all += 1;
		if ($split_header[5] !~ /-nan/) {
			$line += 1;
			push @elements, $split_header[5];
		}
	}
}

my $stddev = stddev(@elements);
my $mean = mean(@elements);

my $nan = $line_all - $line;
printf("%-25s %.7f\n", "mean TajimaD:", $mean);
print "---------------\n";
printf("%-25s %.7f\n", "stddev TajimaD:", $stddev);
print "---------------\n";
print "NaN lines not included in mean TajimaD calculation: $nan \n";		