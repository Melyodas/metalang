
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure euler21 is
type b is Array (Integer range <>) of Integer;
type b_PTR is access b;
function eratostene(t : in b_PTR; max0 : in Integer) return Integer is
  n : Integer;
  j : Integer;
begin
  n := (0);
  for i in integer range (2)..max0 - (1) loop
    if t(i) = i
    then
      n := n + (1);
      j := i * i;
      while j < max0 and then j > (0) loop
        t(j) := (0);
        j := j + i;
      end loop;
    end if;
  end loop;
  return n;
end;

function fillPrimesFactors(t : in b_PTR; c : in Integer; primes : in b_PTR;
nprimes : in Integer) return Integer is
  n : Integer;
  d : Integer;
begin
  n := c;
  for i in integer range (0)..nprimes - (1) loop
    d := primes(i);
    while (n rem d) = (0) loop
      t(d) := t(d) + (1);
      n := n / d;
    end loop;
    if n = (1)
    then
      return primes(i);
    end if;
  end loop;
  return n;
end;

function sumdivaux2(t : in b_PTR; n : in Integer;
e : in Integer) return Integer is
  i : Integer;
begin
  i := e;
  while i < n and then t(i) = (0) loop
    i := i + (1);
  end loop;
  return i;
end;

function sumdivaux(t : in b_PTR; n : in Integer;
i : in Integer) return Integer is
  p : Integer;
  out0 : Integer;
  o : Integer;
begin
  if i > n
  then
    return (1);
  else
    if t(i) = (0)
    then
      return sumdivaux(t, n, sumdivaux2(t, n, i + (1)));
    else
      o := sumdivaux(t, n, sumdivaux2(t, n, i + (1)));
      out0 := (0);
      p := i;
      for j in integer range (1)..t(i) loop
        out0 := out0 + p;
        p := p * i;
      end loop;
      return (out0 + (1)) * o;
    end if;
  end if;
end;

function sumdiv(nprimes : in Integer; primes : in b_PTR;
n : in Integer) return Integer is
  t : b_PTR;
  max0 : Integer;
begin
  t := new b (0..n + (1));
  for i in integer range (0)..n + (1) - (1) loop
    t(i) := (0);
  end loop;
  max0 := fillPrimesFactors(t, n, primes, nprimes);
  return sumdivaux(t, max0, (0));
end;


  sum : Integer;
  primes : b_PTR;
  othersum : Integer;
  other : Integer;
  nprimes : Integer;
  maximumprimes : Integer;
  l : Integer;
  era : b_PTR;
begin
  maximumprimes := (1001);
  era := new b (0..maximumprimes);
  for j in integer range (0)..maximumprimes - (1) loop
    era(j) := j;
  end loop;
  nprimes := eratostene(era, maximumprimes);
  primes := new b (0..nprimes);
  for o in integer range (0)..nprimes - (1) loop
    primes(o) := (0);
  end loop;
  l := (0);
  for k in integer range (2)..maximumprimes - (1) loop
    if era(k) = k
    then
      primes(l) := k;
      l := l + (1);
    end if;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(l), Left));
  String'Write (Text_Streams.Stream (Current_Output), " == ");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(nprimes), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  sum := (0);
  for n in integer range (2)..(1000) loop
    other := sumdiv(nprimes, primes, n) - n;
    if other > n
    then
      othersum := sumdiv(nprimes, primes, other) - other;
      if othersum = n
      then
        String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(other), Left));
        String'Write (Text_Streams.Stream (Current_Output), " & ");
        String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(n), Left));
        String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
        sum := sum + other + n;
      end if;
    end if;
  end loop;
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(sum), Left));
  String'Write (Text_Streams.Stream (Current_Output), "" & Character'Val(10) & "");
end;
