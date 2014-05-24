<?php
function periode(&$restes, $len, $a, $b){
  while ($a != 0)
  {
    $chiffre = intval($a / $b);
    $reste = $a % $b;
    for ($i = 0 ; $i < $len; $i++)
      if ($restes[$i] == $reste)
      return $len - $i;
    $restes[$len] = $reste;
    $len ++;
    $a = $reste * 10;
  }
  return 0;
}

$c = 1000;
$t = array();
for ($j = 0 ; $j < $c; $j++)
  $t[$j] = 0;
$m = 0;
$mi = 0;
for ($i = 1 ; $i <= 1000; $i++)
{
  $p = periode($t, 0, 1, $i);
  if ($p > $m)
  {
    $mi = $i;
    $m = $p;
  }
}
echo $mi, "\n", $m, "\n";
?>