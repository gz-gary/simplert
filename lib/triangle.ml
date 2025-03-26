open Vec
open Ray
open Hitrec
open Option

type triangle = { v1 : vec3; v2 : vec3; v3 : vec3 }

let hit (r : ray) (t : triangle) : hit_record option =
  let v12, v13 = (t.v2 -| t.v1), (t.v3 -| t.v1) in
  let normal = vec_normalized (vec_cross v12 v13) in
  let proj = vec_dot normal r.direction in
  if proj -. Float.epsilon > 0.0 then none (* Hit inside face instead of the outside *)
  else
    if Float.abs proj < Float.epsilon then none (* Pass by *)
    else
      let k = (vec_dot (t.v1 -| r.origin) normal) /. proj in
      if k +. Float.epsilon < 0.0 then none (* Hit back *)
      else 
        let hit_point = r.origin +| (k *| r.direction) in
        if (
          let goes = hit_point -| t.v1 in
          let dxx, dyy, dxy, dzx, dzy = vec_dot v12 v12, vec_dot v13 v13, vec_dot v12 v13, vec_dot goes v12, vec_dot goes v13 in
          let det = (dxx *. dyy -. dxy *. dxy) in
          let alpha = (dzx *. dyy -. dzy *. dxy) /. det in
          let beta = (dzy *. dxx -. dzx *. dxy) /. det in
          0.0 <= alpha && 0.0 <= beta && alpha +. beta <= 1.0
        ) then
          some {
            dist = k;
            hit_point = hit_point;
            normal = normal;
          }
        else none (* Hit out of the triangle *)
