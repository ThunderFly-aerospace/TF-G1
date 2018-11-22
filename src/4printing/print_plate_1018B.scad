include <../../Parameters.scad>
use <../888_1018.scad>

draft = false;

posuv = move_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2 + height_666_1026 + global_clearance/2;
difference(){
  rotate([180, 0, 0])
    888_1018(1, draft);
  translate([posuv, -500+ global_clearance, -global_clearance])
    cube(500);
}
