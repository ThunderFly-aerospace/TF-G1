include <../Parameters.scad>
draft = true;

/*
Dil rotorove hlavy.

Tento dil je pridelan na vrch pilonu.
Nese 2x servo a kulove lozisko pro rotor.
*/


    plate_angle_x = 10;
    plate_angle_y = 10;
    plate_angle_res = 1;
    plate_size_y = 60.5;
    plate_size_x = 100;

    plate_bearing_center_distance = 6.5;


    bearing_efsm_ag = bearing_efsm_12_ag;
    bearing_efsm_a1 = bearing_efsm_12_a1;
    bearing_efsm_h = bearing_efsm_12_h;
    bearing_efsm_m = bearing_efsm_12_m;
    bearing_efsm_db = bearing_efsm_12_db;


    /* bearing_efsm_ag = bearing_efsm_08_ag;
    bearing_efsm_a1 = bearing_efsm_08_a1;
    bearing_efsm_h = bearing_efsm_08_h;
    bearing_efsm_m = bearing_efsm_08_m;
    bearing_efsm_db = bearing_efsm_08_db;
 */

    rotx = 20/2;
    roty = 20/2;


    joint_size_x = 60; // delka dorazu podle osy x
    joint_size_y = 55; //delka dorazu podle osy y

    joint_wall_thickness = 4;



module 888_1015_platesape(draft){

        translate([-1,0,10]) difference(){
            union(){
                    difference(){
                        union(){
                            /* intersection(){
                                rotate([0, 90, 0])
                                    translate([0,0,-50])
                                        scale([0.3, 1 ,1])
                                            cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                rotate([90, 0, 0])
                                    translate([0, 0, -50])
                                        scale([1, 0.3 ,1])
                                            cylinder(d=joint_size_x, h=100, , $fn = draft ? 10 : 150);
                            } */
                            intersection(){
                                intersection_for(ox=[-10, 0, 10]){
                                        rotate([ox, 90, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                        rotate([90+ox, 0, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                        rotate([ox, 90+ox, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                        rotate([90+ox, ox, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                }
                                intersection_for(oy=[-10, 0, 10]){
                                        rotate([0, 90+oy, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                        rotate([90, oy, 0])
                                            translate([0,0,-50])
                                                cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);
                                }
                            }

/*
                                rotate([0, 90, 0])
                                    translate([0,0,-50])
                                            cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);
                                rotate([0, 90+10, 0])
                                    translate([0,0,-50])
                                            cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);
                                rotate([0, 90-10, 0])
                                    translate([0,0,-50])
                                            cylinder(d=joint_size_y, h=100, $fn = draft ? 10 : 150);

                                rotate([90, 0, 0])
                                    translate([0, 0, -50])
                                            cylinder(d=joint_size_x, h=100, $fn = draft ? 10 : 150); */

                                /* translate([-100, -100, -200])
                                    cube(200); */
                            //}
                    }

            // plošky na svrchní straně
                    for (i=[[rotx, 0, 0], [-rotx, 0, 0], [0, roty, 0], [0, -roty, 0],
                            [rotx, roty, 0], [-rotx, roty, 0], [rotx, roty, 0], [rotx, -roty, 0],
                            [rotx, -roty, 0], [-rotx, -roty, 0], [-rotx, roty, 0], [-rotx, -roty, 0]]) {
                        translate([0, 0, bearing_efsm_ag - bearing_efsm_a1 -1 + 5])
                        rotate(i)
                            translate([-50, -50, 0])
                                cube([100, 100, 50]);
                    }
                }


                x = joint_size_x + joint_wall_thickness*2;
                y = joint_size_y + joint_wall_thickness*2;

            }

        }
    }


module 888_1015(draft){

	plate_thickness = 1.5;

	width = 70;
    depth = 2*plate_thickness + coupling_depth_666_1026;
	depth_pipe = 30;
	//height = 68.5;
    height = 65;

	rake_angle = 9;		//úhel horního zkosení

	servo_width = 21;	//šřka otvoru pro servo
	servo_height = 42;	//výška otvoru pro servo

    servo_pos_z = 12;

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

    M4_screw_length = 40;

	M5_screw_length = 19;
	M2_5_screw_length = 10;
	M2_5_pocket_depth = 5;

	difference (){
		//základní kostka
        union(){

            difference(){
                hull(){
                    hull() {
                        translate([0,-depth/2,0])
                            cube ([width/2, depth, 0.1]);
                        translate([-width/2, -depth_pipe/2,0])
                            cube ([width, depth_pipe, 0.1]);

                    }
                    //translate([-width/2,-depth/2,0])
                    //    #cube ([width, depth, 0.1]);
                    translate([-width/2-5,-depth/2,height+20])
                        cube ([width+5, depth, 10]);
                }
                translate([-5,0,height+bearing_efsm_a1])
                    for (i=[[rotx, rake_angle, 0], [-rotx, rake_angle, 0], [0, roty + rake_angle, 0], [0, -roty + rake_angle, 0],
                            [rotx, roty + rake_angle, 0], [-rotx, roty + rake_angle, 0], [rotx, roty + rake_angle, 0], [rotx, -roty + rake_angle, 0],
                            [rotx, -roty + rake_angle, 0], [-rotx, -roty + rake_angle, 0], [-rotx, roty + rake_angle, 0], [-rotx, -roty + rake_angle, 0]]) {
                        rotate(i)
                            translate([-50, -50, 0])
                                cube([100, 100, 50]);
                }
            }


            //#translate([-5,0,height+8])
            //    rotate([0, rake_angle, 0])
            //        translate([0,0,0])
            //            sphere(r=3);

            intersection(){
                translate([-5,0,height])
                    rotate([0, rake_angle, 0])
                        888_1015_platesape();
            }

        }


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
				translate([0, M4_screw_length / 2, 7.5])
			        rotate([-90, 0, 0])
			            cylinder(h = 20, d = 13);

			    translate([0, -M4_screw_length / 2, 7.5])
			        rotate([90, 0, 0])
                          cylinder(h = 20, d = M4_nut_diameter, $fn = 6);

                translate([0, M4_screw_length /2, 42.5])
			        rotate([-90, 0, 0])
			            cylinder(h = 20, d = 13);

				translate([0, -M4_screw_length /2, 42.5])
			        rotate([90, 0, 0])
			            cylinder(h = 20, d = M4_nut_diameter, $fn = 6);

			}
		//otvory pro serva
		translate([width/2 - servo_width - 4,-depth/2 - global_clearance/2, servo_pos_z])
			cube([servo_width, depth + global_clearance,servo_height]);
		//otvory pro odlehceni za servy
		translate([width/4, -20, servo_pos_z + 5* global_clearance])
			cube([servo_width, 40, servo_height - 10*global_clearance]);
		//otvor pro kabely od serv
		translate([width/2-servo_width + servo_width/4-4, -20, -global_clearance])
			cube([servo_width/2,40,30]);
		//zkosení otvoru pro kabely od servo
		translate([width/2 - servo_width + servo_width/4- 4,-3, servo_pos_z -8])
			rotate([70,0,0])
				cube([servo_width/2,20,40]);
		translate([width/2 - servo_width + servo_width/4- 4,-4.5, servo_pos_z + 10])
			rotate([-70,0,0])
				cube([servo_width/2,20,40]);


// Otvory pro pridelani serv
// dira na sroub + kapsa na matice
        for (m=[0, 1]) {
            mirror([0, m, 0]){
                a = (49-40.7)/2;
                for (i=[[0, -a, 0], [10, -a, 0], [0, 49-a, -42], [10, 49-a, -42]])

                translate([width/2 - 4 - 5.5-i[0],-depth/2 + M2_5_screw_length, servo_pos_z + i[1]]){
                    rotate([0, -90, 90]){
        					#cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 10 : 100 );
        					translate([0, 0, M2_5_pocket_depth])
        						rotate([0, 0, 90])
        							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
                            rotate([0,0,i[2]])
                                translate([0, -M2_5_nut_diameter/2, M2_5_pocket_depth])
				                    cube([40, M2_5_nut_diameter, M2_5_nut_height]);
                    }
                }
            }
        }

        translate([-4.6,0,height+8.2])
            rotate([0, rake_angle, 0]){

                // základní tvar pro prirubu
                translate([-bearing_efsm_h/2, -bearing_efsm_h/2, -bearing_efsm_a1])
                    cube([bearing_efsm_h, bearing_efsm_h, 30]);

                translate([0, 0, -18+0.3])
                    cylinder(h=15 + global_clearance, d=bearing_efsm_db);

                for (i=[[bearing_efsm_m/2, bearing_efsm_m/2, -25, 0], [-bearing_efsm_m/2, bearing_efsm_m/2, -25, 0], [-bearing_efsm_m/2, -bearing_efsm_m/2, -25, 1], [bearing_efsm_m/2, -bearing_efsm_m/2, -25, 1]]) {
                    translate(i+[0,0,10]){
                        cylinder(h = 30, d = M5_screw_diameter, $fn = draft ? 50 : 100);
                        cylinder(h = M5_nut_height, d = M5_nut_diameter, $fn = 6);
                        rotate([0, 0, i[3]*180])
                            translate([-M5_nut_diameter/2, 0, 0])
                                cube([M5_nut_diameter, 20, M5_nut_height]);

                        translate([0, 0, -10-3])
                            cylinder(h = 10, d = M5_screw_diameter, $fn = draft ? 20 : 100);

                        translate([0, 0, -10+7.3])
                            cylinder(h = 2.7-0.3, d = M5_screw_diameter, $fn = draft ? 20 : 100);
                    }
                }

                // montazni otvor
                translate([-30/2-50, -30/2, -bearing_efsm_a1-20-4])
                    cube([30+50, 30, 13]);

            }

		translate([- global_clearance - width/2 + 10,-flange_depth/2 - global_clearance, height - flange_height])
			rotate([0,rake_angle,0])
				union(){
				//otvor pro klíč na matku nosníku rotoru
					//translate([-M5_nut_diameter/2-35, M5_nut_diameter/2, - key_height*2.5])
					//	cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2]);
		}



        //otvor pro klíč k přírubě
		//#translate([- global_clearance - width/2 + 10 -M5_nut_diameter/2-30, M5_nut_diameter/2 -flange_depth/2 - global_clearance, height - key_height*4.5])
		//	cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2.3]);

	}

        //translate([- global_clearance - width/2 +8 ,-flange_depth/2 - global_clearance, height - flange_height + 7])
        //    rotate([0,rake_angle,0])
        //        translate([20, 20, 0])
        //            efsm();


}

difference(){
    888_1015(draft);
    //cube(500);
    //translate([-250,-250,-460]) cube(500);
}
