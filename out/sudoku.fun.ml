let read_sudoku () =
  Array.init (9 * 9) (fun i -> Scanf.scanf "%d"
  (fun k -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
              k)))

let print_sudoku sudoku0 =
  let rec a y =
    if y <= 8
    then let rec b x =
           if x <= 8
           then ( Printf.printf "%d " sudoku0.(x + y * 9);
                  if x mod 3 = 2
                  then ( Printf.printf "%s" " ";
                         b (x + 1))
                  else b (x + 1))
           else ( Printf.printf "%s" "\n";
                  if y mod 3 = 2
                  then ( Printf.printf "%s" "\n";
                         a (y + 1))
                  else a (y + 1)) in
           b 0
    else Printf.printf "%s" "\n" in
    a 0

let sudoku_done s =
  let rec c i =
    if i <= 80
    then if s.(i) = 0
         then false
         else c (i + 1)
    else true in
    c 0

let sudoku_error s =
  let out1 = false in
  let rec d x out1 =
    if x <= 8
    then let out1 = out1 || s.(x) <> 0 && s.(x) = s.(x + 9) || s.(x) <> 0 && s.(x) = s.(x + 9 * 2) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 2) || s.(x) <> 0 && s.(x) = s.(x + 9 * 3) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 3) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 3) || s.(x) <> 0 && s.(x) = s.(x + 9 * 4) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 4) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 4) || s.(x + 9 * 3) <> 0 && s.(x + 9 * 3) = s.(x + 9 * 4) || s.(x) <> 0 && s.(x) = s.(x + 9 * 5) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 5) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 5) || s.(x + 9 * 3) <> 0 && s.(x + 9 * 3) = s.(x + 9 * 5) || s.(x + 9 * 4) <> 0 && s.(x + 9 * 4) = s.(x + 9 * 5) || s.(x) <> 0 && s.(x) = s.(x + 9 * 6) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 6) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 6) || s.(x + 9 * 3) <> 0 && s.(x + 9 * 3) = s.(x + 9 * 6) || s.(x + 9 * 4) <> 0 && s.(x + 9 * 4) = s.(x + 9 * 6) || s.(x + 9 * 5) <> 0 && s.(x + 9 * 5) = s.(x + 9 * 6) || s.(x) <> 0 && s.(x) = s.(x + 9 * 7) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 7) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 7) || s.(x + 9 * 3) <> 0 && s.(x + 9 * 3) = s.(x + 9 * 7) || s.(x + 9 * 4) <> 0 && s.(x + 9 * 4) = s.(x + 9 * 7) || s.(x + 9 * 5) <> 0 && s.(x + 9 * 5) = s.(x + 9 * 7) || s.(x + 9 * 6) <> 0 && s.(x + 9 * 6) = s.(x + 9 * 7) || s.(x) <> 0 && s.(x) = s.(x + 9 * 8) || s.(x + 9) <> 0 && s.(x + 9) = s.(x + 9 * 8) || s.(x + 9 * 2) <> 0 && s.(x + 9 * 2) = s.(x + 9 * 8) || s.(x + 9 * 3) <> 0 && s.(x + 9 * 3) = s.(x + 9 * 8) || s.(x + 9 * 4) <> 0 && s.(x + 9 * 4) = s.(x + 9 * 8) || s.(x + 9 * 5) <> 0 && s.(x + 9 * 5) = s.(x + 9 * 8) || s.(x + 9 * 6) <> 0 && s.(x + 9 * 6) = s.(x + 9 * 8) || s.(x + 9 * 7) <> 0 && s.(x + 9 * 7) = s.(x + 9 * 8) in
    d (x + 1) out1
    else let out2 = false in
    let rec e x out2 =
      if x <= 8
      then let out2 = out2 || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 1) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 2) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 2) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 3) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 3) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 3) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 4) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 4) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 4) || s.(x * 9 + 3) <> 0 && s.(x * 9 + 3) = s.(x * 9 + 4) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 5) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 5) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 5) || s.(x * 9 + 3) <> 0 && s.(x * 9 + 3) = s.(x * 9 + 5) || s.(x * 9 + 4) <> 0 && s.(x * 9 + 4) = s.(x * 9 + 5) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 6) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 6) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 6) || s.(x * 9 + 3) <> 0 && s.(x * 9 + 3) = s.(x * 9 + 6) || s.(x * 9 + 4) <> 0 && s.(x * 9 + 4) = s.(x * 9 + 6) || s.(x * 9 + 5) <> 0 && s.(x * 9 + 5) = s.(x * 9 + 6) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 7) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 7) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 7) || s.(x * 9 + 3) <> 0 && s.(x * 9 + 3) = s.(x * 9 + 7) || s.(x * 9 + 4) <> 0 && s.(x * 9 + 4) = s.(x * 9 + 7) || s.(x * 9 + 5) <> 0 && s.(x * 9 + 5) = s.(x * 9 + 7) || s.(x * 9 + 6) <> 0 && s.(x * 9 + 6) = s.(x * 9 + 7) || s.(x * 9) <> 0 && s.(x * 9) = s.(x * 9 + 8) || s.(x * 9 + 1) <> 0 && s.(x * 9 + 1) = s.(x * 9 + 8) || s.(x * 9 + 2) <> 0 && s.(x * 9 + 2) = s.(x * 9 + 8) || s.(x * 9 + 3) <> 0 && s.(x * 9 + 3) = s.(x * 9 + 8) || s.(x * 9 + 4) <> 0 && s.(x * 9 + 4) = s.(x * 9 + 8) || s.(x * 9 + 5) <> 0 && s.(x * 9 + 5) = s.(x * 9 + 8) || s.(x * 9 + 6) <> 0 && s.(x * 9 + 6) = s.(x * 9 + 8) || s.(x * 9 + 7) <> 0 && s.(x * 9 + 7) = s.(x * 9 + 8) in
      e (x + 1) out2
      else let out3 = false in
      let rec f x out3 =
        if x <= 8
        then let out3 = out3 || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) || s.((x mod 3) * 3 * 9 + (x / 3) * 3) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) <> 0 && s.((x mod 3) * 3 * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) <> 0 && s.(((x mod 3) * 3 + 1) * 9 + (x / 3) * 3 + 2) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) <> 0 && s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) || s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) <> 0 && s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 1) = s.(((x mod 3) * 3 + 2) * 9 + (x / 3) * 3 + 2) in
        f (x + 1) out3
        else out1 || out2 || out3 in
        f 0 out3 in
      e 0 out2 in
    d 0 out1

let rec solve sudoku0 =
  if sudoku_error sudoku0
  then false
  else if sudoku_done sudoku0
       then true
       else let rec g i =
              if i <= 80
              then if sudoku0.(i) = 0
                   then let rec h p =
                          if p <= 9
                          then ( sudoku0.(i) <- p;
                                 if solve sudoku0
                                 then true
                                 else h (p + 1))
                          else ( sudoku0.(i) <- 0;
                                 false) in
                          h 1
                   else g (i + 1)
              else false in
              g 0

let main =
  let sudoku0 = read_sudoku () in
  ( print_sudoku sudoku0;
    if solve sudoku0
    then ( print_sudoku sudoku0;
           ())
    else Printf.printf "%s" "no solution\n")

