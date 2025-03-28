open Simplert.Vec
open Simplert.Ppm
open Simplert.Ray
open Simplert.Hit
open Simplert.World
open Simplert.Sampling

let prob = 0.8

let rec trace (r : ray) : vec3 = 
  match hit_objs r world with
  | None -> (0.0, 0.0, 0.0) (* TODO: add sky texture *)
  | Some (hitrec, mat) -> 
    let wo = vec_neg r.direction in
    match mat with
    | Light light -> light wo (* TODO: transform tbn to xyz here *)
    | BRDF brdf ->
      if Random.float 1.0 < prob then
        let (t, b) = tbn hitrec.normal in
        let ((wi_x, wi_y, wi_z), pdf) = sample_direction_semi_sphere (Random.float 1.0) (Random.float 1.0) in
        let wi = (wi_x *| t) +| (wi_y *| b) +| (wi_z *| hitrec.normal) in
        let cosine = wi_z in
        (vec_mul (trace { origin = hitrec.hit_point; direction = wi; }) (brdf wi wo)) |* cosine |/ pdf |/ prob
      else
        (0.0, 0.0, 0.0)

let () =
  Random.self_init();
  let width = 400 in
  let height = 400 in
  let ratio = 0.005 in
  let multi_sampling_per_pix = 50 in
  let eye = (0.0, -1.0, 1.0) in
  let lookat = (0.0, 1.0, 0.0) in
  let up = vec_normalized (0.0, 0.0, 1.0) in
  let view_dir = vec_normalized (lookat -| eye) in
  let normalized_lookat = eye +| view_dir in
  let axis_y = vec_normalized (vec_cross view_dir up) in
  let axis_x = vec_normalized (vec_cross view_dir axis_y) in
  let corner = normalized_lookat -| ((float_of_int width /. 2.0) *. ratio *| axis_y) -| ((float_of_int height /. 2.0) *. ratio *| axis_x) in
  let example x y =
    vec_toint (List.fold_left ( +| ) (0.0, 0.0, 0.0) (
      List.init multi_sampling_per_pix (fun _ -> 
        let gamma = 0.5 in
        let shade_point = corner +| ((float_of_int y +. Random.float 1.0) *. ratio *| axis_y) +| ((float_of_int x +. Random.float 1.0) *. ratio *| axis_x) in
        vec_gamma_correction gamma (trace { origin = eye; direction = vec_normalized (shade_point -| eye) }) |* 255.0
      )
    ) |/ (float_of_int multi_sampling_per_pix))
  in
  write_ppm "test.ppm" width height example
