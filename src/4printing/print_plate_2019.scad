include <../../parameters.scad>

use <../888_2019.scad>

translate([-20, 0, 0])
    rotate([0, 180, 0])
        888_2019(draft=false);

translate([20, 0, 0])
    rotate([0, 180, 0])
        888_2019(draft=false);