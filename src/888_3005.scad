draft = true;

module 888_3005(){

width = 608_bearing_outer_diameter*1.5;


magnet_diameter = 63;

difference(){
	union(){
	//velikost magnetu
				cylinder (h = coupling_wall_thickness, r = magnet_diameter/2, $fn = draft ? 50 :100);
	//osazení uprostřed	
		translate([0,0,coupling_wall_thickness])
				cylinder (h = coupling_wall_thickness/4, r = 608_bearing_outer_diameter/4, $fn = draft ? 50 : 100);
	//trn
		translate([-width/4,magnet_diameter/2 - width/2,0])
				cube([width/2,width/3,width/2]);
	}
	
	//otvor uprostřed
	translate([0,0,-global_clearance])
			cylinder (h = 20, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);

	//otvor v trnu
	translate([0,magnet_diameter/2 - (width/2)/2,-width/8])
			cylinder (h = width/2, r = M6_screw_diameter/2, $fn = draft ? 50 : 100);
	translate([0,magnet_diameter/2 - (width/2)/2,width/6])
			cylinder(h = M6_nut_height, r = M6_nut_diameter/2, $fn = 6);
	translate([-M6_nut_diameter/2,magnet_diameter/2 - (width/2)/2,width/6])
			cube([M6_nut_diameter, 20, M6_nut_height]);
}


}


888_3005();

use <./lib/naca4.scad>
include <../Parameters.scad>