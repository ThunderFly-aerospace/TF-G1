include <../../parameters.scad>
use <../888_1025.scad>

draft = false;

translate([0,0,-top_cover_division[5]])
	rotate([0,-90,0])
		888_1025_part_A(6,draft);
