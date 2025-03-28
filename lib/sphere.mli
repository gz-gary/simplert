type sphere = { center : Vec.vec3; radius : float; }
val hit : Ray.ray -> sphere -> Hitrec.hit_record option
val surface_area : sphere -> float