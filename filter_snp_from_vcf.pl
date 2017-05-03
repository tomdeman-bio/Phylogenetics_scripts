#!/usr/bin/perl

#Written by Tom de Man
#Filter SNPs that passed the QC filter 

use strict;

my $vcf = shift; 
open VCF, "$vcf";

while (<VCF>) {
	chomp;
	my @s = split ('\t', $_);
	if ($_ !~ /^#/) {
		if ($s[6] eq "PASS" && $s[3] ne $s[4] && $s[4] ne "\.") {
			print $_ ."\n";
		}
	}
}
close VCF;
