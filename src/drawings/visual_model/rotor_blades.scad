			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

//sestava listy, závaží, kování

module rotor_blades(draft){

delka_listu = 970;
sirka_listu = 50;
uchytna_cast = 100;

translate([0,0,19.5])
	rotate([0,180,0])
		union(){

			translate([-24.4,40.7,19])
				rotate([rotor_flap0,180, - rotor_delta])
					//list
						
						translate([-sirka_listu/2, delka_listu/2,6])
							rotate([0,rotor_blade_AOA,0])
								import ("../../../STL/rotor_blade.stl", , convexity=3);

			rotate([0,0,180])
				translate([-24.4,40.7,19.0])
					rotate([rotor_flap0,180, - rotor_delta])
						//list
					
					translate([-sirka_listu/2, delka_listu/2,6])
						rotate([0,rotor_blade_AOA,0])
							import("../../../STL/rotor_blade.stl", convexity=10);

		}
}

//rotate([0,0,-20])
rotor_blades(draft);

use <../../lib/naca4.scad>
include <../../../Parameters.scad>