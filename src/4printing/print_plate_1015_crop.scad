include <../../Parameters.scad>

use <../888_1015.scad>

crop = 50;

translate([0, 0, -crop])
    difference(){
        888_1015(draft=false);
        translate([-50, -50, -100 + crop]) cube(100);
    }
