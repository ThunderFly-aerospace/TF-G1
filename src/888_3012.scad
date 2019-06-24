module 888_3012_A (draft = true){

width = 90;
depth = 45;
height = 10;
angle = 30;
tube_height = 50;

	union(){
		//základní kostka
		difference(){
                translate([-width/2, -depth/2, 0]){
                    cube ([width, depth, height]);
                }
	            translate([width/2 - 5, 0 ,-global_clearance/2])
					union(){
						cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
						translate([0,0,height - M3_nut_height])
                            rotate([0, 0, 30])
                                cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 6);
					}
	            translate([-width/2 + 5,0 ,-global_clearance/2])
					union(){
						cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
						translate([0,0,height - M3_nut_height])
                            rotate([0, 0, 30])
                                cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 6);
					}
		}

        difference(){
            union(){

                translate([main_tube_outer_diameter/2.2, 0,10])
                    rotate([0,angle,0])
                        difference(){
                            translate([0, 0, -20])
                                cylinder(h = tube_height + 20, r1 = main_tube_outer_diameter*0.8, r2 = main_tube_outer_diameter*0.8, $fn = 50);
                            translate([0,0,-global_clearance/2+14])
                                cylinder(h = tube_height + global_clearance, d = main_tube_outer_diameter, $fn = 50);
                            translate([0, main_tube_outer_diameter,tube_height/2+10])
                                rotate([90,0,0])
                                    cylinder(h = main_tube_outer_diameter*2, d = M3_screw_diameter, $fn = 50);
                            translate([0, 0,tube_height/2+10])
                                rotate([90,0,0])
                                    translate([0, 0, main_tube_outer_diameter*0.8 - M3_nut_height])
                                        cylinder(h = main_tube_outer_diameter*2, d = M3_nut_diameter, $fn = 6);
                            translate([0, 0,tube_height/2+10])
                                rotate([-90,0,0])
                                    translate([0, 0, main_tube_outer_diameter*0.8 - M3_nut_height])
                                        cylinder(h = main_tube_outer_diameter*2, d = M3_nut_diameter, $fn = 6);
                        }

                translate([-main_tube_outer_diameter/2.2, 0,10])
                    rotate([0,-angle,0])
                        difference(){
                            translate([0, 0, -20])
                                cylinder(h = tube_height + 20, r1 = main_tube_outer_diameter*0.8, r2 = main_tube_outer_diameter*0.8, $fn = 50);
                            translate([0,0,-global_clearance/2+14])
                                cylinder(h = tube_height + global_clearance, d = main_tube_outer_diameter, $fn = 50);
                            translate([0, main_tube_outer_diameter,tube_height/2+10])
                                rotate([90,0,0])
                                    cylinder(h = main_tube_outer_diameter*2, d = M3_screw_diameter, $fn = 50);

                            translate([0, 0,tube_height/2+10])
                                rotate([90,0,0])
                                    translate([0, 0, main_tube_outer_diameter*0.8 - M3_nut_height])
                                        cylinder(h = main_tube_outer_diameter*2, d = M3_nut_diameter, $fn = 6);
                            translate([0, 0,tube_height/2+10])
                                rotate([-90,0,0])
                                    translate([0, 0, main_tube_outer_diameter*0.8 - M3_nut_height])
                                        cylinder(h = main_tube_outer_diameter*2, d = M3_nut_diameter, $fn = 6);
                        }
            }
            translate([-width/2, -depth/2, -40])
                cube([width, depth, 40]);
        }
	}


}

module 888_3012_B(){

width = 90;
depth = 45;
height = 10;
kloub_height = height*2.5;
tube_height = 50;
slit_width = 10;


	color([0,0.5,0])
		difference(){
            union(){
                hull(){
                    translate([-width/2, -depth/2, 0])
    			        cube([width, depth, height]);
                    translate([-width/4, -depth/4, 0])
    			        cube([width/2, depth/2, height*1.5]);
                }
                hull(){
                    translate([-width/4, -depth/4, height*1.5])
                        cube([width/2, depth/2, 0.1]);
                    translate([-width/8, 0, kloub_height])
                        rotate([0, 90, 0])
                            cylinder(h = width/4, d = depth/4);
                }
            }

            translate([-slit_width/2, -depth/4 , height*1.9])
                cube([slit_width, depth/2, 100]);

            translate([-slit_width/2, 0, kloub_height]){
                rotate([0, 90, 0]){
                    translate([0, 0, -50])
                        cylinder(d=M3_screw_diameter, h = 100, $fn=20);
                }
                rotate([0, 90, 0]){
                    translate([0, 0, slit_width*1.5])
                        cylinder(d=M3_nut_diameter, h = 100, $fn=6);
                }
                rotate([0, -90, 0]){
                    translate([0, 0, slit_width*0.5])
                        cylinder(d=M3_nut_diameter, h = 100, $fn=6);
                }

            }

            translate([-width/2 + 5,0 ,-global_clearance/2]){
    			cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
    			translate([0,0,height - M3_nut_height])
                    rotate([0, 0, 30])
                        cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 6);
    		}

            translate([width/2 - 5,0 ,-global_clearance/2]){
    			cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
    			translate([0,0,height - M3_nut_height])
                    rotate([0, 0, 30])
                        cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 6);
    		}
        }
}

rotate([0, 180, 0])
    888_3012_A();
888_3015_A();

include <../parameters.scad>
use <888_3015.scad>
