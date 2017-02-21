object sudoku
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}
  
  //  lit un sudoku sur l'entrée standard 
  def read_sudoku(): Array[Int] = {
    var out0 :Array[Int] = new Array[Int](9 * 9);
    for (i <- 0 to 9 * 9 - 1)
    {
        var k = read_int();
        skip();
        out0(i) = k;
    }
    return out0;
  }
  
  //  affiche un sudoku 
  def print_sudoku(sudoku0 : Array[Int]){
    for (y <- 0 to 8)
    {
        for (x <- 0 to 8)
        {
            printf("%d ", sudoku0(x + y * 9));
            if (x % 3 == 2)
                printf(" ");
        }
        printf("\n");
        if (y % 3 == 2)
            printf("\n");
    }
    printf("\n");
  }
  
  //  dit si les variables sont toutes différentes 
  //  dit si les variables sont toutes différentes 
  //  dit si le sudoku est terminé de remplir 
  def sudoku_done(s : Array[Int]): Boolean = {
    for (i <- 0 to 80)
        if (s(i) == 0)
            return false;
    return true;
  }
  
  //  dit si il y a une erreur dans le sudoku 
  def sudoku_error(s : Array[Int]): Boolean = {
    var out1: Boolean = false;
    for (x <- 0 to 8)
        out1 = out1 || s(x) != 0 && s(x) == s(x + 9) || s(x) != 0 && s(x) == s(x + 9 * 2) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 2) || s(x) != 0 && s(x) == s(x + 9 * 3) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 3) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 3) || s(x) != 0 && s(x) == s(x + 9 * 4) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 4) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 4) || s(x + 9 * 3) != 0 && s(x + 9 * 3) == s(x + 9 * 4) || s(x) != 0 && s(x) == s(x + 9 * 5) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 5) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 5) || s(x + 9 * 3) != 0 && s(x + 9 * 3) == s(x + 9 * 5) || s(x + 9 * 4) != 0 && s(x + 9 * 4) == s(x + 9 * 5) || s(x) != 0 && s(x) == s(x + 9 * 6) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 6) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 6) || s(x + 9 * 3) != 0 && s(x + 9 * 3) == s(x + 9 * 6) || s(x + 9 * 4) != 0 && s(x + 9 * 4) == s(x + 9 * 6) || s(x + 9 * 5) != 0 && s(x + 9 * 5) == s(x + 9 * 6) || s(x) != 0 && s(x) == s(x + 9 * 7) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 7) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 7) || s(x + 9 * 3) != 0 && s(x + 9 * 3) == s(x + 9 * 7) || s(x + 9 * 4) != 0 && s(x + 9 * 4) == s(x + 9 * 7) || s(x + 9 * 5) != 0 && s(x + 9 * 5) == s(x + 9 * 7) || s(x + 9 * 6) != 0 && s(x + 9 * 6) == s(x + 9 * 7) || s(x) != 0 && s(x) == s(x + 9 * 8) || s(x + 9) != 0 && s(x + 9) == s(x + 9 * 8) || s(x + 9 * 2) != 0 && s(x + 9 * 2) == s(x + 9 * 8) || s(x + 9 * 3) != 0 && s(x + 9 * 3) == s(x + 9 * 8) || s(x + 9 * 4) != 0 && s(x + 9 * 4) == s(x + 9 * 8) || s(x + 9 * 5) != 0 && s(x + 9 * 5) == s(x + 9 * 8) || s(x + 9 * 6) != 0 && s(x + 9 * 6) == s(x + 9 * 8) || s(x + 9 * 7) != 0 && s(x + 9 * 7) == s(x + 9 * 8);
    var out2: Boolean = false;
    for (x <- 0 to 8)
        out2 = out2 || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 1) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 2) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 2) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 3) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 3) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 3) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 4) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 4) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 4) || s(x * 9 + 3) != 0 && s(x * 9 + 3) == s(x * 9 + 4) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 5) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 5) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 5) || s(x * 9 + 3) != 0 && s(x * 9 + 3) == s(x * 9 + 5) || s(x * 9 + 4) != 0 && s(x * 9 + 4) == s(x * 9 + 5) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 6) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 6) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 6) || s(x * 9 + 3) != 0 && s(x * 9 + 3) == s(x * 9 + 6) || s(x * 9 + 4) != 0 && s(x * 9 + 4) == s(x * 9 + 6) || s(x * 9 + 5) != 0 && s(x * 9 + 5) == s(x * 9 + 6) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 7) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 7) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 7) || s(x * 9 + 3) != 0 && s(x * 9 + 3) == s(x * 9 + 7) || s(x * 9 + 4) != 0 && s(x * 9 + 4) == s(x * 9 + 7) || s(x * 9 + 5) != 0 && s(x * 9 + 5) == s(x * 9 + 7) || s(x * 9 + 6) != 0 && s(x * 9 + 6) == s(x * 9 + 7) || s(x * 9) != 0 && s(x * 9) == s(x * 9 + 8) || s(x * 9 + 1) != 0 && s(x * 9 + 1) == s(x * 9 + 8) || s(x * 9 + 2) != 0 && s(x * 9 + 2) == s(x * 9 + 8) || s(x * 9 + 3) != 0 && s(x * 9 + 3) == s(x * 9 + 8) || s(x * 9 + 4) != 0 && s(x * 9 + 4) == s(x * 9 + 8) || s(x * 9 + 5) != 0 && s(x * 9 + 5) == s(x * 9 + 8) || s(x * 9 + 6) != 0 && s(x * 9 + 6) == s(x * 9 + 8) || s(x * 9 + 7) != 0 && s(x * 9 + 7) == s(x * 9 + 8);
    var out3: Boolean = false;
    for (x <- 0 to 8)
        out3 = out3 || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s((x % 3) * 3 * 9 + (x / 3) * 3) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) != 0 && s((x % 3) * 3 * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) != 0 && s(((x % 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) != 0 && s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) != 0 && s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) == s(((x % 3) * 3 + 2) * 9 + (x / 3) * 3 + 2);
    return out1 || out2 || out3;
  }
  
  //  résout le sudoku
  def solve(sudoku0 : Array[Int]): Boolean = {
    if (sudoku_error(sudoku0))
        return false;
    if (sudoku_done(sudoku0))
        return true;
    for (i <- 0 to 80)
        if (sudoku0(i) == 0)
        {
            for (p <- 1 to 9)
            {
                sudoku0(i) = p;
                if (solve(sudoku0))
                    return true;
            }
            sudoku0(i) = 0;
            return false;
        }
    return false;
  }
  
  
  def main(args : Array[String])
  {
    var sudoku0: Array[Int] = read_sudoku();
    print_sudoku(sudoku0);
    if (solve(sudoku0))
        print_sudoku(sudoku0);
    else
        printf("no solution\n");
  }
  
}

