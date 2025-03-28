(* sample a direction on a semi-sphere with norm = (0.0, 0.0, 1.0) *)
val sample_direction_semi_sphere : float -> float -> Vec.vec3 * float
val sample_shape : Primitives.primitives -> Vec.vec3 * float
