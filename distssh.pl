#!/usr/bin/perl

# 
# by Keiya Chinen

use strict;
use warnings;
use feature 'say';

use lib './lib';
use DistSSH;

my $nodeslist = "./nodes.txt";
open (my $fh, "<", $nodeslist )
     or die "[distssh.pl]ERROR: Cannot open $nodeslist: $!";
my @nodes = readline $fh;
chomp @nodes;

my $i=0;
my @ssh;
foreach my $node (@nodes) {
	say("[distssh.pl]Opening Connection: $node");
	$ssh[$i] = DistSSH->new(cmd=>'ssh -t -t '.$node.' > /dev/null 2>&1',dbg=>0);
	say("[distssh.pl]Command Executing:  $node");
	$ssh[$i]->do("ls >> $node.txt");
	$i++;
}

#my $ssh = DistSSH->new('ssh -t -t viola02.coins.tsukuba.ac.jp');
#$ssh->do("ls >> \n");

__END__
