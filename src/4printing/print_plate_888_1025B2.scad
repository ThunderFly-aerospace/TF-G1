include <../../parameters.scad>
use <../888_1025.scad>

draft = false;

translate([0,30,-340])
    rotate([90,90,90])
        888_1025_part_B(2, draft);
