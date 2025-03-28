open Vec
open Primitives

let sample_direction_semi_sphere (a : float) (b : float): vec3 * float = 
  let theta = 2.0 *. Float.pi *. b in
  (vec_normalized (Float.cos theta, Float.sin theta, a), 1.0 /. (2.0 *. Float.pi))

let sample_shape (p : primitives) : vec3 * float = 
  match p with
  | Sphere s ->
      let u = Random.float 1.0 in
      let v = Random.float 1.0 in
      let theta = 2.0 *. Float.pi *. u in
      let phi = Float.acos (2.0 *. v -. 1.0) in
      let x = s.radius *. Float.sin phi *. Float.cos theta in
      let y = s.radius *. Float.sin phi *. Float.sin theta in
      let z = s.radius *. Float.cos phi in
      let point = s.center +| (x, y, z) in
      (point, 1.0 /. Sphere.surface_area s)
  | Panel p ->
      let u = Random.float 1.0 in
      let v = Random.float 1.0 in
      (p.base +| u *| p.edge0 +| v *| p.edge1, 1.0 /. Panel.surface_area p)
  | Triangle t ->
      let u = Random.float 1.0 in
      let v = Random.float 1.0 in
      if u +. v > 1.0 then
        ((u +. v -. 1.0) *| t.v1 +| (1.0 -. u) *| t.v2 +| (1.0 -. v) *| t.v3, 1.0 /. Triangle.surface_area t)
      else
        ((1.0 -. u -. v) *| t.v1 +| u *| t.v2 +| v *| t.v3, 1.0 /. Triangle.surface_area t)
  | Box _ -> ((0.0, 0.0, 0.0), 0.0) (* TODO: sample box *)