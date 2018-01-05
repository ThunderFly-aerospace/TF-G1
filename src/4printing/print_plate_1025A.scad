use <../lib/naca4.scad>
include <../../Parameters.scad>
use <../666_1025.scad>

draft = false;

translate([0,0,10])
    rotate([90,0,0])
        666_1025_part(1, draft);



