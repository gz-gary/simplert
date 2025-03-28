open Vec
open Ray
open Hitrec
open Option

type panel = { base : vec3; d1 : vec3; d2 : vec3 }

let hit (r : ray) (t : panel) : hit_record option =
  let v12, v13 = t.d1, t.d2 in
  let normal = vec_normalized (vec_cross v12 v13) in
  let proj = vec_dot normal r.direction in
  if proj -. Float.epsilon > 0.0 then none (* Hit inside face instead of the outside *)
  else
    if Float.abs proj < Float.epsilon then none (* Pass by *)
    else
      let k = (vec_dot (t.base -| r.origin) normal) /. proj in
      if k +. Float.epsilon < 0.0 then none (* Hit back *)
      else 
        let hit_point = r.origin +| (k *| r.direction) in
        if (
          let goes = hit_point -| t.base in
          let dxx, dyy, dxy, dzx, dzy = vec_dot v12 v12, vec_dot v13 v13, vec_dot v12 v13, vec_dot goes v12, vec_dot goes v13 in
          let det = (dxx *. dyy -. dxy *. dxy) in
          let alpha = (dzx *. dyy -. dzy *. dxy) /. det in
          let beta = (dzy *. dxx -. dzx *. dxy) /. det in
          0.0 <= alpha && 0.0 <= beta && alpha <= 1.0 && beta <= 1.0
        ) then
          some {
            dist = k;
            hit_point = hit_point;
            normal = normal;
          }
        else none (* Hit out of the panel *)

let surface_area (p : panel) : float = 
  let normal = vec_cross p.d1 p.d2 in
  vec_len normal