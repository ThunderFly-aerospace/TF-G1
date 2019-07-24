include <../../parameters.scad>

use <../888_1027.scad>

translate([0, -5, 0])
    rotate([0, 90, 180])
        888_1027(draft=false);

translate([-50, 10, 0])
    rotate([180, -90, 0])
        888_1027(draft=false);
