#!/usr/bin/perl -w
use strict;
use Math::BigFloat;


my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my @weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
my ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
my $year = 1900 + $yearOffset;
my $theTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";
print "$theTime\n";


# $a^$x = $k mod $n

my $a = Math::BigFloat->new(5);
my $k = Math::BigFloat->new(7);
my $n = Math::BigFloat->new(65537);

#my $a = Math::BigFloat->new(2);
#my $k = Math::BigFloat->new(92327518017225);
#my $n = Math::BigFloat->new(247457076132467);
print "$a^x = $k mod $n\n";

my $a_m; # a^m

my %memo; # $memo{t} = r;  a^r = t.

my $m = ($n->bsqrt())->bceil();
my $i = Math::BigFloat->new(1);
for (my $j = Math::BigFloat->new(0); $j <= $m; $j++){
	$memo{$i} = $j;
	if ($j == $m) {$a_m = $i}
	$i = ($a->bmul($i))->bmod($n);
}

my @remainder;
my @auxiliary;
my @quotient;
$remainder[1] = Math::BigFloat->new($n);
$remainder[2] = Math::BigFloat->new($a_m);
$auxiliary[1] = Math::BigFloat->new(0);
$auxiliary[2] = Math::BigFloat->new(1);
my $j = Math::BigFloat->new(2);
while ($remainder[$j] > 1){
	$j = $j->badd(1);
	$remainder[$j] = $remainder[$j-2]->bmod($remainder[$j-1]);
	$quotient[$j] = ($remainder[$j-2]->bdiv($remainder[$j-1]))->bfloor();
	$auxiliary[$j] = ((-1)->bmul($quotient[$j]->bmul($auxiliary[$j-1])))->badd($auxiliary[$j-2]);
}
my $inverse = $auxiliary[$j];

if ($inverse < 0){
	$inverse = $n + $inverse;
}

print "a^m = $a_m\ta^{-m} = $inverse\n";

$i = $k;
for ($j = Math::BigFloat->new(0); $j <= ($m - 1); $j++){
	my $temp = Math::BigFloat->new(-1);
	foreach my $key (keys %memo){
		if ($key == $i){
			$temp = $memo{$key};
		}
	}
	if ($temp > 0){
		print "$a ^ ($j * $m + $temp)\n";
		last;
	} else {
		$i = ($i->bmul($a_m))->bmod($n);
	}
}





($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
$year = 1900 + $yearOffset;
$theTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";
print "$theTime\n";