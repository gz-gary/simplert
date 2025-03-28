open Material
open Primitives
open Ray
open Hitrec

type hittable = {
  shape : primitives;
  mat : material
}

let hit (r : ray) (p : primitives) : hit_record option =
  match p with
  | Triangle t -> Triangle.hit r t
  | Sphere s -> Sphere.hit r s
  | Panel p -> Panel.hit r p

let rec hit_primitives (r : ray) (objs : primitives list) : hit_record option =
  match objs with
  | [] -> None
  | obj :: others ->
    match hit r obj, hit_primitives r others with
    | None, None -> None
    | None, Some hitrec -> Some hitrec
    | Some hitrec, None -> Some hitrec
    | Some hitrec1, Some hitrec2 ->
      if hitrec1.dist < hitrec2.dist then Some hitrec1
      else Some hitrec2

let rec hit_world (r : ray) (objs : hittable list) : hit_record_with_mat option =
  match objs with
  | [] -> None
  | obj :: others ->
    match hit r obj.shape, hit_world r others with
    | None, None -> None
    | None, Some hit_record_with_mat -> Some hit_record_with_mat
    | Some hit_record, None -> Some (hit_record, obj.mat)
    | Some hit_record1, Some (hit_record2, mat) ->
      if hit_record1.dist < hit_record2.dist then Some (hit_record1, obj.mat)
      else Some (hit_record2, mat)