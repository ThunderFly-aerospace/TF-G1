draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1011(){
difference(){
union(){
translate([-2.7,0,0])
			cube([150,150,28.65]);
translate([0,0,0])
	rotate([0,-11,0])
		color([0,0.5,0])
			cube([150,150,30]);

union(){
	/*
translate([-29.5,57.5,30])
	rotate([0,0,-20])
		color([0.5,0,0])
			cube([115,125,28]);
			*/
/*
translate([111.5,-20,-33])
	rotate([0,-90,0])
		888_1008_A();
		*/
translate([87.5,35,40])
	//rotate([0,-20,0])
		cylinder(h = 30, r = radius_undercarriage*0.75, $fn = draft ? 100 : 200);


}
difference(){
translate([-29.5,57.5,21.9])
	rotate([0,0,-20])
		color([0.5,0,0])
			cube([115,135,48]);

translate([86.1,35,41])		
		color([0,0,0.5])
			cube([40,150,30]);
		}
translate([86.1,35,39.8])		
		color([0,0,0.5])
			cube([20,150,30]);


}

translate([-10,150,0])
		cube([160,50,150]);
translate([-50,-10,0])
		cube([50,170,150]);

}

}

888_1011();
/*
translate([111.5,-20,-33])
	rotate([0,-90,0])
		888_1008_A();
*/
use <888_1008.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>