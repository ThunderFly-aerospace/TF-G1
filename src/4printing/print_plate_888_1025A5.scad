include <../../parameters.scad>
use <../888_1025.scad>

draft = true;

translate([150/4,150/2,0])
	rotate([90,0,45])
		888_1025_part_A(5,draft);
