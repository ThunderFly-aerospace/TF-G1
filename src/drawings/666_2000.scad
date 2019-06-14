			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 666_2000(draft){

	////
		translate([-hull_wall_thickness,0,0])
			color([0,0,0.8])
				666_1025(draft);

		translate([-hull_wall_thickness/2,0,0])
			color([0,0,0.8])
				666_1029(draft);

	////
	666_1027(draft);

	////
		//spojka přední část
		translate([main_tube_outer_diameter*2,0,0])
			rotate([0,90,0])
				888_2003(coupling_wall_thickness, thickness_between_tubes, draft);

	//spojka zadní část
		translate([second_undercarriage_hole - coupling_width_666_1004/2,0,0])
			rotate([0,90,0])
					666_1004(coupling_wall_thickness, thickness_between_tubes, draft);
	////
	//spojka prostřední část
		translate([main_pilon_position,70 - coupling_wall_thickness - main_tube_outer_diameter/2,0])
			rotate([0,-90,90])
					666_1017(draft);

	////
		translate([cover_pilon_position - hull_wall_thickness,0,0])
			rotate([-90,0,0])
					666_1032(draft);





	////
	//akumulátory s držáky
		translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - 2*sink_of_accumulator,height_of_accumulator*0.5])
		   	color([0.8,0,0.8])
		   		cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator - sink_of_accumulator]);


		translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - 2*sink_of_accumulator,-height_of_accumulator*1.5])
		   	color([0.8,0,0.8])
		   		cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator - sink_of_accumulator]);

		translate([move_of_accumulator,main_tube_outer_diameter/2,-height_of_accumulator])
			rotate([-90,0,0])
				color([0,0.8,0.8])
					888_1001(draft);

		translate([move_of_accumulator,main_tube_outer_diameter/2,height_of_accumulator])
			rotate([-90,0,0])
				color([0,0.8,0.8])
					888_1001(draft);

	////
		translate([height_666_1026,0,0])
			rotate([-90,0,90])
				color([0.4,0,0.8])
					888_1026(draft);
					

	////
		translate([main_tube_outer_diameter/2 + main_tube_outer_diameter*2 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2,0])
		    rotate([0,90,-90])
		        color([0,1,1])
		            888_2002(draft);
		translate([main_tube_outer_diameter*2.5 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2 + 25.8,0])
		    rotate([-90,0,0])
		        color([0,0.5,0.5])
		            888_2005(draft);
		translate([main_tube_outer_diameter*2.5 + (coupling_width_666_1004 - main_tube_outer_diameter)/2,-length_of_undercarriage_tube_front - main_tube_outer_diameter/2 + 25.8,0])
		    rotate([90,0,180])
		      	color([0,0.5,0.5])
		            888_2006(draft);

	////
		translate([length_of_main_tube - 80 + global_clearance,0,0])
			rotate([0,90,0])
					666_1028(draft);

		translate([length_of_main_tube - 80 + global_clearance,0,0])
			rotate([0,-90,180])
					666_1028(draft);

	////
		translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube_rear/2 - global_clearance/2])
				color([0,0,0.8])
					666_1006(draft = draft);

		translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube_rear/2 + global_clearance/2])
			rotate([180,0,0])
				color([0,0,0.8])
					666_1006(draft = draft);

	////
	//podvozkové trubky
		translate([second_undercarriage_hole,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,length_of_undercarriage_tube_rear/2 - 120])
			rotate([-90,-90,0])
				color([1,0,0])
					888_1008_E();


		translate([second_undercarriage_hole,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,-length_of_undercarriage_tube_rear/2 + 120])
			rotate([-90,-90,0])
				color([1,0,0])
					888_1008_F();

	////
	//úchytky na podvozková kolečka
		translate([second_undercarriage_hole + vzdalenost_x,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,-length_of_undercarriage_tube_rear/2 - 120 - radius_undercarriage/2 - vzdalenost_x/2])
			rotate([0,90,0])
					666_1014(draft);

		translate([second_undercarriage_hole + vzdalenost_x,- 200 - height_666_1004 + main_tube_outer_diameter/2 - 2,length_of_undercarriage_tube_rear/2 + 120 + radius_undercarriage/2 +vzdalenost_x/2])
			rotate([0,90,0])
					666_1014(draft);

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
		color([0.1,0.1,0.1])
			translate([10,-210 - 19,0])
				rotate_extrude (convexity = 10, $fn = draft ? 50 : 100)
					translate ([26,0,0])
						circle (r = 13, $fn = draft ? 50 : 100);

	//zadní
		color([0.1,0.1,0.1])
			translate([8 + second_undercarriage_hole + vzdalenost_x,-210 - 19,-length_of_undercarriage_tube_rear/2 - 120 - radius_undercarriage/2 - vzdalenost_x/2 - 15])
				rotate_extrude (convexity = 10, $fn = draft ? 50 : 100)
					translate ([26,0,0])
						circle (r = 13, $fn = draft ? 50 : 100);

		color([0.1,0.1,0.1])
			translate([8 + second_undercarriage_hole + vzdalenost_x,-210 - 19,length_of_undercarriage_tube_rear/2 + 120 + radius_undercarriage/2 + vzdalenost_x/2 + 15])
				rotate_extrude (convexity = 10, $fn = draft ? 50 : 100)
					translate ([26,0,0])
						circle (r = 13, $fn = draft ? 50 : 100);

	//setava rotorové listy

			translate([main_pilon_position + 15,height_of_vertical_tube + height_666_1026 + 25,0])
				rotate([-90,-90,0])	
					666_2300(draft);

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


use <./../lib/naca4.scad>
include <../../Parameters.scad>

