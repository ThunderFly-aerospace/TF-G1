include <../../parameters.scad>

use <../888_2021.scad>

translate([0, 0, 0])
    rotate([0, 0, 180])
        motor_holder(draft=false);

translate([0, 35, 0])
        motor_holder(draft=false);
