include <../../Parameters.scad>
use <../888_1018.scad>

draft = false;

mirror([0,1,0])
    difference(){
      888_1018(1, draft);
      translate([0, -500 + global_clearance, -global_clearance])
        cube(500);
    }
