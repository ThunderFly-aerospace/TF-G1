			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 666_2000(draft){

	////
	
		translate([-hull_wall_thickness,0,0])
			color([0,0,0.8])
				import ("../../STL/666_1025.stl");

		translate([-hull_wall_thickness/2,0,0])
			color([0,0,0.8])
				import ("../../STL/666_1029.stl");

	////
	666_1027(draft);

	////
		//spojka přední část
		translate([main_tube_outer_diameter*2,0,0])
			rotate([0,90,0])
				import ("../../STL/888_2003.stl");


	//spojka zadní část
		translate([second_undercarriage_hole - coupling_width_666_1004/2,0,0])
			rotate([0,90,0])
				import ("../../STL/666_1004.stl");
	////
	//spojka prostřední část
		translate([main_pilon_position,70 - coupling_wall_thickness - main_tube_outer_diameter/2,0])
			rotate([0,-90,90])
				import ("../../STL/666_1017.stl");

	////
		translate([cover_pilon_position - hull_wall_thickness,0,0])
			rotate([-90,0,0])
				import ("../../STL/666_1032.stl");





	////
	//akumulátory s držáky
		translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - 2*sink_of_accumulator,height_of_accumulator*0.5])
		   	color([0.8,0,0.8])
				import ("../../STL/imitation/accumulator_imitation.stl");


		translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - 2*sink_of_accumulator,-height_of_accumulator*1.5])
		   	color([0.8,0,0.8])
				import ("../../STL/imitation/accumulator_imitation.stl");

		translate([move_of_accumulator,main_tube_outer_diameter/2,-height_of_accumulator])
			rotate([-90,0,0])
				color([0,0.8,0.8])
					import ("../../STL/888_1001.stl");

		translate([move_of_accumulator,main_tube_outer_diameter/2,height_of_accumulator])
			rotate([-90,0,0])
				color([0,0.8,0.8])
					import ("../../STL/888_1001.stl");

	////
		translate([height_666_1026,0,0])
			rotate([-90,0,90])
				color([0.4,0,0.8])
					import ("../../STL/888_1026.stl");


	////
		translate([main_tube_outer_diameter/2 + main_tube_outer_diameter*2 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2,0])
		    rotate([0,90,-90])
		        color([0,1,1])
					import ("../../STL/888_2002.stl");


	//	translate([main_tube_outer_diameter*2.5 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2 + 25.8,0])
	//	    rotate([-90,0,0])
	//	        color([0,0.5,0.5])
	//	            888_2005(draft);
	//	translate([main_tube_outer_diameter*2.5 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2 + 25.8,0])
	//	    rotate([90,0,180])
	//	      	color([0,0.5,0.5])
	//	            888_2006(draft);

	////

		translate([length_of_main_tube - 80 + global_clearance,0,0])
			rotate([0,90,0])
					import ("../../STL/666_1028.stl");
	

		translate([length_of_main_tube - 80 + global_clearance + 10,0,0])
			rotate([0,-90,180])
					import ("../../STL/666_1028.stl");


	////
		translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube_rear/2 - global_clearance/2])
				color([0,0,0.8])
					import ("../../STL/666_1006.stl");


		translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube_rear/2 + global_clearance/2])
			rotate([180,0,0])
				color([0,0,0.8])
					import ("../../STL/666_1006.stl");

	////
	//podvozkové trubky
		translate([second_undercarriage_hole,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,length_of_undercarriage_tube_rear/2 - 120])
			rotate([-90,-90,0])
				color([1,0,0])
					import ("../../STL/888_1008_E.stl");


		translate([second_undercarriage_hole,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,-length_of_undercarriage_tube_rear/2 + 120])
			rotate([-90,-90,0])
				color([1,0,0])
					import ("../../STL/888_1008_F.stl");

	////
	//úchytky na podvozková kolečka
		translate([second_undercarriage_hole + vzdalenost_x,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,-length_of_undercarriage_tube_rear/2 - 120 - radius_undercarriage/2 - vzdalenost_x/2])
			rotate([0,90,0])
					import ("../../STL/666_1014.stl");

		translate([second_undercarriage_hole + vzdalenost_x,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,length_of_undercarriage_tube_rear/2 + 120 + radius_undercarriage/2 +vzdalenost_x/2])
			rotate([0,90,0])
					import ("../../STL/666_1014.stl");

	//trubky

		//nejdelší
		difference(){
				rotate ([0,90,0])
				    color([1,0,0])
						cylinder (h = length_of_main_tube, r = Help_main_tube_outer/2, $fn = draft ? 50 : 200);
			translate([- global_clearance/2,0,0])
				rotate ([0,90,0])
				    color([1,0,0])
						cylinder (h = length_of_main_tube + global_clearance/2, r = Help_main_tube_inner/2, $fn = draft ? 50 : 200);
		}

		//přední podvozková
		translate ([main_tube_outer_diameter/2 + main_tube_outer_diameter*2 + (coupling_width_666_1004 - main_tube_outer_diameter)/2, - main_tube_outer_diameter/2,0,])
					difference(){
							rotate ([90,0,0])
							    color([0,1,0])
									cylinder (h = length_of_undercarriage_tube_front, r = Help_main_tube_outer/2, $fn = draft ? 50 : 200);
						translate([- global_clearance/2,0,0])
							rotate ([90,0,0])
							    color([0,1,0])
									cylinder (h = length_of_undercarriage_tube_front + global_clearance/2, r = Help_main_tube_inner/2, $fn = draft ? 50 : 200);
					}

		//zadní podvozková
					difference(){
						translate([second_undercarriage_hole,- main_tube_outer_diameter- thickness_between_tubes, - length_of_undercarriage_tube_rear/2])
							    color([0,1,0])
									cylinder (h = length_of_undercarriage_tube_rear, r = Help_main_tube_outer/2, $fn = draft ? 50 : 200);
						translate([second_undercarriage_hole,- main_tube_outer_diameter - thickness_between_tubes, - length_of_undercarriage_tube_rear/2 - global_clearance/2])
							    color([0,1,0])
									cylinder (h = length_of_undercarriage_tube_rear + global_clearance, r = Help_main_tube_inner/2, $fn = draft ? 50 : 200);
					}

		//kolmá na nejdelší
					difference(){
						translate ([main_pilon_position, main_tube_outer_diameter/2 + thickness_between_tubes,0])
							rotate([-90,0,0])
							    color([1,0,0])
									cylinder (h = height_of_vertical_tube, r = Help_main_tube_outer/2, $fn = draft ? 50 : 200);
						translate ([main_pilon_position, main_tube_outer_diameter/2 + thickness_between_tubes + global_clearance/2,0])
							rotate([-90,0,0])
							    color([1,0,0])
									cylinder (h = height_of_vertical_tube + global_clearance, r = Help_main_tube_inner/2, $fn = draft ? 50 : 200);
					}
	////
	//kolečka
	//přední
	translate([10,-230,0])
		rotate([90,0,0])
			color([0.1,0.1,0.1])
				import ("../../STL/888_2103.stl");

	//zadní
	translate([8 + second_undercarriage_hole + vzdalenost_x,-210 - 19,-length_of_undercarriage_tube_rear/2 - 120 - radius_undercarriage/2 - vzdalenost_x/2 - 25])
		rotate([90,0,0])
			color([0.1,0.1,0.1])
				import ("../../STL/888_2103.stl");

	translate([8 + second_undercarriage_hole + vzdalenost_x,-210 - 19,length_of_undercarriage_tube_rear/2 + 120 + radius_undercarriage/2 + vzdalenost_x/2 + 25])
		rotate([90,0,0])
			color([0.1,0.1,0.1])
				import ("../../STL/888_2103.stl");

	//setava rotorová hlava, řemenice, listy

			translate([main_pilon_position + 15,height_of_vertical_tube + height_666_1026 + 34,0])
				rotate([-90,-90,0])
					666_2300(draft);

	//vrtule
		translate([-100,65,0])
			rotate([0,-20,90])
				import ("../../STL/APC_15x4C.stl");

	//hlavní motor
	translate([-88,66,0])
		rotate([0,90,0])
				import ("../../STL/imitation/motor_imitation.stl");


}





rotate ([90,0,0])
	666_2000(draft);





use <../666_1027.scad>
use <../666_1004.scad>
use <../666_1017.scad>
use <../888_2003.scad>
use <../666_1025.scad>
use <../666_1032.scad>
use <../888_1015.scad>
use <../888_1001.scad>
use <../666_1029.scad>
use <../888_1026.scad>
use <../888_2002.scad>
use <../888_2004.scad>
use <../888_2005.scad>
use <../888_2006.scad>
use <../666_1028.scad>
use <../666_1006.scad>
use <../888_1008.scad>
use <../666_1014.scad>
use <./../drawings/666_2300.scad>
use <../motor_imitation.scad>


use <./../lib/naca4.scad>
include <../../Parameters.scad>
