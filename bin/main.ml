let () =
  let width = 200 in
  let height = 200 in
  let example1 y x =
    (
      y * 255 / width,
      (width - y) * 255 / width,
      x * 255 / height
    )
  in
  Simplert.Ppm.write_ppm "test.ppm" width height example1
