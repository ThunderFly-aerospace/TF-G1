draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1013(){

polomer = radius_undercarriage - tube_for_undercarriage_outer_diameter/2;

p0=[0,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2];
p1=[radius_undercarriage + 45 - tube_for_undercarriage_outer_diameter/2,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2];
p2=[radius_undercarriage + 45 + vzdalenost_y,- vzdalenost_x + 2* main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2];
p3=[radius_undercarriage + 45 + vzdalenost_y, second_undercarriage_hole - vzdalenost_x - radius_undercarriage*2 - tube_for_undercarriage_outer_diameter/2];
p4=[+ vzdalenost_y + 45, second_undercarriage_hole];
p5=[0,second_undercarriage_hole];

points=[p0,p1,p2,p3,p4,p5];

w = polomer + tube_for_undercarriage_outer_diameter/4;


//horní žlutá část
	difference(){
		rotate([0,-uhel_x,0])
			union(){
				//první rovná hrana
				translate(p2)
					translate([-2.5,-polomer,0])
						rotate([0,0,uhel_y + 0.2])
							cube([polomer*2,120,20]);
				//zaoblení
				translate(p2)
					//translate([0.4,0,0])
					translate([tube_for_undercarriage_outer_diameter/4 + 1,tube_for_undercarriage_outer_diameter/4 - 0.6,0])
							cylinder(h=20,r=w, $fn = 50);
				//druhá rovná hrana
				translate(p3)
					translate([-14,-270,0])
							cube([40,278,20]);
				//druhé zaoblení
						translate(p3)
							translate([1 + tube_for_undercarriage_outer_diameter/4,4.7 + tube_for_undercarriage_outer_diameter/2,0])
							cylinder(h=20,r=w, $fn = 50);
				//třetí rovná hrana
				translate(p3)
					translate([-4,- tube_for_undercarriage_outer_diameter/2,0])
						rotate([0,0,uhel_y + 0.2])
							cube([polomer*2,120,20]);

			}
		//odstranění přesahů přes hlavní kostku	
		translate([-50,-60,-50])
					cube([50,500,120]);

	
		translate([114,-30,-62])
			rotate([0,-90,0])
				888_1008_C();


	}




//hlavní čtverec
	difference(){
		translate([0,-20,-50])
			difference(){
				//hlavní kostka
						color([0,0.5,0])
							cube([150,400,80]);

				//uříznutí pro sešikmení
				translate([-5,-10,50])
					rotate([0,- uhel_x,0])
						color([0.5,0,0])
							cube([170,500,80]);		

			}

		//otvory pro upínky	
		translate([4 + 0.5,19 - 0.4,-10])
			rotate([0,-uhel_x,-20])
					cube([15 + 0.5,5 + 0.5,18 + 5]);
		translate([50 + 0.5,2.5 - 0.5,-1])
			rotate([0,-uhel_x,-20])
					cube([15 + 0.5,5 + 0.5,18 + 5]);

	}





}

//upínka
module 888_1013_A(){

	rotate([0,-uhel_x,-20])
		union(){
					color([0,0,0.5])
						cube([15,5,18 + 5]);
			translate([0,0,18 - 5 + 5])
					color([0,0,0.5])
						cube([15,10,5]);
		}
}


module 888_1013_B(){
	intersection(){
				888_1013();
		translate([0,-20,-60])
				cube([150,150,150]);

	}


}


		//888_1013();
	/*
translate([114,-35.5,-68])
	rotate([0,-90,0])
		888_1008_C();
*/

translate([4,19,-5])
		888_1013_A();
translate([50,2.5,4])
		888_1013_A();

		888_1013_B();

use <888_1008.scad>
use <./lib/curvedPipe.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>