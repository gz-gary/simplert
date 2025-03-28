open Vec
open Ray
open Hitrec
open Option

type sphere = { center : vec3; radius : float; }

let hit (r : ray) (s : sphere) : hit_record option =
  let d = r.origin -| s.center in
  if vec_dot d d < s.radius *. s.radius then none
  else
    let a = vec_dot r.direction r.direction in
    let b = 2.0 *. vec_dot r.direction d in
    let c = (vec_dot d d) -. (s.radius *. s.radius) in
    let delta = b *. b -. 4.0 *. a *. c in
    if delta +. Float.epsilon < 0.0 then none
    else
      let k = Float.min
      ((Float.neg b -. Float.sqrt delta) /. (2.0 *. a))
      ((Float.neg b +. Float.sqrt delta) /. (2.0 *. a)) in
      if k +. Float.epsilon < 0.0 then none
      else
        let hit_point = r.origin +| (k *| r.direction) in
        let normal = (hit_point -| s.center) |/ s.radius in
        some {
          dist = k;
          hit_point = hit_point;
          normal = normal;
        }

let surface_area (s : sphere) : float =
  4.0 *. Float.pi *. s.radius *. s.radius