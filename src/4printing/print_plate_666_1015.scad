include <../../Parameters.scad>

use <../666_1015.scad>

    translate([-2,0,0])
        rotate([0,-90,0])
            666_1015_A(draft=false);

    translate([2,0,0])
        rotate([0,90,0])
            666_1015_B(draft=false);