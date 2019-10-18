include <../../parameters.scad>
use <../888_1025.scad>

draft = false;

translate([0,0,top_cover_division[2]])
    rotate([90,90,0])
        888_1025_part_B(1, draft);
