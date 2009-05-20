#!/usr/bin/perl -w

use strict;

my $frequencies = "frequencies.txt";
my $ciphertext = "cipher.txt";

my %index;
my @revdex;
my @freq;
my $i = 0;
my $max_length = 22;
my @count;		# $count[key length][position in key][letter index number]
my @total;		# $total[key length][position]
my @inf_norm;	# $inf_norm[key length][position]
my @map;		# $map[key length][position]

open (FREQ, "<$frequencies");
while (<FREQ>){
	chomp;
	my @line = split(/\t/,$_);
	$index{$line[0]} = $i;
	$revdex[$i] = $line[0];
	$freq[$i] = $line[1];
	$i++;
	#print "index{$line[0]} = $i\trevdex[$i] = $line[0]\tfreq[$i] = $line[1]\n";
}
close (FREQ);

open (CIPHER, "<$ciphertext");
while(<CIPHER>){
	chomp;
	my @line = split(//, $_);#didn't like autosplitting the chars, so i padded spaces between in the ciphertext
	for (my $key_length = 3; $key_length < $max_length; $key_length++){
		for ($i = 0; $i <= $#line; $i++){
			#print "count[$key_length][$i % $key_length][index{$line[$i]}]++;\n";
			$count[$key_length][$i % $key_length][$index{$line[$i]}]++;
			$total[$key_length][$i % $key_length]++;
		}
	}
}
close (CIPHER);


for (my $key_length = 3; $key_length < $max_length; $key_length++){
	print "$key_length:\t";
	my $overall_norm = 0;
	for (my $position = 0; $position < $key_length; $position++){
		$inf_norm[$key_length][$position] = 999999999;
		for ($i = 0; $i <= $#revdex; $i++){ #one map for each member of alphabet
			my $norm = 0;
			for(my $j = 0; $j <= ($#revdex); $j++){
				my $new_letter = ($i + $j) % ($#revdex + 1);
				unless (defined $count[$key_length][$position][$new_letter]){
					$count[$key_length][$position][$new_letter] = 0;
				}
				my $new_part = $freq[$j] - ($count[$key_length][$position][$new_letter]/$total[$key_length][$position]);
				$norm = $norm + $new_part * $new_part;
			}
			if ($norm < $inf_norm[$key_length][$position]){
				$inf_norm[$key_length][$position] = $norm;
				$map[$key_length][$position] = $revdex[$i];
			}
		}
		$overall_norm = $overall_norm + $inf_norm[$key_length][$position];
	}
	$overall_norm = sqrt($overall_norm)/$key_length;
	print "$overall_norm\t";
	for (my $position = 0; $position < $key_length; $position++){
		print "$map[$key_length][$position]";
	}
	print "\n";
}




