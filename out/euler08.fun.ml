module Array = struct
  include Array
  let init_withenv len f env =
    let refenv = ref env in
    Array.init len (fun i ->
      let env, out = f i !refenv in
      refenv := env;
      out
    )
end

let max2 a b =
  (max a b)
let main =
  let i = 1 in
  let g = 5 in
  let last = (Array.init_withenv g (fun  j i -> Scanf.scanf "%c"
  (fun  c -> let d = ((int_of_char (c)) - (int_of_char ('0'))) in
  let i = (i * d) in
  let h = d in
  (i, h))) i) in
  let max_ = i in
  let index = 0 in
  let nskipdiv = 0 in
  let m = 1 in
  let n = 995 in
  let rec l k i index max_ nskipdiv =
    (if (k <= n)
     then Scanf.scanf "%c"
     (fun  e -> let f = ((int_of_char (e)) - (int_of_char ('0'))) in
     ((fun  (i, nskipdiv) -> (
                               last.(index) <- f;
                               let index = ((index + 1) mod 5) in
                               let max_ = (max2 max_ i) in
                               (l (k + 1) i index max_ nskipdiv)
                               )
     ) (if (f = 0)
        then let i = 1 in
        let nskipdiv = 4 in
        (i, nskipdiv)
        else let i = (i * f) in
        let i = (if (nskipdiv < 0)
                 then let i = (i / last.(index)) in
                 i
                 else i) in
        let nskipdiv = (nskipdiv - 1) in
        (i, nskipdiv))))
     else (
            (Printf.printf "%d\n" max_)
            )
     ) in
    (l m i index max_ nskipdiv)

