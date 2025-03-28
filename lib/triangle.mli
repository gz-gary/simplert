type triangle = { v1 : Vec.vec3; v2 : Vec.vec3; v3 : Vec.vec3 }
val hit : Ray.ray -> triangle -> Hitrec.hit_record option
val surface_area : triangle -> float