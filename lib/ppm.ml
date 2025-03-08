(* This is a module to manipulate .ppm files *)

let write_ppm_pix (oc : out_channel) (width : int) (height : int)
  (f : int -> int -> int * int * int) = 
  let i = ref 0 in
  while !i < height do
    let j = ref 0 in
    while !j < width do
      match f !i !j with
      | (r, g, b) ->
      Printf.fprintf oc "%d %d %d\n" r g b;
      incr j
    done;
    incr i
  done

let write_ppm (path : string) (width : int) (height : int)
    (f : int -> int -> int * int * int) =
  let oc = open_out path in 
  Printf.fprintf oc "P3\n";
  Printf.fprintf oc "%d %d\n" width height;
  Printf.fprintf oc "%d\n" 255;
  write_ppm_pix oc width height f;
  close_out oc
