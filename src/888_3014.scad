draft = true;

module 888_3014(draft){

zmenseni = 0.2;
	difference(){

				union(){
				//tvar víčka
					translate([-143 - 6,-19.8,-30]) //hrubé srovnání k počátku
							    intersection(){
							        translate ([140,75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
							            rotate([90,-87,0])
							                hollow_airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
							     
							        translate([143,19.8,30])
							            rotate([0,3,0])
							                union(){
							                    translate([-6, -(22.8 - 19.3) - 1.25 + zmenseni/2, -4.95 - 1 - 0.25 + zmenseni/2])
							                       	cube([13.5,22.8 + 4.5 - zmenseni, 32.5 + 2 + 0.5 - zmenseni]);
							               	}
							    }
				//sloupek
								difference(){
									translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
										rotate([0,90,0])
											cylinder(h = 3.55, r = Servo_screw, $fn = draft ? 50 : 100);

									translate([-5 - global_clearance/2, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
										rotate([0,90,0])
											cylinder(h = 15 + global_clearance, r = Servo_screw/2, $fn = draft ? 50 : 100);
								}
				//sloupek
								difference(){
									translate([0,0,28.5])
										translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
											rotate([0,90,0])
												cylinder(h = 5.4, r = Servo_screw, $fn = draft ? 50 : 100);

									translate([0,0,28.5])
										translate([-5 - global_clearance/2, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
											rotate([0,90,0])
												cylinder(h = 15 + global_clearance, r = Servo_screw/2, $fn = draft ? 50 : 100);
								}
				}
		//otvor pro šroub a matku ve víčku
		translate([-5 - global_clearance/2, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
			rotate([0,90,0])
				cylinder(h = 15 + global_clearance, r = Servo_screw/2, $fn = draft ? 50 : 100);
		translate([-5 - global_clearance/2 + 3.55, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
	      	rotate([0,90,0])
	    	    cylinder(h = Servo_nut_height, r = Servo_nut_diameter/2, $fn = 6);

		translate([0,0,28.5])
			translate([-5 - global_clearance/2, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
				rotate([0,90,0])
					cylinder(h = 15 + global_clearance, r = Servo_screw/2, $fn = draft ? 50 : 100);
		translate([0,0,28.5])
			translate([-5 - global_clearance/2 + 5.4, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
	          	rotate([0,90,0])
		      		cylinder(h = Servo_nut_height, r = Servo_nut_diameter/2, $fn = 6);
	}
}

rotate([-90,0,0])
888_3014();



use <888_1012.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>
