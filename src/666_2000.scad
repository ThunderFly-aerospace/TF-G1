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
use <666_1018.scad>

include <../Parameters.scad>
/*
// Nastavení zobrazení
$vpr = [73, 0, 12];
$vpt = [442, 80, -15];
$vpd = 1580;
*/
draft = true;

translate([0,0,0])
	rotate ([0,90,0])
		666_1026(draft);

translate([170+68,0,70-main_tube_outer_diameter/5 - main_tube_outer_diameter/2])
	rotate ([0,180,90])
		666_1017(draft);
/*
translate([main_tube_outer_diameter*2,0,0])
	rotate ([90,0,90])
		666_1004(draft);

translate([398,0,0])
	rotate ([90,0,90])

		666_1004(draft);
*/
			       translate([main_tube_outer_diameter*2,0,0])
		rotate([90,0,90])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);
	
	translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness,0,0])
		rotate([90,0,90])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true);

translate([170+68,0,195-main_tube_outer_diameter*2+Help_main_tube_outer/2])
		666_1026(draft);


translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([90,0,0])
		666_1006(draft);

translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([90,0,0])
		666_1006(draft);

translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([-90,0,0])
		666_1006(draft);

translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),-300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([-90,0,0])
		666_1006(draft);

translate ([920-80,0,0])
	rotate ([90,0,90])
		666_1028(draft);

translate([920-80,0,0])
	rotate ([90,180,90])
		666_1028(draft);

		

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


rotate ([90,0,0])
	666_1025(draft);
	
rotate([90,0,0])	
	666_1029(draft);



translate([180,0,10])
		666_1032(draft);

	rotate([90,0,0])	
		666_1027(draft);

translate([190,0,-10])
	rotate([0,270,0])
		666_1018(draft);

//hlavní trubky

		//nejdelší
	difference (){

		translate([0,0,0])
			rotate ([0,90,0])
				cylinder (h = 920, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([-3,0,0])
			rotate([0,90,0])
				cylinder (h = 926, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}

		//kolmá na nejdelší
	difference(){
		translate ([main_pilon_position,0,main_tube_outer_diameter/2 + coupling_wall_thickness])
				%cylinder (h = height_of_vertical_tube, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate ([0,0,-3])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}
		//kolmá na nejdelší - pro podvozek
			//přední

	difference(){
		//translate([0,0,-main_tube_outer_diameter - thickness_between_tubes/2])
			translate([Help_main_tube_outer/2 + coupling_wall_thickness + 2*main_tube_outer_diameter,150,- Help_main_tube_outer - thickness_between_tubes])
			rotate ([90,0,0])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,300/2+3,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}
			//zadní

	difference(){
		translate([second_undercarriage_hole,300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([- second_undercarriage_hole,300/2+3,-main_tube_outer_diameter - (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}

//trubky pro podvozek
		//zadní
		//translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),-300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			//rotate ([90,0,0])
				//cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([150,-185,-27])
//rotate ([180,0,0])
//cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

		//dlouhá
//translate ([152,-183,-92])
//rotate ([180,90,0])
//cylinder (h = 300, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([-150,-150,-27])
//rotate ([90,0,0])
//cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([-150,-185,-27])
//rotate ([180,0,0])
//cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);



//translate ([150,190,-27])
//rotate ([90,0,0])
//cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([150,185,-27])
//rotate ([180,0,0])
//cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);


//translate ([-150,190,-27])
//rotate ([90,0,0])
//cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([-150,185,-27])
//rotate ([180,0,0])
//cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

//translate ([152,183,-92])
//rotate ([180,90,0])
//cylinder (h = 300, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

