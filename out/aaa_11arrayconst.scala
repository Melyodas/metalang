object aaa_11arrayconst
{
  
  def test(tab : Array[Int], len : Int){
    for (i <- 0 to len - 1)
        printf("%d ", tab(i));
    printf("\n");
  }
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](5);
    for (i <- 0 to 4)
        t(i) = 1;
    test(t, 5);
  }
  
}

