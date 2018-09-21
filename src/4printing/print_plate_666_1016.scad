include <../../Parameters.scad>

use <../666_1016.scad>

    translate([-2,0,0])
        rotate([0,-90,0])
            666_1016_A(draft=false);

    translate([2,0,0])
        rotate([0,90,0])
            666_1016_B(draft=false);