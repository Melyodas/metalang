type intlist = {mutable head : int; mutable tail : intlist;}
let cons list i =
  let out_ = {head=i;
  tail=list} in
  out_
let rec rev2 empty acc torev =
  let d () = () in
  (if (torev = empty)
   then acc
   else let acc2 = {head=torev.head;
   tail=acc} in
   (rev2 empty acc torev.tail))
let rev empty torev =
  (rev2 empty empty torev)
let test empty =
  let list = empty in
  let i = (- 1) in
  let rec b i list =
    (if (i <> 0)
     then Scanf.scanf "%d"
     (fun  c -> let i = c in
     let list = (if (i <> 0)
                 then let list = (cons list i) in
                 list
                 else list) in
     (b i list))
     else ()) in
    (b i list)
let main =
  ()
