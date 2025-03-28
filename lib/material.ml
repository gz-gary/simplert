open Vec

type brdf = vec3 -> vec3 -> vec3
type light = vec3 -> vec3
type material = BRDF of brdf | Light of light

let lambert_brdf (rgb : vec3) (_ : vec3) (_ : vec3) : vec3 = 
  rgb |/ Float.pi

let fuse_light (rgbi : vec3) (_ : vec3) : vec3 =
  match rgbi with
  | (r, g, b) -> (r /. (2.0 *. Float.pi), g /. (2.0 *. Float.pi), b /. (2.0 *. Float.pi))