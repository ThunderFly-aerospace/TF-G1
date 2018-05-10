draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 888_1011_A(){
polomer = radius_undercarriage - tube_for_undercarriage_outer_diameter/2;

difference(){
union(){
	difference(){
				cube([150,150,80]);

	translate([-5,-10,20])
		rotate([0,- uhel_x,0])
			color([0.5,0,0])
				cube([170,170,80]);
	}
	
	translate([105, radius_undercarriage/2  - tube_for_undercarriage_outer_diameter + 1.5 + 20,45])
		rotate([- uhel_x,0,uhel_y])
			union(){
				difference(){
							color([0,0.5,0])
								cube([140,100,30]);
					translate([-4,-4,-4])
								cube([polomer + 4, polomer + 4,40]);
					translate([0,- polomer*2.7- polomer*2,-1])
						rotate([0,0,20])
								cube([180,polomer*4,40]);
				}

					translate([polomer,polomer,0])
								cylinder(h = 30 + 1, r = polomer, $fn = draft ? 100 : 200 );		
			}

}


translate([0,150,-10])
		cube([200,40,80]);



//final difference
}


//final module
}

module 888_1011_B(){
polomer = radius_undercarriage - tube_for_undercarriage_outer_diameter/2;

difference(){
	union(){
		difference(){
						cube([150,150,80]);

			translate([-5,-10,20])
				rotate([0,- uhel_x,0])
					color([0.5,0,0])
						cube([170,170,80]);
		}
			translate([-69,-10,6])
				rotate([0,- uhel_x,  - (90 - uhel_y)])

			//translate([150,0,0])
				union(){
					difference(){
							color([0,0.5,0])
								cube([150,150,30]);
						translate([150 - polomer - 3, 150 - polomer - 3 , - 4])
								cube([polomer + 4, polomer + 4,40]);

					}
					translate([+ 150 - polomer,150 - polomer,0])
								cylinder(h = 30 + 1, r = polomer, $fn = draft ? 100 : 200 );		
					translate([169,-9,0])
						rotate([0,0,20])
							color([0,0.5,0])
								cube([30,150,30]);

				}
	}
translate([-1,-80,0])
		cube([150,80,150]);
translate([-80,-50,0])		
		cube([80,220,150]);
}
//final module
}



translate([-200,0,0])
		888_1011_A();

translate([-200,255,0])
		888_1011_B();


translate([-72 - 10,-27 + 20,-43])
	rotate([0,-90,0])
		888_1008_A();




use <888_1008.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>