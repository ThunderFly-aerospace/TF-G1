			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module overview(draft){

drop();
//// 666__1032
translate([cover_pilon_position - 2*hull_wall_thickness,0,0])
	rotate([-90,0,0])
    	difference (){

    		airfoil_thickness = 0030;
		    depth = main_tube_outer_diameter*2;
		    width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
		    height = depth;

    		airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes, open = false);

      		// výřez pro rotorovou hlavu
    		translate ([main_tube_outer_diameter + coupling_wall_thickness*2, -depth/2 - global_clearance, height_of_vertical_tube - main_tube_outer_diameter*2 - 2*global_clearance + main_tube_outer_diameter/2 + thickness_between_tubes])
            	cube ([width*5,depth + 2*global_clearance, height + global_clearance + main_tube_outer_diameter]);

        }

	rotate([90,0,90])
		666_1026(draft);

	translate([main_pilon_position,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes,0])
		rotate([-90,0,0])
			666_1026(draft);
	
	echo("Rotor position:", main_pilon_position,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes,0);


	translate([length_of_main_tube - 80 + global_clearance,0,0])
		rotate([0,90,0])
			666_1028_flightgear();

	translate([length_of_main_tube - 80 + global_clearance,0,0])
		rotate([0,-90,180])
			666_1028_flightgear();

	//// podvozek
	translate([0, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 - 45])
		rotate([-90,-90,0])
			888_1008_C();

	translate([0, - 131 - Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2 + 45])
		rotate([-90,-90,0])
			888_1008_D();


	//// úchytky na kolečka
	translate([2*main_tube_outer_diameter + coupling_wall_thickness, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
		rotate([0,90,0])
			666_1014();

	echo("Front gear position:", 2*main_tube_outer_diameter + coupling_wall_thickness + (tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage)/2, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage);

	translate([- tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage + second_undercarriage_hole - vzdalenost_x - radius_undercarriage , - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
		rotate([0,90,0])
			666_1014();

	echo("Rear gear position:", - tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage + second_undercarriage_hole - vzdalenost_x - radius_undercarriage + (tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage)/2, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage);



	mirror([0,0,1])
	union(){
	translate([2*main_tube_outer_diameter + coupling_wall_thickness, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
		rotate([0,90,0])
			666_1014();

	translate([- tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage + second_undercarriage_hole - vzdalenost_x - radius_undercarriage , - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
		rotate([0,90,0])
			666_1014();
	}


	//hlavní trubky
	//nejdelší
	rotate ([0,90,0])
		cylinder (h = length_of_main_tube, r = Help_main_tube_outer/2, $fn = 20);

	//kolmá na nejdelší
	translate ([main_pilon_position, main_tube_outer_diameter/2 + thickness_between_tubes,0])
		rotate([-90,0,0])
		    color([1,0,0])
			cylinder (h = height_of_vertical_tube, r = Help_main_tube_outer/2, $fn = 20);
		
	translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,- length_of_undercarriage_tube/2])
	    color([1,0,0])
			cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);

	echo("Front undercarrige tube position:", Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes, -length_of_undercarriage_tube/2);

	translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2])
	    color([1,0,0])
			cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);

	echo("Rear undercarrige tube position:", second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2);

//final module
}


overview(draft);


use <../../666_1004.scad>
use <../../666_1026.scad>
use <../../666_1027.scad>
use <../../666_1029.scad>
use <../../666_1025.scad>
use <../../666_1032.scad>
use <../../888_1000.scad>
use <../../666_1017.scad>
use <../../666_1028.scad>
use <../../666_1006.scad>
use <../../333_1037.scad>
use <../../666_1232.scad>
use <../../888_1008.scad>
use <../../666_1014.scad>

use <../lib/naca4.scad>
include <../../parameters.scad>

