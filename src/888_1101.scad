draft = true;

include <../Parameters.scad>

use <888_1015.scad>
use <888_1020.scad>

    color([0.8, 0.3, 0.3])
        888_1015();
    color([0.2, 0.8, 0.2, 0.9])
        translate([-10,0,80])
            rotate([-0,9,0])
                translate([0,0,6])
                    888_1020();
