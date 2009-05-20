#!/usr/bin/perl -w
use strict;
use bigint;


# $a^$x = $k mod $n

#my $a = 5;
#my $k = 7;
#my $n = 65537;
#5^55877 ≡ 7 mod 65537
#print (2**(2**7) + 1);

my $a = 2;
my $k = 92327518017225;
my $n = 247457076132467;
print "$a^x = $k mod $n\n";

my $a_m; # a^m

my %memo; # $memo{t} = r;  a^r = t.

my $m =sqrt($n) + 1;
my $i = 1;
for (my $j = 0; $j <= $m; $j++){
	$memo{$i} = $j;
	if ($j == $m) {$a_m = $i}
	$i = ($a * $i) % $n;
	if (($j - 10000*($j/10000)) == 0) {print "memo{$i} = $j/$m;\n";}
}

my @remainder;
my @auxiliary;
my @quotient;
$remainder[1] = $n;
$remainder[2] = $a_m;
$auxiliary[1] = 0;
$auxiliary[2] = 1;
my $j = 2;
while ($remainder[$j] > 1){
	$j = $j + 1;
	$remainder[$j] = $remainder[$j-2] % $remainder[$j-1];
	$quotient[$j] = $remainder[$j-2] / ($remainder[$j-1]);
	$auxiliary[$j] = ((-1) * $quotient[$j] * $auxiliary[$j-1]) + $auxiliary[$j-2];
	print "$remainder[$j] = $remainder[$j-2] / ($remainder[$j-1])\n";
}
my $inverse = $auxiliary[$j];

if ($inverse < 0){
	$inverse = $n + $inverse;
}

print "a^m = $a^$m = $a_m\ta^{-m} = $inverse\n";

$i = $k;
for ($j = 0; $j <= ($m - 1); $j++){
	my $temp = -1;
	if (($m - 10000*($m/10000)) == 0) {print "Step: $j of $m\n";}
	foreach my $key (keys %memo){
		if ($key == $i){
			$temp = $memo{$key};
		}
	}
	if ($temp > 0){
		print "$a ^ ($j * $m + $temp) = $a ^ ". ($j * $m + $temp) ." = $k\n";
		last;
	} else {
		$i = ($i * $inverse) %$n;
	}
}
