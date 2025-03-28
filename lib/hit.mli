type hittable = {
  shape : Primitives.primitives;
  mat : Material.material
}

val hit_world : Ray.ray -> hittable list -> Hitrec.hit_record_with_mat option