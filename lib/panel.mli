type panel = { base : Vec.vec3; d1 : Vec.vec3; d2 : Vec.vec3 }
val hit : Ray.ray -> panel -> Hitrec.hit_record option
val surface_area : panel -> float