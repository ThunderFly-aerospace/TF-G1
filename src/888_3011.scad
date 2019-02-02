module 888_3011_A (draft = true){


width = 100;
depth = 70;
height = 20;
kloub_height = height/3;
kloub_diameter = depth/3;

	union(){
		//základní kostka
		difference(){
					cube ([width, depth, height]);
			translate([width/4,depth/4,-global_clearance/2])
					union(){
								cylinder (h = height + global_clearance, r = M8_screw_diameter/2, $fn = 20);
						translate([0,0,height - M8_nut_height])		
								cylinder (h = M8_nut_height + global_clearance, r = M8_nut_diameter/2, $fn = 6);
					}
			translate([width*0.75,depth/4,-global_clearance/2])
					union(){
								cylinder (h = height + global_clearance, r = M8_screw_diameter/2, $fn = 20);
						translate([0,0,height - M8_nut_height])		
								cylinder (h = M8_nut_height + global_clearance, r = M8_nut_diameter/2, $fn = 6);
					}
		}
		//kloub
		difference(){					
			translate([width/4,depth - kloub_height - kloub_diameter/2,height])
					union(){
								cube([width/2, kloub_height + kloub_diameter/2, kloub_height*2]);
						translate([0,kloub_diameter/4 + kloub_height/2,kloub_height*2])	
							rotate([0,90,0])
								cylinder(h = width/2, r = kloub_height/2 + kloub_diameter/4,  $fn = 50);
					}
			translate([width/4 - global_clearance/2,depth - kloub_height/2 - kloub_diameter/4,height + kloub_height*2])
				rotate([0,90,0])
					cylinder(h = width + global_clearance, r = M8_screw_diameter/2, $fn = 20);
		}

	}


}

module 888_3011_B(){

width = 100;
depth = 70;
height = 20;
kloub_height = height/3;
kloub_diameter = depth/3;
tube_height = 30;
angle = 10;


			difference(){
				color([0,0.5,0])
					union(){
							cube([width, depth - kloub_diameter/4 - kloub_height/2, kloub_height + kloub_diameter/2]);
						translate([0,depth - kloub_diameter/4 - kloub_height/2,(kloub_height + kloub_diameter/2)/2])
						rotate([0,90,0])
							cylinder(h = width, r = kloub_height/2 + kloub_diameter/4, $fn = 50);
					}

				translate([width/4 - global_clearance/2,-global_clearance/2 + depth - depth/3,-global_clearance/2])
						cube([width/2 + global_clearance, depth/3 + global_clearance, height +  global_clearance]);
				translate([-global_clearance/2,depth - kloub_diameter/4 - kloub_height/2,kloub_height/2 + kloub_diameter/4])
					rotate([0,90,0])
						cylinder (h = width + global_clearance, r = M8_screw_diameter/2, $fn = 20);
			}

	translate([0,0,10])
		rotate([-angle,0,0])
			difference(){
				translate([width/2,(depth - kloub_diameter/4 - kloub_height/2)/3,kloub_height + kloub_diameter/2 - tube_height/3])
						difference(){
									cylinder(h = tube_height, r = main_tube_outer_diameter*0.7, $fn = 50);
							translate([0,0,-global_clearance/2])
									cylinder(h = tube_height + global_clearance, r = main_tube_outer_diameter/2, $fn = 50);
							translate([-main_tube_outer_diameter,0,tube_height/2])	
								rotate([0,90,0])	
									cylinder(h = main_tube_outer_diameter*2, r = M8_screw_diameter/2, $fn = 50);
						}
			}
}

translate([0,0,-20])
888_3011_A();
translate([0,0,20/3 - 20/7])
888_3011_B();

translate([0,0,-40])
mirror ([0,0,1])
888_3011_A();
translate([0,0,-40 - 20/3 + 20/7 - 20])
mirror([0,0,1])
888_3011_B();

include <../Parameters.scad>