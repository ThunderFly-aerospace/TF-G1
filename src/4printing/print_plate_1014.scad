include <../../parameters.scad>

use <../666_1014.scad>

    translate([-2,0,0])
        rotate([0,-90,0])
            666_1014_A(draft=false);

    translate([2,0,0])
        rotate([0,90,0])
            666_1014_B(draft=false);