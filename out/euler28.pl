#!/usr/bin/perl

#
#
#43 44 45 46 47 48 49
#42 21 22 23 24 25 26
#41 20  7  8  9 10 27
#40 19  6  1  2 11 28
#39 18  5  4  3 12 29
#38 17 16 15 14 13 30
#37 36 35 34 33 32 31
#
#1 3 5 7 9 13 17 21 25 31 37 43 49
#  2 2 2 2 4  4  4  4  6   6  6  6
#
#
#

sub sumdiag{
  my($n) = @_;
  my $nterms = $n * 2 - 1;
  my $un = 1;
  my $sum = 1;
  foreach my $i (0 .. $nterms - 2) {
    my $d = 2 * (1 + int(($i) / (4)));
    $un = $un + $d;
    # print int d print "=>" print un print " " 
    
    $sum = $sum + $un;
  }
  return $sum;
}

print sumdiag(1001);


