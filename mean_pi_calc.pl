#! /usr/bin/perl

# Written by Tom de Man
# Using vcftools output from --site-pi, mean pi calculation 

use strict;
use warnings;

my $pi = shift;
my $sum_pi = 0;
my $line = 0;
my $line_all = 0;

open PI, "$pi" || die "cannot open $pi for reading";

while (<PI>) {
	chomp;
	my @split_header = split (" ", $_);
	if ($split_header[0] !~ /CHROM/) {
		$line_all += 1;
		if ($split_header[2] !~ /-nan/) {
			#print "$split_header[0]\n";
			$line += 1;
			$sum_pi += $split_header[2];
		}
	}
}

my $mean = $sum_pi / $line;
my $nan = $line_all - $line;
print "mean PI: $mean \n";
print "---------------\n";
print "NaN lines not included in mean calculation: $nan \n";

		 