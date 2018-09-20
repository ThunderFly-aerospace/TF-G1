draft = true;


module 888_3004(){  //díl 6 dle issue 156

width = 608_bearing_outer_diameter*1.5;
height = 60;

cube_Width = 608_bearing_outer_diameter*2.5 - 2*global_clearance;

difference(){
	union(){
	//základní kostka
	translate([- cube_Width/2, -width/2,width/2])
			cube([cube_Width, width,height - width/2]);
	translate([-cube_Width/2,0,width/2])
		rotate([0,90,0])
			cylinder(h = cube_Width, r = width/2, $fn = draft ? 50 : 100);
	}
	//otvor od osy dílu 888_3003
	translate([- cube_Width/2- global_clearance/2,0, 608_bearing_outer_diameter*0.75])
		rotate([0,90,0])
			cylinder(h = cube_Width + global_clearance, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);
	//vidlice
	translate([-width/2, - cube_Width/2 - global_clearance/2,-global_clearance])
			cube([width, cube_Width + global_clearance, width + global_clearance]);

//otvor pro šroub a ložiska
	translate([0,-width/2 + 608_bearing_thickness,width + (height - width)/2])
		rotate([90,0,0])
			cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);
	translate([0,width/2 + global_clearance,width + (height - width)/2])
		rotate([90,0,0])
			cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);
	translate([0,cube_Width,width + (height - width)/2])
		rotate([90,0,0])
			cylinder(h = cube_Width*2, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);


}


//výstupky
difference(){
	union(){
	translate([cube_Width/2 - coupling_wall_thickness*2,0,height])
			cube ([coupling_wall_thickness*2, width/2, width/2]);
	translate([-cube_Width/2,0,height])
			cube ([coupling_wall_thickness*2, width/2, width/2]);
		}

translate([cube_Width/2,width/4,height + width/4])
	rotate([0,-90,0])
		union(){
			translate([0,0,-global_clearance/2])
					cylinder (h = cube_Width + global_clearance, r = M6_screw_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,coupling_wall_thickness/2])
				rotate([0,0,90])
					cylinder (h = Nut_height_M6, r = Nut_diameter_M6/2, $fn = 6);
			translate([0,-Nut_diameter_M6/2,  coupling_wall_thickness/2])
					cube([20, Nut_diameter_M6, Nut_height_M6]);

			translate([0,0,cube_Width - coupling_wall_thickness*1.5])
				rotate([0,0,90])
					cylinder (h = Nut_height_M6, r = Nut_diameter_M6/2, $fn = 6);
			translate([0,-Nut_diameter_M6/2,cube_Width - coupling_wall_thickness*1.5])
					cube([20, Nut_diameter_M6, Nut_height_M6]);
		}

}



}



888_3004();
/*
translate([0,0,-70])
		888_3003();
translate([0,22.1*0.75 + 5 +2,75 - 22.1 - 5])
	rotate([90,0,0])
		888_3005();
*/

use <./lib/naca4.scad>
include <../Parameters.scad>
use <888_3003.scad>
use <888_3005.scad>