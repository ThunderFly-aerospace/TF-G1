module 888_1007(){
	intersection(){
		drop_skin();
		translate([0,-hull_y_size - thickness_between_tubes,-hull_z_size/2])
		cube([hull_drop_length, hull_y_size, hull_z_size]);	

	}



}


888_1007();




use <888_1000.scad>
use <888_1004.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>