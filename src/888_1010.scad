                  
draft = true;

module 888_1010(){
union(){

difference(){
	union(){
		intersection(){
					hollow_airfoil(naca = 0010, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
    		translate([150 - Rudder_height + gap_width/2,- Rudder_depth/2, + gap_width/2 + (150 - Rudder_length)/2])
        		rotate([90,0,90])
                      cube([Rudder_depth + gap_width, Rudder_length - gap_width,Rudder_height + global_clearance]);
		}

    translate([150 - Rudder_height + gap_width*1.5,0, + gap_width/2 + (150 - Rudder_length)/2])
			cylinder(h = Rudder_length - gap_width, r = 2.38, $fn = draft ? 100:200);
	}


    translate([150 - Rudder_height + gap_width*1.5,0, + gap_width/2 + (150 - Rudder_length)/2])
			union(){
				difference(){
					translate([0,0,- gap_width])
							cylinder(h = Rudder_length + gap_width, r = 4, $fn = draft ? 100:200);
					translate([0,0,-gap_width])
							cylinder(h = Rudder_length + 2*gap_width, r = 2.38, $fn = draft ? 100:200);
					translate([0,-10,-2*gap_width])
						rotate([0,0,0])
							cube([Rudder_depth, 35, Rudder_length + 4*gap_width]);
				}
			}
}

		//výstupek

	translate([115,- 3.5,35])	
		difference(){
			rotate([-20,0,0])

			difference(){
				union(){
						cube([15,4*hull_wall_thickness,25]);
				translate([15/2,4*hull_wall_thickness, 25])
					rotate([90,0,0])
						cylinder(h = 4*hull_wall_thickness, r = 15/2, $fn = draft ? 50 : 100);
				}

			translate([15/2, 5*hull_wall_thickness,25])
				rotate([90,0,0])
					cylinder(h = 6*hull_wall_thickness, r = 2, $fn = draft ? 50 : 100);

			}

			translate([-10,0,-10])
				cube([50, 4.3*hull_wall_thickness,45]);
		}




//final union
}
//final module
}

//ukázka připevnění serva
module 888_1010_A(){
	difference(){
				hollow_airfoil(naca = 0010, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
		
		//otvor pro servo
		translate([26.5,0,60 - 35/2 - 4])
			rotate([90,0,90])
				cube([2 + 6,22.8 + 2 + 0.5, 32.5 + 2 + 0.5]);
			
	}

	translate([32 + 0.25,0,60])
		rotate([-90,0,-90])
			union(){
				888_1012_A();
				888_1012_B();
				888_1012_C();
			}

}


//888_1010();


translate([0,0,0])
		888_1010_A();


/*
//servo s upevněním
translate([32 + 0.25,0,60])
	rotate([-90,0,-90])
	union(){
		888_1012_A();
		888_1012_B();
		888_1012_C();
}
*/
use <888_1012.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>

