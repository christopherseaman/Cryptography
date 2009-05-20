#!/usr/bin/perl -w

use strict;
sub factorial {
	my $n = 1;
	$n *= $_ for 2..shift;
	return $n;
}


my $p = 0;
my $n = 6;
while($p < 0.975){
	$p = 0;
	for (my $x = 6; $x <= $n; $x++){
		$p = $p + ( (&factorial($n)) / ( (&factorial($x)) * (&factorial($n - $x)) )  * ((0.2)**($x)) * ((0.8)**($n - $x)));
	}
	print "N = $n\tp = $p\n";
	$n++;
}