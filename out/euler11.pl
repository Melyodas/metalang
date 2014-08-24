#!/usr/bin/perl
sub nextchar{ sysread STDIN, $currentchar, 1; }
sub readint {
  if (!defined $currentchar){
     nextchar();
  }
  my $o = 0;
  my $sign = 1;
  if ($currentchar eq '-') {
    $sign = -1;
    nextchar();
  }
  while ($currentchar =~ /\d/){
    $o = $o * 10 + $currentchar;
    nextchar();
  }
  return $o * $sign;
}sub readspaces {
  while ($currentchar eq ' ' || $currentchar eq "\r" || $currentchar eq "\n"){ nextchar() ; }
}

sub max2{
  my($a,
  $b) = @_;
  if ($a > $b) {
  return $a;
  }else{
  return $b;
  }
}

sub read_int_matrix{
  my($x,
  $y) = @_;
  my $tab = [];
  foreach my $z (0 .. $y - 1) {
    my $d = [];
    foreach my $e (0 .. $x - 1) {
      my $f = readint();
      readspaces();
      $d->[$e] = $f;
      }
    my $c = $d;
    $tab->[$z] = $c;
    }
  return $tab;
}

sub find{
  my($n,
  $m,
  $x,
  $y,
  $dx,
  $dy) = @_;
  if ($x < 0 || $x eq 20 || $y < 0 || $y eq 20) {
  return -1;
  }else{
  if ($n eq 0) {
  return 1;
  }else{
  return $m->[$y]->[$x] * find($n - 1, $m, $x + $dx, $y + $dy, $dx, $dy);
  }
  }
}

my $directions = [];
foreach my $i (0 .. 8 - 1) {
  if ($i eq 0) {
  $directions->[$i] = [0, 1];
  }else{
  if ($i eq 1) {
  $directions->[$i] = [1, 0];
  }else{
  if ($i eq 2) {
  $directions->[$i] = [0, -1];
  }else{
  if ($i eq 3) {
  $directions->[$i] = [-1, 0];
  }else{
  if ($i eq 4) {
  $directions->[$i] = [1, 1];
  }else{
  if ($i eq 5) {
  $directions->[$i] = [1, -1];
  }else{
  if ($i eq 6) {
  $directions->[$i] = [-1, 1];
  }else{
  $directions->[$i] = [-1, -1];
  }
  }
  }
  }
  }
  }
  }
  }
my $max_ = 0;
my $m = read_int_matrix(20, 20);
foreach my $j (0 .. 7) {
  my ($dx, $dy) = @{ $directions->[$j] };
  foreach my $x (0 .. 19) {
    foreach my $y (0 .. 19) {
      $max_ = max2($max_, find(4, $m, $x, $y, $dx, $dy));
      }
    }
  }
print($max_, "\n");


