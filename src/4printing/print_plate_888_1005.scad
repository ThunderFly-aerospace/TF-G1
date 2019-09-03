include <../../parameters.scad>

use <../888_1005.scad>

draft = false;


translate([0, 15, 0]) 888_1005_cut();
mirror([0, 1, 0])
translate([0, 15, 0]) 888_1005_cut();
