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

#
#Ce test permet de vérifier si les différents backends pour les langages implémentent bien
#read int, read char et skip
#

my $len = 0;
$len = readint();
readspaces();
print($len);
print("=len\n");
$len = $len * 2;
print("len*2=");
print($len);
print("\n");
$len = int(($len) / (2));
my $tab = [];
foreach $i (0 .. $len - 1) {
  my $tmpi1 = 0;
  $tmpi1 = readint();
  readspaces();
  print($i);
  print("=>");
  print($tmpi1);
  print(" ");
  $tab->[$i] = $tmpi1;
  }
print("\n");
my $tab2 = [];
foreach $i_ (0 .. $len - 1) {
  my $tmpi2 = 0;
  $tmpi2 = readint();
  readspaces();
  print($i_);
  print("==>");
  print($tmpi2);
  print(" ");
  $tab2->[$i_] = $tmpi2;
  }
my $strlen = 0;
$strlen = readint();
readspaces();
print($strlen);
print("=strlen\n");
my $tab4 = [];
foreach $toto (0 .. $strlen - 1) {
  my $tmpc = '_';
  $tmpc = readchar();
  my $c = ord($tmpc);
  print($tmpc);
  print(":");
  print($c);
  print(" ");
  if ($tmpc ne ' ') {
  $c = remainder(($c - ord('a')) + 13, 26) + ord('a');
  }else{
  
  }
  $tab4->[$toto] = chr($c);
  }
foreach $j (0 .. $strlen - 1) {
  print($tab4->[$j]);
  }


