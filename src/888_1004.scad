//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1004(draft){

intersection(){
	difference(){
		//vnitřní průměr řemenice
			cylinder(h = 10, r = (83.8 - global_clearance)/2, $fn = draft ? 50:100);
		//vnější průměr domku
		translate([0,0,- global_clearance/2])
			cylinder(h = 10 + global_clearance, r = 40/2 + global_clearance, $fn =  draft ? 50 :100);
		//otvory na gumy
		translate([25,- 31/2, - global_clearance/2])
			cube([11,31,49]);
		translate([- 25 - 11, -31/2, - global_clearance/2])
			cube([11,31,49]);
	}

	translate([- 83.8/2, -50/2, 0])
			cube([83.8, 50,10]);

//final intersection
}
//final module
}





888_1004(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
