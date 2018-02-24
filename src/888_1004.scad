//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


inter_diameter_pulley = 83.8;
outer_diameter_home = 40;
hole_for_rubber_X = 11;
hole_for_rubber_Y =31;
hole_for_rubber_Z = 49;
thickness = 10;
position_of_rubber = 25;
height = 50;



module 888_1004(draft){

intersection(){
	difference(){
		//vnitřní průměr řemenice
			cylinder(h = thickness, r = (inter_diameter_pulley - global_clearance)/2, $fn = draft ? 50:100);
		//vnější průměr domku
		translate([0,0,- global_clearance/2])
			cylinder(h = thickness + global_clearance, r = outer_diameter_home/2 + global_clearance, $fn =  draft ? 50 :100);
		//otvory na gumy
		translate([position_of_rubber,- hole_for_rubber_Y/2, - global_clearance/2])
			cube([hole_for_rubber_X,hole_for_rubber_Y,hole_for_rubber_Z]);
		translate([- position_of_rubber - hole_for_rubber_X, - hole_for_rubber_Y/2, - global_clearance/2])
			cube([hole_for_rubber_X,hole_for_rubber_Y,hole_for_rubber_Z]);
	}

	translate([- inter_diameter_pulley/2, - height/2, 0])
			cube([inter_diameter_pulley, height, thickness]);


//final intersection
}
//final module
}





888_1004(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
