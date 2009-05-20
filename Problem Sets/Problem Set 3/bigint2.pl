#!/usr/bin/perl
use Math::BigInt lib=>'GMP';
use Math::BigInt::GMP;
#use POSIX qw(floor);

my $start = time();
# $a^$x = $k mod $n

#my $a = Math::BigInt->new(5);
#my $k = Math::BigInt->new(7);
#my $n = Math::BigInt->new(65537);
#5^55877 ≡ 7 mod 65537
#print (2**(2**7) + 1);



my $a = Math::BigInt->new(2);
my $k = Math::BigInt->new(92327518017225);
my $n = Math::BigInt->new(247457076132467);


my $m = int (sqrt($n) + 1);
my $f7 = Math::BigInt->new(2)**(2**7)+1;
my $a_m; # a^m
my $i = Math::BigInt->new(1);
print "$a^x = $k mod $n\nsqrt($n) + 1 = $m\n2^2^7 + 1 = $f7\n";

my %memo; # $memo{t} = r;  a^r = t.
for (my $j = 0; $j <= $m; $j++){
	$memo{$i} = $j;# print "memo{$i} = $memo{$i}\n";
	if (($j / 100000) == int($j / 100000)) {print "Baby Step: $j / $m\tTime:". (time() - $start) ."\n";}
	if ($j == $m) {$a_m = $i}
	$i = $a * $i % $n;
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
	#print "$remainder[$j] = $remainder[$j-2] / $remainder[$j-1]\n";
}
my $inverse = $auxiliary[$j];

if ($inverse < 0){
	$inverse = $n + $inverse;
}

print "a^m = $a^$m = $a_m\ta^{-m} = $inverse\n";

$i = $k;
my $temp = Math::BigInt->new(0);
for ($j = 0; $j <= ($m - 1); $j++){
#	print "Step: $j\t\t$memo{$i}\n";
	if (($j / 100000) == int ($j / 100000)) { print "Giant Step: $j of $m\tTime:". (time() - $start) ."\n"; }
	if (exists $memo{$i}) {$temp = $memo{$i};}
	if ($temp > 0){
		print "$a ^ ($j * $m + $temp) = $a ^ ". ($j * $m + $temp) ." = $k\n";
		last;
	} else {
		$i = ($i->bmul($inverse))->bmod($n);
	}
}
