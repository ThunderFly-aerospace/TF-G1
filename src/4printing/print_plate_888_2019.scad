include <../../parameters.scad>

use <../888_2019.scad>

translate([-10, -15, 0])
    rotate([180, 0, 180])
        888_2019(draft=false);

translate([10, 15, 0])
    rotate([180, 0, 0])
        888_2019(draft=false);
