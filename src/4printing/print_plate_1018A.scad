include <../../Parameters.scad>
use <../888_1018.scad>

draft = false;

difference(){
  888_1018(1, draft);
  translate([-500 + global_clearance, -500 + global_clearance, -global_clearance])
    cube(500);
}
