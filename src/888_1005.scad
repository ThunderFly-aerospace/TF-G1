			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1005(draft){
	translate([main_tube_outer_diameter*2,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);
	
	translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);



		666_1027(draft);

translate([0,0,0])
		666_1029(draft);

	rotate([90,0,90])
		666_1026(draft);

		//666_1025(draft);

translate([cover_pilon_position - 2*hull_wall_thickness,0,0])
	rotate([-90,0,0])
		666_1032(draft);

translate([main_pilon_position,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
	rotate([-90,0,0])
			666_1026(draft);

//držák akumulátor
/*
        translate([move_of_accumulator ,main_tube_outer_diameter/2 + coupling_wall_thickness,height_of_accumulator])
	rotate([-90,0,0])
		888_1001();
*/
translate([main_pilon_position,70 - coupling_wall_thickness - main_tube_outer_diameter/2,0])
	rotate([0,-90,90])
		666_1017();
//hlavní trubky

		//nejdelší

			rotate ([0,90,0])
				cylinder (h = 920, r = Help_main_tube_outer/2, $fn = 200);


		//kolmá na nejdelší
		translate ([main_pilon_position,main_tube_outer_diameter/2 + coupling_wall_thickness,0])
			rotate([-90,0,0])
				cylinder (h = height_of_vertical_tube, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

	
		//kolmá na nejdelší - pro podvozek
			//přední

			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,-150])
				cylinder (h = 300, r = Help_main_tube_outer/2,$fn = 200);

			//zadní

		translate([second_undercarriage_hole - coupling_wall_thickness,- Help_main_tube_outer - thickness_between_tubes, -150])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

}


module 888_1005_pomoc(draft){
	intersection(){
				888_1005();
		translate([0,-hull_y_size, - hull_z_size])
				cube([main_pilon_position,2*hull_y_size,2*hull_z_size]);
	}
}

888_1005(draft);
//888_1005_pomoc(draft);


use <666_1004.scad>
use <666_1026.scad>
use <666_1027.scad>
use <666_1029.scad>
use <666_1025.scad>
use <666_1032.scad>
use <888_1001.scad>
use <666_1017.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>

