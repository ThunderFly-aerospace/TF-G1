			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

			       translate([main_tube_outer_diameter*2,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);
	
	translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);



		666_1027(draft);

translate([-hull_wall_thickness,0,0])
		666_1029(draft);

	rotate([90,0,90])
		666_1026(draft);

translate([-hull_wall_thickness,0,0])
		666_1025(draft);

translate([cover_pilon_position - 2*hull_wall_thickness,0,0])
	rotate([-90,0,0])
		666_1032(draft);

translate([main_pilon_position,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2,0])
	rotate([-90,0,0])
			666_1026(draft);

//hlavní trubky

		//nejdelší

			rotate ([0,90,0])
				cylinder (h = 920, r = Help_main_tube_outer/2, $fn = 200);


		//kolmá na nejdelší
		translate ([main_pilon_position,main_tube_outer_diameter/2,0])
			rotate([-90,0,0])
				cylinder (h = height_of_vertical_tube, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

	
		//kolmá na nejdelší - pro podvozek
			//přední

			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,-150])
				cylinder (h = 300, r = Help_main_tube_outer/2,$fn = 200);

			//zadní

		translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, -150])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);



use <666_1004.scad>
use <666_1026.scad>
use <666_1027.scad>
use <666_1029.scad>
use <666_1025.scad>
use <666_1032.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>

