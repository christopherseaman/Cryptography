#!/usr/bin/perl -w
use strict;
use bigint;

my $n = 247457076132467;#2**(2**5) + 1;
my $x = 2;my $y = 2;my $d = 1;

while ($d == 1) {
	$x = ($x*$x + 37)->bmod($n);
	$y = ($y*$y + 37)->bmod($n);
	$y = ($y*$y + 37)->bmod($n);
	$d = Math::BigInt::bgcd(($x-$y)->babs(), $n);
	print "bgcd(" . ($x-$y)->babs() . ", $n) = $d\n";
	if (($x-$y)->babs() == 0) {last;}
}

print "bgcd(" . ($x-$y)->babs() . ", $n) = $d\n";

