draft = true;

include <../Parameters.scad>

rotx = -$t;
roty = -5;

use <888_1015.scad>
use <888_1020.scad>

difference(){
    union(){
    color([0.8, 0.3, 0.3])
        888_1015();
    color([0.2, 0.8, 0.2, 0.9])
        translate([-4.2,0, 70])
            rotate([rotx,9+roty,0])
                translate([0,0,7])
                    888_1020();
    }
    translate([-250, 0, 0])
        cube(500);
}
