let rec find0 len tab cache x y =
  (* 
	Cette fonction est récursive
	 *)
  (if (y = (len - 1))
   then tab.(y).(x)
   else (if (x > y)
         then (- 10000)
         else (if (cache.(y).(x) <> 0)
               then cache.(y).(x)
               else let result = 0 in
               let out0 = (find0 len tab cache x (y + 1)) in
               let out1 = (find0 len tab cache (x + 1) (y + 1)) in
               let result = (if (out0 > out1)
                             then let result = (out0 + tab.(y).(x)) in
                             result
                             else let result = (out1 + tab.(y).(x)) in
                             result) in
               (
                 cache.(y).(x) <- result;
                 result
                 )
               )))
let find len tab =
  let tab2 = (Array.init len (fun  i -> let tab3 = (Array.init (i + 1) (fun  j -> 0)) in
  tab3)) in
  (find0 len tab tab2 0 0)
let main =
  let len = 0 in
  Scanf.scanf "%d"
  (fun  a -> let len = a in
  (
    (Scanf.scanf "%[\n \010]" (fun _ -> ()));
    let tab = (Array.init len (fun  i -> let tab2 = (Array.init (i + 1) (fun  j -> let tmp = 0 in
    Scanf.scanf "%d"
    (fun  b -> let tmp = b in
    (
      (Scanf.scanf "%[\n \010]" (fun _ -> ()));
      tmp
      )
    ))) in
    tab2)) in
    (
      (Printf.printf "%d\n" (find len tab));
      let rec c k =
        (if (k <= (len - 1))
         then let rec d l =
                (if (l <= k)
                 then (
                        (Printf.printf "%d " tab.(k).(l));
                        (d (l + 1))
                        )
                 
                 else (
                        (Printf.printf "\n");
                        (c (k + 1))
                        )
                 ) in
                (d 0)
         else ()) in
        (c 0)
      )
    
    )
  )

