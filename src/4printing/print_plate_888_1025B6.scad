include <../../parameters.scad>
use <../888_1025.scad>

draft = true;

translate([0,30,-top_cover_division[5]])
    rotate([90,-90,90])
        888_1025_part_B(6, draft);
