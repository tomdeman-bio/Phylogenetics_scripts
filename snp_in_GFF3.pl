#!/usr/bin/perl

#Written by Tom de Man

use strict;

#FST outliers.txt file
my $input = $ARGV[0];
#GFF3 file
my $gff = $ARGV[1];

my $scaffold;
my $snp;
my %intron_checker;
my $new_line = 0;

open FILE, "$input";
open OUT, ">snp_in_gene.txt";

while (<FILE>) {
	chomp;
	my @split_list = split('\t', $_);
	$scaffold = $split_list[0];
	#remove all whitespace
	$scaffold =~ s/^\s+|\s+$//g;
	$snp = $split_list[1];
	#remove all whitespace
	$snp =~ s/^\s+|\s+$//g;
	
	print "working on SNP: $snp \n"; 
	open GFF, "$gff";
	readline(GFF);
	while (<GFF>) {
		chomp;
		my @split_list2 = split('\t', $_);
		if ($scaffold eq $split_list2[0] && $split_list2[2] eq 'gene') {
        	if ($snp >= $split_list2[3] && $snp <= $split_list2[4]) {
        		print OUT "$scaffold\t$snp\t$split_list2[8]\t";
        		$intron_checker{$snp} = 1;
        		$new_line = 1;
        	}
        } elsif ($new_line == 1 && $split_list2[2] eq 'gene') {
        	print OUT "\n";
        	$new_line = 0;
        }

		if ($scaffold eq $split_list2[0] && $split_list2[2] eq 'exon' && (exists $intron_checker{$snp})) {
        	if ($snp >= $split_list2[3] && $snp <= $split_list2[4]) {
        		print OUT "EXON\n";
        		$new_line = 0;
        		
        	}
        }
	}
	close GFF;
}
close FILE;
close OUT;