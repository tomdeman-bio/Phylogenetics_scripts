#! /usr/bin/perl
# Written by Tom de Man

use strict;
use warnings;
use Getopt::Long;
use Bio::TreeIO;

my $treefile;
my $tip;

GetOptions(	"tree=s" => \$treefile,
			"droptip=s" => \$tip,
);

if (($treefile) && ($tip)) {
	&droptip($treefile, $tip);
}else{
	&Usage;
}

sub droptip {
	my ($treein, $tipin) = @_;
	my $treeio = Bio::TreeIO->new(-file => $treein, -format => 'newick');
	my $tree = $treeio->next_tree;
	$tree->remove_Node($tipin);
	print $tree->as_text('newick');
}

sub Usage {
	print STDERR "\n Please provide input tree file and tip that you want to remove\n\n";
	print STDERR "\n Usage: perl $0 -tree <tree in Newick format> -droptip <isolate name> \n\n";
	exit;	
}