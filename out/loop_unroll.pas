program loop_unroll;

{
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
}

var
  j : integer;
begin
  j := 0;
  j := 0;
  write(j);
  write(''#10'');
  j := 1;
  write(j);
  write(''#10'');
  j := 2;
  write(j);
  write(''#10'');
  j := 3;
  write(j);
  write(''#10'');
  j := 4;
  write(j);
  write(''#10'');
end.


