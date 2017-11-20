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

include <../Parameters.scad>


translate([0,0,0])
	rotate ([0,90,0])
		666_1026();

translate([170+68,0,70-main_tube_outer_diameter/5 - main_tube_outer_diameter/2])
	rotate ([0,180,90])
		666_1017();

translate([main_tube_outer_diameter*2,0,0])
	rotate ([90,0,90])
		666_1004();

translate([398,0,0])
	rotate ([90,0,90])
		666_1004();

translate([170+68,0,195-main_tube_outer_diameter*2+Help_main_tube_outer/2])
		666_1026();


translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([90,0,0])
		666_1006();

translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([90,0,0])
		666_1006();

translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([-90,0,0])
		666_1006();

translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),-300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
	rotate([-90,0,0])
		666_1006();

translate ([920-80,0,0])
	rotate ([90,0,90])
		666_1028();

translate([920-80,0,0])
	rotate ([90,180,90])
		666_1028 ();

//translate([90,-184.5,-92])
//rotate ([-90,0,90])
//666_1014();

//translate([-90,-184.5,-92])
//rotate ([-90,0,90])
//666_1014();

//translate([90,184.5,-92])
//rotate ([-90,0,90])
//666_1014();

//translate([-90,184.5,-92])
//rotate ([-90,0,90])
//666_1014();


	rotate ([90,0,0])
		666_1025();
	rotate([90,0,0])	
		666_1029();

translate([180,0,10])
		666_1032();

	rotate([-90,0,0])	
		666_1027();

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
		translate ([main_pilon_position,0,Help_main_tube_outer/2])
				cylinder (h = 195, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate ([0,0,-3])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}
		//kolmá na nejdelší - pro podvozek
			//přední

	difference(){
		translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,300/2+3,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
	}
			//zadní

	difference(){
		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2,-main_tube_outer_diameter- (main_tube_outer_diameter/5)/2])
			rotate ([90,0,0])
				cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),300/2+3,-main_tube_outer_diameter - (main_tube_outer_diameter/5)/2])
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

