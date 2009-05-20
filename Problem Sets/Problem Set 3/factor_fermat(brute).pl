#!/usr/bin/perl -w
use strict;
use bigint;

my $x = Math::BigInt->new(2**(2**6) + 1);
my $i;
my $m = (sqrt($x));

for ($i = Math::BigInt->new(2); $i < $m; $i++){
	my $test = $x - $i * ($x/$i); #implicit flooring in ($x/$i)

	print "$x - $i * " . ($x/$i) . " = $test\n";
	
	if ($test == 0){
		last;
	}
}

print "$i * " . ($x/$i) . " = $x\n";