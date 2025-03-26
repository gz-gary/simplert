open OUnit2
open Simplert.Triangle
open Simplert.Ray
open Simplert.Vec

let ray = { origin = (0.0, 0.0, 0.0); direction = vec_normalized (0.0, 1.0, 0.1); }
let t = { v1 = (-1.5, 3.0, -1.0); v2 = (1.5, 3.0, -1.0); v3 = (0.0, 3.0, 2.0) }

let _ = match Simplert.Triangle.hit ray t with
  | None -> Printf.printf "Not hit"
  | Some hitrec ->
    match hitrec.hit_point with (a, b, c) -> Printf.printf "Hit at (%f, %f, %f)" a b c;
    assert_equal 0 0