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

sub exp_{
  my($a,
  $b) = @_;
  if ($b eq 0) {
  return 1;
  }else{
  
  }
  if ((remainder($b, 2)) eq 0) {
  my $o = exp_($a, int(($b) / (2)));
  return $o * $o;
  }else{
  return $a * exp_($a, $b - 1);
  }
}

my $a = 0;
my $b = 0;
$a = readint();
readspaces();
$b = readint();
print(exp_($a, $b));


