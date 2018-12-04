draft = true;

include <../Parameters.scad>

use <888_1015.scad>
use <888_1020.scad>


    888_1015();
    color([0.2, 0.2, 0.2, 0.5])
        translate([0,0,80+5])
            rotate([0,9,0])
                888_1020();
