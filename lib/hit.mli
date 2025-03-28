type hittable = {
  shape : Primitives.primitives;
  mat : Material.material
}

val hit_primitives : Ray.ray -> Primitives.primitives list -> Hitrec.hit_record option
val hit_world : Ray.ray -> hittable list -> Hitrec.hit_record_with_mat option