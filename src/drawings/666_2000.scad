			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1005(draft){

////
	translate([main_tube_outer_diameter*2,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);
	
	translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness,0,0])
		rotate([0,90,0])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);

////
		666_1027(draft);

////		
		666_1025(draft);

////
translate([0,0,0])
		666_1029(draft);

////
translate([cover_pilon_position - 2*hull_wall_thickness,0,0])
	rotate([-90,0,0])
		666_1032(draft);

////
	rotate([90,0,90])
		666_1026(draft);
/*
translate([main_pilon_position,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes,0])
	rotate([-90,0,0])
			666_1026(draft);
*/

//držák akumulátor
/*
        translate([move_of_accumulator ,main_tube_outer_diameter/2 + coupling_wall_thickness,height_of_accumulator])
	rotate([-90,0,0])
		888_1001();
*/

////
translate([main_pilon_position,70 - coupling_wall_thickness - main_tube_outer_diameter/2,0])
	rotate([0,-90,90])
		666_1017();


////
translate([length_of_main_tube - 80 + global_clearance,0,0])
	rotate([0,90,0])
	{
		666_1028();
		translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
    		rotate([90,-87 ,0])
        		666_1028_rudder(draft);
	}

translate([length_of_main_tube - 80 + global_clearance,0,0])
	rotate([0,-90,180])
	{
		666_1028();
		translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
    		rotate([90,-87 ,0])
        		666_1028_rudder(draft);

	}

////
translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,- length_of_undercarriage_tube/2])
		666_1006();

translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,length_of_undercarriage_tube/2])
	rotate([180,0,0])	
		666_1006();

translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2])
		666_1006();

translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2])
	rotate([180,0,0])	
		666_1006();

/*
////
translate([main_pilon_position - main_tube_outer_diameter/2 - coupling_wall_thickness,height_of_vertical_tube + coupling_wall_thickness + main_tube_outer_diameter/2,0])
	rotate([90,90,0])
		666_1232();
translate([main_pilon_position + main_tube_outer_diameter/2 + coupling_wall_thickness,height_of_vertical_tube + coupling_wall_thickness + main_tube_outer_diameter/2,0])
	rotate([90,-90,0])
		666_1232();

////

translate([main_pilon_position, height_of_vertical_tube + 25,0])
	union(){
			rotate([90,20,180])
				333_1037();

		translate([-10, + 18,0])
			rotate([90,70,0])
				333_1037();
	}
*/


//// podvozek
translate([0, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 - 45])
	rotate([-90,-90,0])
		888_1008_A();

translate([0, - 131 - Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2 + 45])
	rotate([-90,-90,0])
		888_1008_B();


//// úchytky na kolečka
union(){
translate([2*main_tube_outer_diameter + coupling_wall_thickness, - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
	rotate([0,90,0])
		666_1014();

translate([- tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage + second_undercarriage_hole - vzdalenost_x - radius_undercarriage , - 131 - Help_main_tube_outer - thickness_between_tubes, length_of_undercarriage_tube/2 + vzdalenost_y + radius_undercarriage])
	rotate([0,90,0])
		666_1014();
}

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
		difference(){
			rotate ([0,90,0])
			    color([1,0,0])

				cylinder (h = length_of_main_tube, r = Help_main_tube_outer/2, $fn = 200);
		translate([- global_clearance/2,0,0])
			rotate ([0,90,0])
			    color([1,0,0])
				cylinder (h = length_of_main_tube + global_clearance/2, r = Help_main_tube_inner/2, $fn = 200);

		}


		//kolmá na nejdelší
		difference(){
		translate ([main_pilon_position, main_tube_outer_diameter/2 + thickness_between_tubes,0])
			rotate([-90,0,0])
			    color([1,0,0])
				cylinder (h = height_of_vertical_tube, r = Help_main_tube_outer/2, $fn = 200);

		translate ([main_pilon_position, main_tube_outer_diameter/2 + thickness_between_tubes + global_clearance/2,0])
			rotate([-90,0,0])
			    color([1,0,0])
				cylinder (h = height_of_vertical_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);

		//otvory pro připevnění dílu 666_1032
		translate([main_pilon_position,cover_pilon_division[1] - cover_pilon_division[1]/4,- hull_z_size/2 ])
                cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
 		translate([main_pilon_position,cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75,- hull_z_size/2 ])
                cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
		}
	
		//kolmá na nejdelší - pro podvozek
			//přední
			
		difference(){
			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,- length_of_undercarriage_tube/2])
			    color([1,0,0])
					cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);
			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,- Help_main_tube_outer - thickness_between_tubes,- length_of_undercarriage_tube/2 - global_clearance/2])
			    color([1,0,0])
					cylinder (h = length_of_undercarriage_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);
		}	

			//zadní
		difference(){
			translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2])
			    color([1,0,0])
					cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);
			translate([second_undercarriage_hole,- Help_main_tube_outer - thickness_between_tubes, - length_of_undercarriage_tube/2 - global_clearance/2])
			    color([1,0,0])
					cylinder (h = length_of_undercarriage_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);
		}


//final module
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
use <666_1028.scad>
use <666_1006.scad>
use <333_1037.scad>
use <666_1232.scad>
use <888_1008.scad>
use <666_1014.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>

