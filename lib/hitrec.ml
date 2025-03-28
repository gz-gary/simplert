type hit_record = {
  dist : float;
  hit_point : Vec.vec3;
  normal : Vec.vec3;
}
type hit_record_with_mat = hit_record * Material.material

let rec hitrec_closest (l : (hit_record option) list) : hit_record option =
  match l with
  | [] -> None
  | hitrec :: others ->
    match hitrec, hitrec_closest others with
    | None, None -> None
    | None, Some hitrec -> Some hitrec
    | Some hitrec, None -> Some hitrec
    | Some hitrec1, Some hitrec2 ->
      if hitrec1.dist < hitrec2.dist then Some hitrec1
      else Some hitrec2