open Vec
open Ray
open Hitrec
open Panel

type box = { base : vec3; edgex : vec3; edgey : vec3; edgez : vec3; }

let hit (r : ray) (b : box) : hit_record option =
  hitrec_closest [
    Panel.hit r { base = b.base; edge0 = b.edgex; edge1 = b.edgez; } ;
    Panel.hit r { base = b.base; edge0 = b.edgey; edge1 = b.edgex; } ;
    Panel.hit r { base = b.base; edge0 = b.edgez; edge1 = b.edgey; } ;
    Panel.hit r { base = b.base +| b.edgex; edge0 = b.edgey; edge1 = b.edgez; } ;
    Panel.hit r { base = b.base +| b.edgey; edge0 = b.edgez; edge1 = b.edgex; } ;
    Panel.hit r { base = b.base +| b.edgez; edge0 = b.edgex; edge1 = b.edgey; } ;
  ]

let surface_area (b : box) : float = 
  2.0 *. (
    Panel.surface_area { base = b.base; edge0 = b.edgex; edge1 = b.edgez; }
    +. Panel.surface_area { base = b.base; edge0 = b.edgey; edge1 = b.edgex; }
    +. Panel.surface_area { base = b.base; edge0 = b.edgez; edge1 = b.edgey; }
  )