open Material
open Primitives
open Sphere
(* open Triangle *)
open Panel
open Hit

(* let world = [
  (* { shape = Sphere { center = (0.0, 2.0, 0.0); radius = 1.0; }; mat = BRDF lambert_brdf }; *)
  { shape = Sphere { center = (0.0, 2.5, 0.5); radius = 0.5; }; mat = Light (fuse_light (5.0, 5.0, 5.0)) };
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (-1.5, 3.0, -1.0); v3 = (-1.5, 3.0, 1.0)} ; mat = Light (fuse_light (1.0, 1.0, 1.0)); }; *)
  (* { shape = Triangle { v1 = (-1.5, 3.0, -1.0); v2 = (1.5, 4.0, -1.0); v3 = (0.0, 3.0, 2.0) } ; mat = Light (fuse_light (1.0, 1.0, 1.0)); }; *)
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (-1.5, 3.0, -1.0); v3 = (-1.5, 3.0, 1.0)} ; mat = BRDF lambert_brdf; }; *)
  (* { shape = Triangle { v1 = (-1.5, 3.0, -1.0); v2 = (1.5, 3.0, -1.0); v3 = (0.0, 3.0, 2.0) } ; mat = BRDF lambert_brdf; }; *)
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (1.5, 1.0, -1.0); v3 = (1.5, 4.0, -1.0) } ; mat = Light (fuse_light (5.0, 5.0, 5.0)); }; *)
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (1.5, 4.0, -1.0); v3 = (-1.5, 4.0, -1.0) } ; mat = Light (fuse_light (5.0, 5.0, 5.0)); }; *)
  { shape = Panel { base = (-1.5, -3.0, -1.0); d1 = (3.0, 0.0, 0.0); d2 = (0.0, 7.0, 0.0); } ; mat = BRDF lambert_brdf; };
  { shape = Panel { base = (-1.5, -3.0, -1.0); d1 = (0.0, 7.0, 0.0); d2 = (0.0, 0.0, 3.0); } ; mat = BRDF lambert_brdf; };
  { shape = Panel { base = (1.5, -3.0, -1.0); d1 = (0.0, 0.0, 3.0); d2 = (0.0, 7.0, 0.0); } ; mat = BRDF lambert_brdf; };
  { shape = Panel { base = (-1.5, -3.0, 2.0); d1 = (0.0, 7.0, 0.0); d2 = (3.0, 0.0, 0.0); } ; mat = BRDF lambert_brdf; };
  { shape = Panel { base = (-1.5, 4.0, -1.0); d1 = (3.0, 0.0, 0.0); d2 = (0.0, 0.0, 3.0); } ; mat = BRDF lambert_brdf; };
  { shape = Panel { base = (-1.5, -3.0, -1.0); d1 = (0.0, 0.0, 3.0); d2 = (3.0, 0.0, 0.0); } ; mat = BRDF lambert_brdf; };
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (1.5, 1.0, -1.0); v3 = (1.5, 4.0, -1.0) } ; mat = BRDF lambert_brdf; }; *)
  (* { shape = Triangle { v1 = (-1.5, 1.0, -1.0); v2 = (1.5, 4.0, -1.0); v3 = (-1.5, 4.0, -1.0) } ; mat = BRDF lambert_brdf; }; *)
] *)

let world = [
  { shape = Sphere { center = (0.0, 2.0, 0.0); radius = 1.0; }; mat = Light (fuse_light (5.0, 5.0, 5.0)) };
  { shape = Panel { base = (-100.0, -100.0, -1.0); d1 = (200.0, 0.0, 0.0); d2 = (0.0, 200.0, 0.0); } ; mat = BRDF lambert_brdf; };
]