program tuple;

type
    tuple_int_int=^tuple_int_int_r;
    tuple_int_int_r = record
      tuple_int_int_field_0 : Longint;
      tuple_int_int_field_1 : Longint;
    end;

function f(tuple_ : tuple_int_int) : tuple_int_int;
var
  a : Longint;
  b : Longint;
  c : tuple_int_int;
  e : tuple_int_int;
begin
  c := tuple_;
  a := c^.tuple_int_int_field_0;
  b := c^.tuple_int_int_field_1;
  new(e);
  e^.tuple_int_int_field_0 := a
  +
  1;
  e^.tuple_int_int_field_1 := b
  +
  1;
  exit(e);
end;


var
  d : tuple_int_int;
  g : tuple_int_int;
  t : tuple_int_int;
begin
  new(g);
  g^.tuple_int_int_field_0 := 0;
  g^.tuple_int_int_field_1 := 1;
  t := f(g);
  d := t;
  Write(d^.tuple_int_int_field_0);
  Write(' -- ');
  Write(d^.tuple_int_int_field_1);
  Write('--'#10'');
end.


