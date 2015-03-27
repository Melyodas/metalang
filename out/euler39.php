<?php
$t = array();
for ($i = 0 ; $i < 1001; $i++)
  $t[$i] = 0;
for ($a = 1 ; $a <= 1000; $a++)
  for ($b = 1 ; $b <= 1000; $b++)
  {
    $c2 = $a * $a + $b * $b;
    $c = intval(sqrt($c2));
    if ($c * $c == $c2)
    {
      $p = $a + $b + $c;
      if ($p <= 1000)
        $t[$p] = $t[$p] + 1;
    }
}
$j = 0;
for ($k = 1 ; $k <= 1000; $k++)
  if ($t[$k] > $t[$j])
  $j = $k;
echo $j;
?>