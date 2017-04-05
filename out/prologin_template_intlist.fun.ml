let programme_candidat tableau taille =
  let out0 = 0 in
  let rec c i out0 =
    if i <= taille - 1
    then let out0 = out0 + tableau.(i) in
    c (i + 1) out0
    else out0 in
    c 0 out0

let main =
  let taille = (Scanf.scanf "%d " (fun x -> x)) in
  let tableau = Array.init taille (fun a -> Scanf.scanf "%d"
  (fun b -> ( Scanf.scanf "%[\n \010]" (fun _ -> ());
              b))) in
  Printf.printf "%d\n" (programme_candidat tableau taille)

