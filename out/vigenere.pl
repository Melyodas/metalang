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

sub position_alphabet{
  my($c) = @_;
  my $i = ord($c);
  if ($i <= ord('Z') && $i >= ord('A')) {
  return $i - ord('A');
  }else{
  if ($i <= ord('z') && $i >= ord('a')) {
  return $i - ord('a');
  }else{
  return -1;
  }
  }
}

sub of_position_alphabet{
  my($c) = @_;
  return chr($c + ord('a'));
}

sub crypte{
  my($taille_cle,
  $cle,
  $taille,
  $message) = @_;
  foreach $i (0 .. $taille - 1) {
    my $lettre = position_alphabet($message->[$i]);
    if ($lettre ne -1) {
    my $addon = position_alphabet($cle->[remainder($i, $taille_cle)]);
    my $new_ = remainder($addon + $lettre, 26);
    $message->[$i] = of_position_alphabet($new_);
    }else{
    
    }
    }
}

my $taille_cle = 0;
$taille_cle = readint();
readspaces();
my $cle = [];
foreach $index (0 .. $taille_cle - 1) {
  my $out_ = '_';
  $out_ = readchar();
  $cle->[$index] = $out_;
  }
readspaces();
my $taille = 0;
$taille = readint();
readspaces();
my $message = [];
foreach $index2 (0 .. $taille - 1) {
  my $out2 = '_';
  $out2 = readchar();
  $message->[$index2] = $out2;
  }
crypte($taille_cle, $cle, $taille, $message);
foreach $i (0 .. $taille - 1) {
  print($message->[$i]);
  }
print("\n");


