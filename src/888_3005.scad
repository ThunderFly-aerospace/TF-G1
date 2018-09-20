draft = true;

module 888_3005(){

magnet_diameter = 63;

difference(){
	union(){
		cylinder (h = coupling_wall_thickness, r = magnet_diameter/2, $fn = draft ? 50 :100);
		translate([0,0,coupling_wall_thickness])
		cylinder (h = coupling_wall_thickness/4, r = 608_bearing_outer_diameter/4, $fn = draft ? 50 : 100);
	}
	

	translate([0,0,-global_clearance])
		cylinder (h = 20, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);

}

translate([-5,magnet_diameter/2 - 4,0])
cube([10,4,15]);

}


888_3005();

use <./lib/naca4.scad>
include <../Parameters.scad>