include <../../parameters.scad>
use <../666_1025.scad>

draft = false;

translate([0,0,top_cover_division[2]])
    rotate([90,90,0])
        666_1025_part(2, draft);




