/*
// Nastavení zobrazení
$vpr = [73, 0, 12];
$vpt = [442, 80, -15];
$vpd = 1580;
*/
draft = true;

////
	rotate ([0,90,0])
		666_1026(draft);

translate([main_pilon_position,0,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes])
		666_1026(draft);

////
translate([main_pilon_position,0,70 - coupling_wall_thickness - main_tube_outer_diameter/2])
	rotate ([0,180,90])
		666_1017(draft);

////
translate([main_tube_outer_diameter*2,0,0])
	rotate([90,0,90])
		666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);
	
translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness,0,0])
		rotate([90,0,90])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);

////
rotate([90,0,0])
	union(){
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
	}

////
translate ([length_of_main_tube - 80,0,0])
	rotate ([90,0,90])
		666_1028(draft);

translate([length_of_main_tube - 80,0,0])
	rotate ([90,180,90])
		666_1028(draft);

/*		
////
translate([90,-184.5,-92])
	rotate ([-90,0,90])
		666_1014(draft);

translate([-90,-184.5,-92])
	rotate ([-90,0,90])
		666_1014(draft);

translate([90,184.5,-92])
	rotate ([-90,0,90])
		666_1014(draft);

translate([-90,184.5,-92])
	rotate ([-90,0,90])
		666_1014(draft);
*/
////

rotate ([90,0,0])
	666_1025(draft);

////	
rotate([90,0,0])	
	666_1029(draft);


////
translate([cover_pilon_position,0,0])
		666_1032(draft);

////
	rotate([90,0,0])	
		666_1027(draft);

////
	rotate([90,0,0])
		union(){
			translate([main_pilon_position - main_tube_outer_diameter/2 - coupling_wall_thickness,height_of_vertical_tube + coupling_wall_thickness + main_tube_outer_diameter/2,0])
				rotate([90,90,0])
					666_1232();
			translate([main_pilon_position + main_tube_outer_diameter/2 + coupling_wall_thickness,height_of_vertical_tube + coupling_wall_thickness + main_tube_outer_diameter/2,0])
				rotate([90,-90,0])
					666_1232();
		}
////

translate([main_pilon_position, 0,height_of_vertical_tube + 25])
	rotate([90,0,0])
		union(){
				rotate([90,20,180])
					333_1037();
			translate([-10, + 18,0])
				rotate([90,70,0])
					333_1037();
		}


//hlavní trubky

	//nejdelší
	difference (){
		translate([0,0,0])
			rotate ([0,90,0])
				cylinder (h = length_of_main_tube, r = Help_main_tube_outer/2, $fn = 200);

		translate([- global_clearance/2,0,0])
			rotate([0,90,0])
				cylinder (h = length_of_main_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);
	}

	//kolmá na nejdelší
	difference(){
		translate ([main_pilon_position,0,main_tube_outer_diameter/2 + thickness_between_tubes])
				cylinder (h = height_of_vertical_tube, r = Help_main_tube_outer/2, $fn = 200);

		translate ([main_pilon_position,0, global_clearance/2 + main_tube_outer_diameter/2 + thickness_between_tubes])
				cylinder (h = height_of_vertical_tube + global_clearance/2, r = Help_main_tube_inner/2, $fn = 200);
	}
	

	//pro podvozek
			//přední

	difference(){
		translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,length_of_undercarriage_tube/2,- Help_main_tube_outer - thickness_between_tubes])
			rotate ([90,0,0])
				cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);

		translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,length_of_undercarriage_tube/2 + global_clearance/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = length_of_undercarriage_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);
	}
			//zadní

	difference(){
		translate([second_undercarriage_hole,length_of_undercarriage_tube/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = length_of_undercarriage_tube, r = Help_main_tube_outer/2, $fn = 200);

		translate([ second_undercarriage_hole,length_of_undercarriage_tube/2 + global_clearance/2,-main_tube_outer_diameter - (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = length_of_undercarriage_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);
	}


use <666_1004.scad>
use <666_1006.scad>
use <666_1014.scad>
use <666_1017.scad>
use <666_1026.scad>
use <666_1028.scad>
use <666_1025.scad>
use <666_1029.scad>
use <666_1032.scad>
use <666_1027.scad>
use <333_1037.scad>
use <666_1232.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>