open Vec

let sample_direction_semi_sphere (a : float) (b : float): vec3 * float = 
  let theta = 2.0 *. Float.pi *. b in
  (vec_normalized (Float.cos theta, Float.sin theta, a), 1.0 /. (2.0 *. Float.pi))
  