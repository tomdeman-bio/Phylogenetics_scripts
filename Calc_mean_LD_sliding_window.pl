#! /usr/bin/perl

# Written by Tom de Man
# Calculates mean LD score for regions of 1000 bp and moves with 500 bp sliding window

use strict; 

if (scalar(@ARGV)==0){
	print "Usage: perl $0 <Plink output file> <scaffold length> \n";
	exit;
}

my $plink_file = shift;
my $len = shift;
my $snp = 0;
my $start = 0;
my $region = 1000;
my $bp_increment = 500;
my $add = 0;
my $mean = 0;

for (my $i=0; $i <= $len; $i += 500) {
	open FILE, "$plink_file";
	while (<FILE>) {
		chomp;
		my @split = split(' ', $_);
		if ($_ =~ /^CHR_A*/) {
			next;
		} elsif ($split[4] >= $start && $split[4] <= $region) {
				$snp += 1;
				$add += $split[-1];
		} elsif ($split[4] > $region) {
				$mean = $add / $snp;
				print "$start .. $region bp" . "\t $mean \n";
				$region += $bp_increment;
				$start += $bp_increment;
				$snp = 0;
				$add = 0;
				last; 
			}
	}
	close FILE; 
}			