type vec3 = float * float * float
val ( +| ) : vec3 -> vec3 -> vec3
val ( -| ) : vec3 -> vec3 -> vec3
val ( *| ) : float -> vec3 -> vec3
val ( |* ) : vec3 -> float -> vec3
val ( |/ ) : vec3 -> float -> vec3
val vec_dot : vec3 -> vec3 -> float
val vec_len : vec3 -> float
val vec_normalized : vec3 -> vec3
val vec_cross : vec3 -> vec3 -> vec3
val vec_toint : vec3 -> int * int * int
val vec_neg : vec3 -> vec3
val vec_mul : vec3 -> vec3 -> vec3
val tbn : vec3 -> vec3 * vec3
val vec_gamma_correction : float -> vec3 -> vec3
val vec_cosine : vec3 -> vec3 -> float