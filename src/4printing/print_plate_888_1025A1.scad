include <../../parameters.scad>
use <../888_1025.scad>

draft = false;

translate([0,0,10])
    rotate([90,90,0])
        888_1025_part_A(1, draft);
