                  
draft = true;

module 888_1010(){


difference(){
	union(){
		intersection(){
					hollow_airfoil(naca = 0005, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
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

//final module
}

888_1010();

use <./lib/naca4.scad>
include <../Parameters.scad>

