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

let rec okdigits ok n =
  let f () = () in
  (if (n = 0)
   then true
   else let digit = (n mod 10) in
   let g () = (f ()) in
   (if ok.(digit)
    then (
           ok.(digit) <- false;
           let o = (okdigits ok (n / 10)) in
           (
             ok.(digit) <- true;
             o
             )
           
           )
    
    else false))
let main =
  let count = 0 in
  let allowed = (Array.init_withenv 10 (fun  i () -> let h = (i <> 0) in
  ((), h)) ()) in
  let counted = (Array.init_withenv 100000 (fun  j () -> let k = false in
  ((), k)) ()) in
  let ba = 1 in
  let bb = 9 in
  let rec l e count =
    (if (e <= bb)
     then (
            allowed.(e) <- false;
            let y = 1 in
            let z = 9 in
            let rec m b count =
              (if (b <= z)
               then let count = (if allowed.(b)
                                 then (
                                        allowed.(b) <- false;
                                        let be = ((b * e) mod 10) in
                                        let count = (if allowed.(be)
                                                     then (
                                                            allowed.(be) <- false;
                                                            let w = 1 in
                                                            let x = 9 in
                                                            let rec p a count =
                                                              (if (a <= x)
                                                               then let count = (
                                                               if allowed.(a)
                                                               then (
                                                                    allowed.(a) <- false;
                                                                    let u = 1 in
                                                                    let v = 9 in
                                                                    let rec q c count =
                                                                    (if (c <= v)
                                                                    then let count = (
                                                                    if allowed.(c)
                                                                    then 
                                                                    (
                                                                    allowed.(c) <- false;
                                                                    let s = 1 in
                                                                    let t = 9 in
                                                                    let rec r d count =
                                                                    (if (d <= t)
                                                                    then let count = (
                                                                    if allowed.(d)
                                                                    then 
                                                                    (
                                                                    allowed.(d) <- false;
                                                                    (*  2 * 3 digits  *)
                                                                    let product = (((a * 10) + b) * (((c * 100) + (d * 10)) + e)) in
                                                                    let count = (
                                                                    if ((not counted.(product)) && (okdigits allowed (product / 10)))
                                                                    then 
                                                                    (
                                                                    counted.(product) <- true;
                                                                    let count = (count + product) in
                                                                    (
                                                                    (Printf.printf "%d " product);
                                                                    count
                                                                    )
                                                                    
                                                                    )
                                                                    
                                                                    else count) in
                                                                    (*  1  * 4 digits  *)
                                                                    let product2 = (b * ((((a * 1000) + (c * 100)) + (d * 10)) + e)) in
                                                                    let count = (
                                                                    if ((not counted.(product2)) && (okdigits allowed (product2 / 10)))
                                                                    then 
                                                                    (
                                                                    counted.(product2) <- true;
                                                                    let count = (count + product2) in
                                                                    (
                                                                    (Printf.printf "%d " product2);
                                                                    count
                                                                    )
                                                                    
                                                                    )
                                                                    
                                                                    else count) in
                                                                    (
                                                                    allowed.(d) <- true;
                                                                    count
                                                                    )
                                                                    
                                                                    )
                                                                    
                                                                    else count) in
                                                                    (r (d + 1) count)
                                                                    else 
                                                                    (
                                                                    allowed.(c) <- true;
                                                                    count
                                                                    )
                                                                    ) in
                                                                    (r s count)
                                                                    )
                                                                    
                                                                    else count) in
                                                                    (q (c + 1) count)
                                                                    else 
                                                                    (
                                                                    allowed.(a) <- true;
                                                                    count
                                                                    )
                                                                    ) in
                                                                    (q u count)
                                                                    )
                                                               
                                                               else count) in
                                                               (p (a + 1) count)
                                                               else (
                                                                    allowed.(be) <- true;
                                                                    count
                                                                    )
                                                               ) in
                                                              (p w count)
                                                            )
                                                     
                                                     else count) in
                                        (
                                          allowed.(b) <- true;
                                          count
                                          )
                                        
                                        )
                                 
                                 else count) in
               (m (b + 1) count)
               else (
                      allowed.(e) <- true;
                      (l (e + 1) count)
                      )
               ) in
              (m y count)
            )
     
     else (
            (Printf.printf "%d\n" count)
            )
     ) in
    (l ba count)
