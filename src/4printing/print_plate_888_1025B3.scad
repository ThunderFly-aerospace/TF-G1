include <../../parameters.scad>
use <../888_1025.scad>

draft = true;

translate([0,0,top_cover_division[3]])
    rotate([0,90,0])
        888_1025_part_B(3, draft);
