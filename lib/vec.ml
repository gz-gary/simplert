type vec3 = float * float * float

let vec_add (a : vec3) (b : vec3) : vec3 = 
  match a, b with
  | (xa, ya, za), (xb, yb, zb) -> (xa +. xb, ya +. yb, za +. zb)

let vec_sub (a : vec3) (b : vec3) : vec3 = 
  match a, b with
  | (xa, ya, za), (xb, yb, zb) -> (xa -. xb, ya -. yb, za -. zb)

let vec_mul_l (k : float) (v : vec3) : vec3 =
  match v with
  | (x, y, z) -> (k *. x, k *. y, k *. z)

let vec_mul_r (v : vec3) (k : float) : vec3 =
  match v with
  | (x, y, z) -> (x *. k, y *. k, z *. k)

let vec_div (v : vec3) (k : float) : vec3 =
  match v with
  | (x, y, z) -> (x /. k, y /. k, z /. k)

let vec_dot (a : vec3) (b : vec3) : float =
  match a, b with
  | (xa, ya, za), (xb, yb, zb) -> xa *. xb +. ya *. yb +. za *. zb

let vec_len (v : vec3) : float =
  match v with
  | (x, y, z) -> sqrt (x *. x +. y *. y +. z *. z)

let vec_normalized (v : vec3) : vec3 =
  vec_div v (vec_len v)

let vec_cross (a : vec3) (b : vec3) : vec3 =
  match a, b with
  | (xa, ya, za), (xb, yb, zb) -> 
      ( ya *. zb -. za *. yb,  (* a_y * b_z - a_z * b_y *)
        za *. xb -. xa *. zb,  (* a_z * b_x - a_x * b_z *)
        xa *. yb -. ya *. xb ) (* a_x * b_y - a_y * b_x *)

let vec_toint (v : vec3) : int * int * int =
  match v with
  | (x, y, z) -> (int_of_float x, int_of_float y, int_of_float z)

let vec_neg (v : vec3) : vec3 =
  match v with
  | (x, y, z) -> (Float.neg x, Float.neg y, Float.neg z)

let vec_mul (a : vec3) (b : vec3) : vec3 =
  match a, b with
  | (xa, ya, za), (xb, yb, zb) -> (xa *. xb, ya *. yb, za *. zb)

let tbn (n : vec3) : vec3 * vec3 = 
  match n with
  | (_, _, z) ->
    let t = 
      if 1.0 -. (Float.abs z) < Float.epsilon then vec_cross (1.0, 0.0, 0.0) n
      else vec_cross (0.0, 0.0, 1.0) n in
    let b = vec_cross n t in
    (vec_normalized t, vec_normalized b)
    
let gamma_correction (gamma : float) (f : float) : float = 
  Float.pow f gamma

let vec_gamma_correction (gamma : float) (v : vec3) : vec3 =
  match v with
  | (r, g, b) -> let f = gamma_correction gamma in (f r, f g, f b)

let ( +| ) = vec_add
let ( -| ) = vec_sub
let ( *| ) = vec_mul_l
let ( |* ) = vec_mul_r
let ( |/ ) = vec_div