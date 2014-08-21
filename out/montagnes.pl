#!/usr/bin/perl

sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readchar{
    if (!defined $currentchar){ nextchar() ; }
    my $o = $currentchar; nextchar(); return $o; }
sub readint {
    if (!defined $currentchar){ nextchar(); }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') { $sign = -1; nextchar(); }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}

sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a - int($a / $b) * $b;
}

sub montagnes_{
  my($tab,
  $len) = @_;
  my $max_ = 1;
  my $j = 1;
  my $i = $len - 2;
  while ($i >= 0)
  {
    my $x = $tab->[$i];
    while ($j >= 0 && $x > $tab->[$len - $j])
    {
      $j = $j - 1;
    }
    $j = $j + 1;
    $tab->[$len - $j] = $x;
    if ($j > $max_) {
    $max_ = $j;
    }else{
    
    }
    $i = $i - 1;
  }
  return $max_;
}

my $len = 0;
$len = readint();
readspaces();
my $tab = [];
foreach $i (0 .. $len - 1) {
  my $x = 0;
  $x = readint();
  readspaces();
  $tab->[$i] = $x;
  }
print(montagnes_($tab, $len));


