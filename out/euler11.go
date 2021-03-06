package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
func max2_(a int, b int) int{
  if a > b {
      return a
  } else {
      return b
  }
}
func find(n int, m [][]int, x int, y int, dx int, dy int) int{
  if x < 0 || x == 20 || y < 0 || y == 20 {
      return -1
  } else if n == 0 {
      return 1
  } else {
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy)
  }
}

type tuple_int_int struct {
  tuple_int_int_field_0 int;
  tuple_int_int_field_1 int;
}
func main() {
  reader = bufio.NewReader(os.Stdin)
  var directions []* tuple_int_int = make([]* tuple_int_int, 8)
  for i := 0; i < 8; i++ {
      if i == 0 {
          var c * tuple_int_int = new (tuple_int_int)
              (*c).tuple_int_int_field_0=0
              (*c).tuple_int_int_field_1=1
          directions[i] = c
      } else if i == 1 {
          var d * tuple_int_int = new (tuple_int_int)
              (*d).tuple_int_int_field_0=1
              (*d).tuple_int_int_field_1=0
          directions[i] = d
      } else if i == 2 {
          var e * tuple_int_int = new (tuple_int_int)
              (*e).tuple_int_int_field_0=0
              (*e).tuple_int_int_field_1=-1
          directions[i] = e
      } else if i == 3 {
          var f * tuple_int_int = new (tuple_int_int)
              (*f).tuple_int_int_field_0=-1
              (*f).tuple_int_int_field_1=0
          directions[i] = f
      } else if i == 4 {
          var g * tuple_int_int = new (tuple_int_int)
              (*g).tuple_int_int_field_0=1
              (*g).tuple_int_int_field_1=1
          directions[i] = g
      } else if i == 5 {
          var h * tuple_int_int = new (tuple_int_int)
              (*h).tuple_int_int_field_0=1
              (*h).tuple_int_int_field_1=-1
          directions[i] = h
      } else if i == 6 {
          var k * tuple_int_int = new (tuple_int_int)
              (*k).tuple_int_int_field_0=-1
              (*k).tuple_int_int_field_1=1
          directions[i] = k
      } else {
          var l * tuple_int_int = new (tuple_int_int)
              (*l).tuple_int_int_field_0=-1
              (*l).tuple_int_int_field_1=-1
          directions[i] = l
      }
  }
  max0 := 0
  var m [][]int = make([][]int, 20)
  for o := 0; o < 20; o++ {
      var p []int = make([]int, 20)
      for q := 0; q < 20; q++ {
          fmt.Fscanf(reader, "%d", &p[q])
          skip()
      }
      m[o] = p
  }
  for j := 0; j < 8; j++ {
      var r * tuple_int_int = directions[j]
      dx := (*r).tuple_int_int_field_0
      dy := (*r).tuple_int_int_field_1
      for x := 0; x < 20; x++ {
          for y := 0; y < 20; y++ {
              max0 = max2_(max0, find(4, m, x, y, dx, dy))
          }
      }
  }
  fmt.Printf("%d\n", max0)
}

