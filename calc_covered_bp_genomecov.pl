#!/usr/bin/perl

#Written by Tom de Man

use strict;
use List::Util qw( min max );

my $genomecov = shift;
open GC, "$genomecov";

my $covered_bps = 0;
my @coverage;

while (<GC>) {
	chomp;
	my @s = split('\t', $_);
	if ($s[3] >= 5) {
		push @coverage, $s[3];
		my $covered_region = $s[2] - $s[1];
		$covered_bps += $covered_region;
	}
}
close GC;

my $min = min @coverage;
my $max = max @coverage;

print $genomecov . "\n";
print $covered_bps . " base pairs covered by reads of your input sample\n";
print $min . " minimum coverage observed\n";
print $max . " maximum coverage observed\n";
