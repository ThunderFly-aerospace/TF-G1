include <../../parameters.scad>
use <../888_1025.scad>

draft = false;

translate([0,0,-maximum_printable_size*2])
	rotate([0,-90,0])
		888_1025_part_A(4,draft);
