let rec pathfind_aux cache tab len pos =
  if pos >= (len - 1) then
    0
  else if cache.(pos) <> -1 then
    cache.(pos)
  else
    begin
      cache.(pos) <- len * 2;
      let posval = pathfind_aux cache tab len tab.(pos) in
      let oneval = pathfind_aux cache tab len (pos + 1) in
      let out_ = ref( 0 ) in
      if posval < oneval then
        out_ := 1 + posval
      else
        out_ := 1 + oneval;
      cache.(pos) <- (!out_);
      (!out_)
    end

let rec pathfind tab len =
  let cache = Array.init (len) (fun i ->
    -1) in
  pathfind_aux cache tab len 0

let () =
begin
  let len = ref( 0 ) in
  Scanf.scanf "%d" (fun value -> len := value);
  Scanf.scanf "%[\n \010]" (fun _ -> ());
  let tab = Array.init ((!len)) (fun i ->
    let tmp = ref( 0 ) in
    Scanf.scanf "%d" (fun value -> tmp := value);
    Scanf.scanf "%[\n \010]" (fun _ -> ());
    (!tmp)) in
  let result = pathfind tab (!len) in
  Printf.printf "%d" result
end
 