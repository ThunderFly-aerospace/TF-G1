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
	union(){
	difference(){
		//rotate([0,-uhel_x,0])
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
		//translate([-48,-60,-50])
					//cube([50,500,120]);
		}
		
		difference(){
			union(){

				difference(){
					translate([1,150 - 20,-25 + tube_for_undercarriage_outer_diameter*0.75])
							rotate([90,0,0])
								cylinder(h=150,r=w, $fn = 50);
					translate([2,-20,-50])
							cube([20,150,70]);

					translate([-16 + 7,23 -global_clearance/2,-50 - 1 - global_clearance ])
						rotate([0,uhel_x - 90,0])
								cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);


				}
				difference(){
					translate([-polomer*2 - 1,polomer/4 + 10 - 35,-100 - polomer + 7])
						rotate([0,uhel_x,0])
								cube([35,150,100]);

					translate([-16 + 7,23 -global_clearance/2,-50 - 1 - global_clearance ])
						rotate([0,uhel_x - 90,0])
								cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

				}

				difference(){
					translate([-40 - 10 - 10,47.5 + 7,-80])
						rotate([0,0,-20])
								cube([35 + 20,40,100]);
					translate([-16,23,-50])
						rotate([0,uhel_x - 90,0])
							translate([- global_clearance/2,10,18 - 5 + 4 - 5])
								cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);
				}
			
			}
				
			translate([-150,0,-150 - 58])
					cube([150,150,150]);

		}
}

		translate([100,-30,-83.5])
		//translate([114,-30,-62])
			rotate([0,-90 + uhel_x,0])
				888_1008_C();

		//zobáček
		translate([4,14,-5])
			rotate([0,0,-20])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);

		translate([60,-6,-5])
			rotate([0,0,-20])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);

		translate([133,30,-5])
			rotate([0,0,90])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);
		
		translate([133,100,-5])
			rotate([0,0,90])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);
		
		translate([133,255,-5])
			rotate([0,0,90])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);

		translate([100,344,-5])
			rotate([0,0,90 + uhel_y])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);

		translate([30,369,-5])
			rotate([0,0,90 + uhel_y])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);


	}




//hlavní čtverec
	difference(){
		
		//hlavní kostka
		translate([0,-20,-40 - 40])
			color([0,0.5,0])
				cube([150,400,40 + 40]);

		//otvory pro upínky	
		translate([4 - global_clearance/2,14 - global_clearance/2,-13])
			rotate([0,0,-20])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);


		translate([60 - global_clearance/2,-6 - global_clearance/2,-13])
			rotate([0,0,-20])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

		translate([133 + global_clearance/2,30 - global_clearance/2,-13])
			rotate([0,0,90])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

		translate([133 + global_clearance/2,100 - global_clearance/2,-13])
			rotate([0,0,90])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

		translate([133 + global_clearance/2,255 - global_clearance/2,-13])
			rotate([0,0,90])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

		translate([100 + global_clearance/2,344 + global_clearance/2,-13])
			rotate([0,0,90 + uhel_y])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);


		translate([30 + global_clearance/2,369 + global_clearance/2,-13])
			rotate([0,0,90 + uhel_y])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);

	
		//otvor pro šroub
		translate([10,110,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}
		translate([10,0,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}	
		translate([20 + 120,0,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}
		translate([20 + 120,110,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}

		translate([40,370,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}
		translate([10,250,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}	
		translate([20 + 120,250,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}
		translate([20 + 120,360,-Nut_height_M3])
				union(){
					translate([0,0,-49])
						cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
						cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
				}


		//odstranění zbytků
		translate([-48,-60,-100])
				cube([50,500,120]);

	}		





}

//upínka
module 888_1013_A(){

	//rotate([0,0,-20])
		union(){
					color([0,0,0.5])
						cube([20,10,18 + 5 + 2]);
			translate([0,10,18 - 5 + 4])
					color([0,0,0.5])
						cube([20,10 + 2,8]);
		}
}


module 888_1013_B(){

difference(){
	intersection(){
				888_1013();
		translate([2,-20,-100])
				cube([150,150,150]);
	}
//otvory pro šrouby pro připevnění 888_1013_F
		translate([-25 + Nut_height_M3,10,-30])
			rotate([0,90,0])
				union(){
						cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
				translate([0,0,-Nut_height_M3 - global_clearance])
						cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
				}

		translate([-25 -10 + Nut_height_M3*1.5,60,-15])
			rotate([0,90,0])
				union(){
						cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
				translate([0,0,-Nut_height_M3 - global_clearance])
						cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
				}

		translate([-25 - 10+ Nut_height_M3 * 1.5,60,-40])
			rotate([0,90,0])
				union(){
						cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
				translate([0,0,-Nut_height_M3 - global_clearance])
						cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
				}


}
//upínky

	translate([4,14,-5])
		rotate([0,0,-20])
			888_1013_A();

	translate([60,-6,-5])
		rotate([0,0,-20])
			888_1013_A();

	translate([133,30,-5])
		rotate([0,0,90])
			888_1013_A();

	translate([133,100,-5])
		rotate([0,0,90])
			888_1013_A();

}

module 888_1013_C(){

	intersection(){
				888_1013();
		translate([0,230,-60])
				cube([150,150,150]);
	}

	translate([133,255,-5])
		rotate([0,0,90])
			888_1013_A();

	translate([100,344,-5])
		rotate([0,0,90 + uhel_y])
			888_1013_A();

	translate([30,369,-5])
		rotate([0,0,90 + uhel_y])
			888_1013_A();

}

module 888_1013_D(){
		mirror([1,0,0])
888_1013_B();
}

module 888_1013_E(){
	mirror([1,0,0])
888_1013_C();

}


module 888_1013_F(){

difference(){
	intersection(){
			888_1013();
		translate([-35 + 2,-75,-150 + 20 + 10 + 30 + 30 + 2])
			cube([35,150,150 - 10 - 30 - 30 - 2]);
	}
	translate([-25 + Nut_height_M3,10,-30])
		rotate([0,90,0])
			union(){
					cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,-Nut_height_M3 - global_clearance])
					cylinder(h = Nut_height_M3 + 2*global_clearance, r = Nut_diameter_M3/2, $fn = 6);
			}


	translate([-25 -10 + Nut_height_M3*1.5,60,-15])
		rotate([0,90,0])
			union(){
					cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,-Nut_height_M3 + global_clearance])
					cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
			}

	translate([-25 - 10+ Nut_height_M3 * 1.5,60,-40])
		rotate([0,90,0])
			union(){
					cylinder(h = 200, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,-Nut_height_M3 + global_clearance])
					cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
			}


}
	translate([-16,23,-50])
		rotate([0,uhel_x - 90,0])
			888_1013_A();



}
		//888_1013();
	/*
translate([114,-35.5,-68])
	rotate([0,-90,0])
		888_1008_C();
*/


//přípravky pravá podvozková noha
		888_1013_B();

		888_1013_C();
/*
//přípravky levá podvozková noha
translate([-50,0,0])
		888_1013_D();

translate([-50,0,0])
		888_1013_E();
*/

translate([-100,0,0])
		888_1013_F();

use <888_1008.scad>
use <./lib/curvedPipe.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>