
let () =
 let _maximum = 1 in
  let b0 = ref( 2 ) in
  let a = ref( 408464633 ) in
  let sqrtia = ref( ((int_of_float (sqrt (float_of_int ( (!a)))))) ) in
  while (!a) <> 1 do
    let b = ref( (!b0) ) in
    let found = ref( false ) in
    while (!b) <= (!sqrtia) do
      if (!a) mod (!b) = 0 then
        begin
           a := (!a) / (!b);
           b0 := (!b);
           b := (!a);
           sqrtia := ((int_of_float (sqrt (float_of_int ( (!a))))));
           found := true
        end;
      b := (!b) + 1
    done;
    if not (!found) then
      begin
         Printf.printf "%d\n" (!a);
         a := 1
      end
  done 
 