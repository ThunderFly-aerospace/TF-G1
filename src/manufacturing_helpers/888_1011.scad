draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 888_1011(){

polomer = radius_undercarriage - tube_for_undercarriage_outer_diameter/2;

	union(){
		difference(){
					color([0,0.5,0])
						cube([150,430,80]);

			translate([-5,-10,50])
				rotate([0,- uhel_x,0])
					color([0.5,0,0])
						cube([170,500,80]);		//uříznutí pro sešikmení



		//drážka pro trubku
		

			translate([110,0,-29 + 2 + 2 + 2 + 2 + 2])
				rotate([0,-90,0])
					888_1008_C();


			translate([0,230,17])	
				rotate([90,0,0])
					888_1008_C();

		}


			difference(){
				translate([-10,70,45])
					rotate([-20,0,0])
						color([0,0,0.5])
							cube([100,100,50]);
			
				translate([0,230,17])	
					rotate([90,0,0])
						888_1008_C();

			}

			difference(){
				translate([-10,230,54])
					rotate([-20,0,0])
						color([0,0,0.5])
							cube([100,100,50]);
			
				translate([0,190,472])	
					rotate([-90,0,0])
						888_1008_C();

			}

	}


}


module 888_1011_A(){
	intersection(){
				888_1011();
				cube([150,150,150]);
	}

}


module 888_1011_B(){
	intersection(){
				888_1011();
		translate([0,260,0])
				cube([150,150,150]);
	}
}

module 888_1011_C(){
	mirror([1,0,0])
			888_1011_A();
}

module 888_1011_D(){
	mirror([1,0,0])
			888_1011_B();

}




//pro 888_1008_A
translate([20,0,0])
		888_1011_A();

translate([20,0,0])
		888_1011_B();

//pro 888_1008_B
translate([-20,0,0])
		888_1011_C();

translate([-20,0,0])
		888_1011_D();


//pro znázornění
/*
translate([130,0,-20])
	rotate([0,-90,0])
		888_1008_A();
translate([-130,0,-20])
	rotate([0,90,0])
		888_1008_B();
*/


use <../888_1008.scad>
use <../lib/curvedPipe.scad>

use <../lib/naca4.scad>
include <../../parameters.scad>