include <../../parameters.scad>

use <../888_2021.scad>

translate([0, -5, 0])
    rotate([0, 90, 180])
        888_2021(draft=false);

translate([-50, 9, 0])
    rotate([180, -90, 0])
        888_2021(draft=false);
