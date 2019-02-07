module 888_3015_A (draft = true){



width = 90;
depth = main_tube_outer_diameter - 4;
height = 10;
kloub_height = height*2.5;
tube_height = 50;
slit_width = 10;

height_cylinder = 35;

	union (){
		difference (){
			translate([-height_cylinder/2,0,0])
				rotate([0,90,0])
					cylinder (h = height_cylinder, r = 30, $fn = 50);

			translate([0,0,0])
				rotate([0,90,0])
					rotate_extrude(convexity = 10)
						translate([35, 0, 0])
							circle(r = main_tube_outer_diameter/2, $fn = 100);

			translate([-75,-75,-150])
					cube([150,150,150]);

			translate([-25,0,30/2])
				rotate([0,90,0])
					cylinder(h=50, r = M3_screw_diameter/2, $fn = 20);

		}

		difference(){
			translate([-width/2,-depth/2,0])
					cube([width, depth, height/2]);

			translate([-width/2 + 5,0 ,-height/2-global_clearance/2]){
					cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
			
			translate([0,0,height - M3_nut_height])
                rotate([0, 0, 30])
                   cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 20);
			}

			translate([width/2 - 5,0 , - height/2 - global_clearance/2]){
					cylinder (h = height + global_clearance, r = M3_screw_diameter/2, $fn = 20);
			
			translate([0,0,height - M3_nut_height])
                rotate([0, 0, 30])
                    cylinder (h = M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 20);
			}
		}

	}
}


module 888_3015_B(draft = true) {

width = 90;
depth = main_tube_outer_diameter - 4;
height = 10;
kloub_height = height*2.5;
tube_height = 50;
slit_width = 10;

height_cylinder = 35;

color ([0,0.5,0])
	difference(){
		translate([-height_cylinder/2 - 10,-15,+height*0.75])
				cube([height_cylinder+20,30,50]);

		translate([- height_cylinder/2 - global_clearance,-25,-global_clearance])
				cube([height_cylinder + global_clearance*2,50,main_tube_outer_diameter*1.2 + global_clearance]);

		translate([-50,0,30/2])
			rotate([0,90,0])
				cylinder(h= 100, r = M3_screw_diameter/2, $fn = 20);

		translate([height_cylinder -10 - M3_nut_height,0,30/2])
		    rotate([0, 90,0])
		       cylinder (h= M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 20);
		    			
		translate([-height_cylinder - M3_nut_height,0,30/2])
		    rotate([0, 90,0])
		        cylinder (h= M3_nut_height + global_clearance + 10, r = M3_nut_diameter/2, $fn = 20);

		translate([0,50,main_tube_outer_diameter*1.2])
		    rotate([90,0,0])
				cylinder(h = 100, r = height_cylinder/2 + global_clearance,  $fn = 50);
	}





	
}

888_3015_A();

888_3015_B();


 include <../Parameters.scad>