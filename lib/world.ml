open Material
open Primitives
(* open Box *)
open Panel
open Hit

let lights = 
  { shape = Panel { base = (-0.3, 1.99, -0.3); edge0 = (0.6, 0.0, 0.0); edge1 = (0.0, 0.0, 0.6); }; mat = Light (fuse_light (200.0, 200.0, 200.0)) }

let world = [
  lights;
  { shape = Panel { base = (-1.5, -1.0, -1.5); edge0 = (0.0, 0.0, 3.0); edge1 = (3.0, 0.0, 0.0); } ; mat = BRDF (lambert_brdf (0.5, 0.5, 0.5)); };
  { shape = Panel { base = (-1.5, 2.0, -1.5); edge0 = (3.0, 0.0, 0.0); edge1 = (0.0, 0.0, 3.0); } ; mat = BRDF (lambert_brdf (0.8, 0.8, 0.8)); };
  { shape = Panel { base = (-1.5, -1.0, -1.5); edge0 = (0.0, 3.0, 0.0); edge1 = (0.0, 0.0, 3.0); } ; mat = BRDF (lambert_brdf (0.7, 0.3, 0.3)); };
  { shape = Panel { base = (1.5, -1.0, -1.5); edge0 = (0.0, 0.0, 3.0); edge1 = (0.0, 3.0, 0.0); } ; mat = BRDF (lambert_brdf (0.3, 0.7, 0.3)); };
  { shape = Panel { base = (1.5, -1.0, -1.5); edge0 = (0.0, 3.0, 0.0); edge1 = (-3.0, 0.0, 0.0); } ; mat = BRDF (lambert_brdf (0.5, 0.5, 0.5)); };
  { shape = Box { base = (-0.3, -1.0, -0.7); edgex = (-0.6, 0.0, 0.4); edgey = (0.4, 0.0, 0.6); edgez = (0.0, 2.0, 0.0); }; mat = BRDF (lambert_brdf (0.5, 0.5, 0.5)); } ;
  { shape = Box { base = (1.1, -1.0, 0.2); edgex = (-0.6, 0.0, -0.4); edgey = (-0.4, 0.0, 0.6); edgez = (0.0, 1.0, 0.0); }; mat = BRDF (lambert_brdf (0.5, 0.5, 0.5)); }
]
