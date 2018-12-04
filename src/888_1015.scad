draft = true;



    plate_angle_x = 10;
    plate_angle_y = 10;
    plate_angle_res = 1;
    plate_size_y = 50;
    plate_size_x = 100;

    plate_bearing_center_distance = 7+2;

module efsm_12(){
    translate([-20, -20, 0])
        cube([40, 40, 7]);

    cylinder(h = 10, d = 25);

    translate([0,0,10])
        cylinder(h = 2, d1 = 25, d2 = 20);

    translate([0,0,7])
        sphere(r=7);
}


module 888_1015_platesape(angle, size, distance){
    plate_size_x = size[0];
    plate_size_y = size[1];
    plate_angle_x = angle[0];
    plate_angle_y = angle[1];


    union(){
        for (y=[-plate_angle_y, 0, plate_angle_y]) {
            for (x=[-plate_angle_x, 0, plate_angle_x]) {
                rotate([x, y, 0])
                    translate([-plate_size_x / 2, -plate_size_y / 2, distance])
                        cube([plate_size_x, plate_size_y, 30]);
            }
        }
    }

    /*
        union(){
            for (y=[-plate_angle_y : plate_angle_res : plate_angle_y]) {
                for (x=[-plate_angle_x : plate_angle_res : plate_angle_x]) {
                rotate([x, y, 0])
                    translate([-plate_size_x / 2, -plate_size_y / 2, distance])
                        cube([plate_size_x, plate_size_y, 20]);
                }
            }
        }*/

}



module 888_1015(draft){

	plate_thickness = 1.5;

	width = 70;
	depth = 2*plate_thickness + coupling_depth_666_1026;
	height = 68.5 + 10;

	rake_angle = 9;		//úhel horního zkosení

	servo_width = 21;	//šřka otvoru pro servo
	servo_height = 42;	//výška otvoru pro servo

	//příruba
	flange_width = 40;						//h
	flange_depth = flange_width;
	flange_height = 4.5;
	flange_length_beteween_screws = 28;		//m
	flange_screw_diameter = 5.3 + 1;		//N
	flange_main_hole = 25 + 1;				//d1

	//otvor pro klíč
	key_width = flange_width;
	key_depth = flange_depth;
	key_height = M5_nut_height;

	M5_screw_length = 19;
	M2_5_screw_length = 10;
	M2_5_pocket_depth = 5;

	difference (){
		//základní kostka
        union(){
            translate([-width/2,-depth/2,0])
                cube ([width, depth, height+10]);
            hull(){
                translate([-width/2, -depth/2, 0])
                    cube([width/2 + 10, depth, 1]);
                translate([-width/2, -depth/2-15, height])
                    cube([width/2+10, depth+30, 20]);
            }
        }
		//zkosení
		/* translate([-width/2 + 10,-depth/2-global_clearance,height])
			rotate([0,rake_angle,0])
				cube([width + 2*global_clearance, depth + 2*global_clearance,20]); */

		//otvory z dílu 666_1026
		translate([17.5 - width/2,0,0])
			union(){
			//vertikální trubka
				translate([0,0,-global_clearance])
					cylinder(h = height_666_1026 + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
			//otvory pro upevnění vertikální trubky
				translate([0,depth/2 + global_clearance/2,7.5])
			        rotate([90,0,0])
			            cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
		        translate([0,depth/2 + global_clearance/2,42.5])
			        rotate([90,0,0])
			            cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

    			//otvory pro upevnění vertikální trubky
    				translate([0, depth/2 - M4_screw_head_height - global_clearance/2, 7.5])
    			        rotate([-90, 0, 0])
    			            cylinder(h = 100, d = M4_nut_diameter, $fn = draft ? 10 : 20);
    				translate([0, -depth/2 + M4_screw_head_height + global_clearance/2, 7.5])
    			        rotate([90, 0, 0])
	                          cylinder(h = 100, d = M4_nut_diameter, $fn = 6);
                    translate([0, depth/2 - M4_screw_head_height - global_clearance/2, 42.5])
    			        rotate([-90, 0, 0])
    			            cylinder(h = 100, d = M4_nut_diameter, $fn = draft ? 10 : 20);
    				translate([0, -depth/2 + M4_screw_head_height + global_clearance/2, 42.5])
    			        rotate([90, 0, 0])
    			            cylinder(h = 100, d = M4_nut_diameter, $fn = 6);

			}
		//otvory pro serva
		translate([width/2 - servo_width - 4,-depth/2 - global_clearance/2,7.5])
			cube([servo_width, depth + global_clearance,servo_height]);
		//otvor pro kabely od serv
		translate([width/2 - servo_width + servo_width/4- 4,-20,-global_clearance])
			cube([servo_width/2,40,20]);
		//zkosení otvoru pro kabely od servo
		translate([width/2 - servo_width + servo_width/4- 4,-3,0])
			rotate([70,0,0])
				cube([servo_width/2,20,40]);

		translate([width/2 - servo_width + servo_width/4- 4,-4.5,18.5])
			rotate([-70,0,0])
				cube([servo_width/2,20,40]);

		//otvory pro šrouby pro připevnění serva
		translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4])
			rotate([0,-90,90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4])
			rotate([0,-90,90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}

		translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
			rotate([0,-90, 90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
			rotate([0,-90, 90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([0,0,48 + 9])
			rotate([180,0,0])
				union(){
					translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4])
						rotate([0,90,-90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
					translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4])
						rotate([0,90,-90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}

					translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
						rotate([0, 90, -90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
					translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
						rotate([0, 90, -90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
				}

		//příruba
		translate([- global_clearance - width/2 + 10,-flange_depth/2 - global_clearance, height - flange_height])
			rotate([0,rake_angle,0])
				union(){
				//základní tvar
					cube([flange_width + 2*global_clearance, flange_depth + 2*global_clearance, flange_height + global_clearance + 20]);
				//hlavní otvor
					translate([flange_width/2, flange_depth/2,- 15])
						cylinder(h = 30, r = flange_main_hole/2, $fn = draft ? 50 : 100);
				//otvor pro šrouby
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2,-M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2,- M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,- M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws, - M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
				//otvory pro matky
					translate([(flange_width - flange_length_beteween_screws)/2, (flange_width - flange_length_beteween_screws)/2, -M5_screw_length + key_height - 2*M5_nut_height])
						cylinder(h = 4*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2,-M5_screw_length + key_height - M5_nut_height])
						cylinder(h = 3*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,-M5_screw_length + key_height - M5_nut_height])
						cylinder(h = 3*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,-M5_screw_length + key_height - 2*M5_nut_height])
						cylinder(h = 4*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);

				//otvor pro klíč na matku nosníku rotoru
					translate([-M5_nut_diameter/2-30, M5_nut_diameter/2, - flange_height - key_height*3.2])
						cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2]);

		//otvor na čep
		/* translate([flange_width/2 + 32, flange_depth/2, -20])
			hull(){
				translate([1.5,0,0])
					cylinder (h = 25, r1 = 8, r2 = 3, $fn = draft ? 50 : 100);
				translate([-1.5,0,0])
					cylinder (h = 25, r1 = 8, r2 = 3, $fn = draft ? 50 : 100);
			} */
		}
		//otvor pro klíč k přírubě
		translate([- global_clearance - width/2 + 10 -M5_nut_diameter/2-30, M5_nut_diameter/2 -flange_depth/2 - global_clearance, height - flange_height - flange_height - key_height*4.5])
			cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2.3]);


        // tvar pro vyriznuti pro desku

        translate([-5, 0, height ])
            rotate([0, rake_angle, 0])
                888_1015_platesape([plate_angle_x, plate_angle_y], [plate_size_x, plate_size_y], plate_bearing_center_distance);

                        translate([-5, 0, height ])
                            rotate([0, rake_angle, 0])
                                888_1015_platesape([plate_angle_x, plate_angle_y], [plate_size_x+40, plate_size_y+40], plate_bearing_center_distance+15);
	}


    %translate([- global_clearance - width/2 + 10,-flange_depth/2 - global_clearance, height - flange_height])
        rotate([0,rake_angle,0])
            translate([20, 20, 0])
                efsm_12();


}


888_1015(draft);

include <../Parameters.scad>
