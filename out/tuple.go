package main

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}

func f(tuple_ * tuple_int_int) * tuple_int_int{
  var c * tuple_int_int = tuple_
  var a int = (*c).tuple_int_int_field_0
  var b int = (*c).tuple_int_int_field_1
  var d * tuple_int_int = new (tuple_int_int)
  (*d).tuple_int_int_field_0=a + 1;
  (*d).tuple_int_int_field_1=b + 1;
  return d
}

func main() {
var e * tuple_int_int = new (tuple_int_int)
(*e).tuple_int_int_field_0=0;
(*e).tuple_int_int_field_1=1;
var t * tuple_int_int = f(e)
_ = t
}

