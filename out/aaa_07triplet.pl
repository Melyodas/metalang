#!/usr/bin/perl

foreach my $i (1 .. 3)
{
    my ($a, $b, $c) = @{[ map { int($_) } split(/\s+/, <STDIN>) ]};
    print("a = ", $a, " b = ", $b, "c =", $c, "\n");
}
my $l = [ map { int($_) } split(/\s+/, <STDIN>) ];
foreach my $j (0 .. 9)
{
    print($l->[$j], "\n");
}


