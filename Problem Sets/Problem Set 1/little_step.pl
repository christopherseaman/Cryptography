#!/usr/bin/perl -w
use strict;
use POSIX qw(ceil);

my %memo;

my $m = ceil(sqrt(65537));
my $inverse = 26215;
my $a_m;  # 5 ^ (-m)
my $i = 1;

for (my $j = 0; $j <= $m; $j++){
	$memo{$i} = $j;
#	print "memo{$i} = $j\n";
	$i = (5*$i) % 65537;
}

$i = 1;
for (my $j = 1; $j <= $m; $j++){
	$i = ($i * $inverse) % 65537;
}

$a_m = $i;
$i = 7;

for (my $j = 0; $j <= ($m - 1); $j++){
	my $temp = -1;
	foreach my $key (keys %memo){
		if ($key == $i){
			$temp = $memo{$key};
		}
	}
	if ($temp > 0){
		print "5 ^ ($j * $m + $temp)\n";
		last;
	} else {
		$i = ($i * $a_m) % 65537;
	}
}
