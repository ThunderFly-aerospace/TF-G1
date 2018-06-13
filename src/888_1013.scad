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
					translate([-14,-288,0])
							cube([40,296,20]);
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

		translate([100,364,-5])
			rotate([0,0,90 + uhel_y])
				translate([- global_clearance/2,10,18 - 5 + 4 - 5])
					cube([20 + global_clearance,10 + global_clearance/2 + 2,8 + 6]);



	}




//hlavní čtverec
	difference(){
		
		//hlavní kostka
		translate([0,-20,-40])
			color([0,0.5,0])
				cube([150,450,40]);

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

		translate([100 + global_clearance/2,364 + global_clearance/2,-13])
			rotate([0,0,90 + uhel_y])
				cube([20 + global_clearance,10 + global_clearance,18 + 5 + 2 + 8]);



	
		//otvor pro šroub
		translate([30,100,-Nut_height_M3])
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

		translate([30,280,-Nut_height_M3])
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
		translate([20 + 110,370,-Nut_height_M3])
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

//přípravky pro zaoblení 2 a 3
module 888_1013_B(){
	intersection(){
				888_1013();
		translate([2,-20,-100])
				cube([150,150,150]);
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
		translate([0,240,-60])
				cube([150,150,150]);
	}

	translate([133,255,-5])
		rotate([0,0,90])
			888_1013_A();

	translate([100,364,-5])
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
////////////////////////////////////////////////

//přípravek pro zaoblení 1 a 4
module 888_1013_F(){
w = radius_undercarriage - tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/4;
	difference(){
		union(){
			
			translate([11.1 -21,-40,41.1])
			rotate([0,90,0])
					color([0.8,0,0])	
						cube([151,500,71]);

			//pravá trubka//
			//druhá rovná hrana
			translate([165,0,130])
				//rotate([-90,90,0])
				rotate([-90,90 + 11,0])
					union(){
						translate([100 + 8 - 1,80 + 6 - 1,0])
							rotate([0,0,-11])
								color([0,0.8,0])
									cube([50,w*2,60]);
						translate([90 - 1.2 -0.23 ,110 - 5 + 2.5,0])
								color([0,0.8,0])
									cube([w*2, 70, 60]);
						//druhé zaoblení
						translate([100 + w/2- 0.2,100 + 10 - 2.5 - 0.5 + 4 - 0.3,0])
								color([0,0.8,0])
									cylinder(h=60,r=w, $fn = 100);
					}

			//levá trubka//
			translate([165,347,130])
				rotate([-90,90 + 11,0])
					union(){
						translate([100 + 8 - 1,80 + 6 - 1,0])
							rotate([0,0,-11])
								color([0,0.8,0])
									cube([50,w*2,60]);
						translate([90 - 1.2 -0.23 ,110 - 5 + 2.5,0])
								color([0,0.8,0])
									cube([w*2, 70, 60]);
						//druhé zaoblení
						translate([100 + w/2- 0.2,100 + 10 - 2.5 - 0.5 + 4 - 0.3,0])
								color([0,0.8,0])
									cylinder(h=60,r=w, $fn = 100);
					}
		}

	//žlábek	
	translate([-75.5,430,-6])
		rotate([0,-90,180])
			888_1008_C();

	//otvory pro šrouby
	translate([-10 + Nut_height_M3,-20,15])
		rotate([0,-90,0])
			union(){
				translate([0,0,-49 - 10 - 20])
					cylinder(h = 80, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
					cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
			}

	translate([-10 + Nut_height_M3,80,15])
		rotate([0,-90,0])
			union(){
				translate([0,0,-49 - 10 - 20])
					cylinder(h = 80, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
					cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
			}

	translate([-10 + Nut_height_M3,325,15])
		rotate([0,-90,0])
			union(){
				translate([0,0,-49 - 10 - 20])
					cylinder(h = 80, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
					cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
			}

	translate([-10 + Nut_height_M3,425,15])
		rotate([0,-90,0])
			union(){
				translate([0,0,-49 - 10 - 20])
					cylinder(h = 80, r = M3_screw_diameter/2, $fn = draft ? 50 : 100);
					cylinder(h = Nut_height_M3 + global_clearance,r = Nut_diameter_M3/2, $fn = 6);
			}
	}

}

//přípravky pro zaoblení 1 a 4
module 888_1013_G(){
	intersection(){
			888_1013_F();
	translate([-10,-40,-10])
		 	cube([150,150,150]);
	}
}

module 888_1013_H(){
	intersection(){
			888_1013_F();
	translate([-10,300,-10])
			cube([150,150,150]);
	}
}

module 888_1013_I(){
	mirror([1,0,0])
			888_1013_G();
}

module 888_1013_J(){
	mirror([1,0,0])
			888_1013_H();
}
///////////////////////////////////////////////////////////////


//ZNÁZORNĚNÍ

//888_1013();

translate([100,-30,-83.5])
	rotate([0,-90 + uhel_x,0])
		888_1008_C();
/*
translate([-70 - 400,430,-6])
	rotate([0,-90,180])
		888_1008_C();
*/
//přípravky zaoblení 2 a 3
//pravá podvozková noha
		888_1013_B();

		888_1013_C();

//levá podvozková noha
translate([-50,0,0])
		888_1013_D();

translate([-50,0,0])
		888_1013_E();


//přípravky zaoblení 1 a 4
translate([-400,0,0])
		888_1013_G();

translate([-400,0,0])
		888_1013_H();

translate([-500,0,0])
		888_1013_I();

translate([-500,0,0])
		888_1013_J();



/*
//přípravek zaoblení 1 a 4
translate([-400,0,0])
		888_1013_F();
*/

use <888_1008.scad>
use <./lib/curvedPipe.scad>

use <./lib/naca4.scad>
include <../Parameters.scad> 