open Simplert.Vec
open Simplert.Ppm
open Simplert.Ray
open Simplert.Hit
open Simplert.World
open Simplert.Sampling

let prob = 0.8

let rec shade (p : vec3) (norm : vec3) (brdf : vec3 -> vec3 -> vec3) (wo : vec3) : vec3 = 
  let l_dir : vec3 = 
    match sample_shape lights.shape with
    | (point, pdf) -> 
      let wi = vec_normalized (point -| p) in
      let r = { origin = p; direction = wi; } in
      match hit_world r world with
      | None -> (0.0, 0.0, 0.0)
      | Some (hitrec, mat) ->
        if vec_len (hitrec.hit_point -| point) < 0.001 then
          match mat with
          | Light light -> 
            let cosine1 = vec_cosine norm wi in
            if cosine1 < 0.0 then (0.0, 0.0, 0.0)
            else
              let cosine2 = vec_cosine hitrec.normal (vec_neg wi) in
              let sqr_dist = vec_dot (point -| p) (point -| p) in
              (vec_mul (light (vec_neg wi)) (brdf wi wo)) |* cosine1 |* cosine2 |/ sqr_dist |/ pdf
          | BRDF _ -> (0.0, 0.0, 0.0)
        else (0.0, 0.0, 0.0)
  in
  let l_indir =
    if Random.float 1.0 < prob then
      let (t, b) = tbn norm in
      let ((wi_x, wi_y, wi_z), pdf) = sample_direction_semi_sphere (Random.float 1.0) (Random.float 1.0) in
      let wi = (wi_x *| t) +| (wi_y *| b) +| (wi_z *| norm) in
      let cosine = wi_z in
      let r = { origin = p; direction = wi; } in
      match hit_world r world with
      | None -> (0.0, 0.0, 0.0)
      | Some (hitrec, mat) ->
        match mat with
        | Light _ -> (0.0, 0.0, 0.0)
        | BRDF brdf_next ->
          (vec_mul (shade hitrec.hit_point hitrec.normal brdf_next (vec_neg wi)) (brdf wi wo)) |* cosine |/ pdf |/ prob
    else
      (0.0, 0.0, 0.0)
  in
  l_dir +| l_indir

let () =
  Random.self_init();
  let width = 1440 in
  let height = 1440 in
  let ratio = 0.00046 in
  let multi_sampling_per_pix = 30 in
  let eye = (0.0, 0.5, 6.0) in
  let lookat = (0.0, 0.5, 0.0) in
  let up = vec_normalized (0.0, 1.0, 0.0) in
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
        vec_gamma_correction gamma (
          let wo = vec_normalized (shade_point -| eye) in
          match hit_world { origin = eye; direction = wo; } world with
          | None -> (0.0, 0.0, 0.0)
          | Some (hitrec, mat) ->
            match mat with
            | Light light -> light (vec_neg wo)
            | BRDF brdf -> shade hitrec.hit_point hitrec.normal brdf (vec_neg wo)
        ) |* 255.0
      )
    ) |/ (float_of_int multi_sampling_per_pix))
  in
  write_ppm "test.ppm" width height example
