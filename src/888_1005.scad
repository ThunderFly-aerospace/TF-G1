			       translate([main_tube_outer_diameter*2,0,0])
		rotate([0,90,0])
			 


			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);

			888_1006();

			//888_1004();

//hlavní trubky

		//nejdelší

			rotate ([0,90,0])
				cylinder (h = 920, r = Help_main_tube_outer/2, $fn = 200);


		//kolmá na nejdelší
		translate ([main_pilon_position,0,0])
		rotate([-90,0,0])
				cylinder (h = 195, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

	
		//kolmá na nejdelší - pro podvozek
			//přední

			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,0])
				cylinder (h = 300, r = Help_main_tube_outer/2,$fn = 200);

			//zadní
/*
	difference(){
		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2+3,-main_tube_outer_diameter - (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}

*/
use <666_1004.scad>
use <888_1006.scad>
use <888_1004.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>

