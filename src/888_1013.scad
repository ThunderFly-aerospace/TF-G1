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

w = polomer;

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
					translate([0.4,0,0])
							cylinder(h=20,r=w, $fn = 50);
				//druhá rovná hrana
				translate(p3)
					translate([-19.9,-277,0])
							cube([40,277,20]);
				//druhé zaoblení
						translate(p3)
							translate([0.5,2,0])
							cylinder(h=20,r=w, $fn = 50);
				//třetí rovná hrana
				translate(p3)
					translate([-4,- polomer + 2.3,0])
						rotate([0,0,uhel_y + 0.2])
							cube([polomer*2,120,20]);

			}
		translate([-50,-60,-50])
					cube([50,500,120]);

		translate([-global_clearance/2,0,8.5 - global_clearance/2])
			rotate([0,-uhel_x,-20])
				color([0,0,0.5])
					cube([20 + global_clearance,60 + global_clearance/2,5 + global_clearance]);


	}




//hlavní čtverec
	difference(){
		translate([0,-20,-50])
			difference(){
						color([0,0.5,0])
							cube([150,400,80]);

				translate([-5,-10,50])
					rotate([0,- uhel_x,0])
						color([0.5,0,0])
							cube([170,500,80]);		//uříznutí pro sešikmení

			}

	translate([114,-35.5,-68])
		rotate([0,-90,0])
			888_1008_C();
		

	}

	difference(){
		translate([0,-0.5,0])
			rotate([0,-uhel_x,-20])
				color([0,0,0.5])
					cube([25,20,8]);

		translate([0,0,8.5])
				rotate([0,-uhel_x,-20])
					translate([5 - global_clearance/2,4 - global_clearance/2,-6 - global_clearance/2])
							cube([10 + global_clearance,3 + global_clearance,15]);



	}

}

//upínka
module 888_1013_A(){

	rotate([0,-uhel_x,-20])
		union(){
				color([0.5,0,0])
					cube([20,60,4]);
			translate([5,4,-6])
				color([0.5,0,0])
					cube([10,3,6]);
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
translate([0,0,8.5])
		888_1013_A();


		888_1013_B();

use <888_1008.scad>
use <./lib/curvedPipe.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>