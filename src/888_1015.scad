include <../parameters.scad>
use <888_1022.scad>
draft = $preview;

/*
Dil rotorove hlavy.

Tento dil je pridelan na vrch pilonu.
Nese 2x servo a kulove lozisko pro rotor.
*/

module kardan_brit_oposite_model(lenght)
{
    difference(){
        translate([0,0,lenght/2-rotor_head_wall_height/2])
            cube([rotor_head_brit_width+1.5*rotor_head_cardan_clearance+0.01,lenght,lenght], center=true);
        translate([0,0,-rotor_head_wall_height*sqrt(2)])
            rotate([45,0,0])
                cube(2*rotor_head_wall_height, center=true);

        }
}


module 888_1015(draft){

	plate_thickness = 1.5;

	width = rotor_head_width;
    depth = 2*plate_thickness + coupling_depth_666_1026;
	depth_pipe = 30;
    height = rotor_head_height;
	rake_angle = rotor_head_rank_angle;		//úhel horního zkosení

	servo_width = 21;	//šřka otvoru pro servo
	servo_height = 42;	//výška otvoru pro servo

    servo_pos_z = 7;

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
                        #translate([-width/3, -depth_pipe/2,0])
                            cube ([width/3, depth_pipe, 0.1]);

                    }
                    //translate([-width/2,-depth/2,0])
                    //    #cube ([width, depth, 0.1]);
                    translate([-width/2-5,-depth/2,height+20])
                        cube ([width+5, depth, 10]);
                }
                translate([-rotor_head_bearing_x_shift,0, height])
                    rotate([0, rotor_head_rank_angle, 0])
                        translate([0,0, 25])
                            cube([100,100,50], center=true);
            }
        }


		//otvory z dílu 666_1026
		translate([27 - width/2,0,0])
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
        					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 10 : 100 );
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

        //priruba pro lozisko
        translate([-rotor_head_bearing_x_shift,0,height])
            rotate([0, rake_angle, 0]){

                // základní tvar pro prirubu
                translate([0, 0, 15-rotor_head_bearing_a_center_of_rotation])
                    cube([rotor_head_bearing_width+global_clearance, rotor_head_bearing_width+global_clearance, 30], center=true);

                translate([0, 0, -18+0.3])
                    cylinder(h=30, d=rotor_head_bearing_db);

                for (i=[[rotor_head_bearing_m/2, rotor_head_bearing_m/2, -25, 0],
                    [-rotor_head_bearing_m/2, rotor_head_bearing_m/2, -25, 0],
                    [-rotor_head_bearing_m/2, -rotor_head_bearing_m/2, -25, 1],
                    [rotor_head_bearing_m/2, -rotor_head_bearing_m/2, -25, 1]]) {
                    translate(i+[0,0,10]){
                        //bridged screw hole
                        translate([0,0,-M5_nut_height/2 + layer_thickness])
                            cylinder(h = 30, d = M5_screw_diameter, $fn = draft ? 50 : 100);

                        translate([0,0,-1.5*M5_nut_height])
                        {
                            rotate([0,0,30])
                                cylinder(h = M5_nut_height, d = M5_nut_diameter, $fn = 6);
                            rotate([0, 0, i[3]*180])
                                translate([-M5_nut_pocket/2, 0, 0])
                                    cube([M5_nut_pocket, 20, M5_nut_height]);

                            //bridged screw hole
                            translate([0, 0, -M5_nut_pocket/2])
                                cylinder(h = M5_nut_pocket, d = M5_screw_diameter, $fn = draft ? 20 : 100);

                            /*//bridged screw hole
                            translate([0, 0, -7-3])
                                cylinder(h = 7, d = M5_screw_diameter, $fn = draft ? 20 : 100);*/
                        }

                    }
                //brity
                xdst=(rotor_head_bearing_width+global_clearance+1.5*rotor_head_cardan_clearance+rotor_head_brit_width)/2;
                translate([xdst,0,0])
                    rotate([rotor_head_roll_stop,0,0])
                             kardan_brit_oposite_model(70);
                translate([-xdst,0,0])
                    rotate([rotor_head_roll_stop ,0,0])
                            kardan_brit_oposite_model(70);
                translate([xdst,0,0])
                    rotate([-rotor_head_roll_stop,0,0])
                            kardan_brit_oposite_model(70) ;
                translate([-xdst,0,0])
                    rotate([-rotor_head_roll_stop,0,0])
                            kardan_brit_oposite_model(70);
                //zuzeni
                translate([0,rotor_head_bearing_width/2+35,2])
                   cube([100,70,30], center=true);
                translate([0,-rotor_head_bearing_width/2-35,2])
                   cube([100,70,30], center=true);

                //elegance
                translate([(rotor_head_bearing_width+global_clearance)/2+1.5*rotor_head_cardan_clearance+rotor_head_brit_width,0,0])
                translate([35*sqrt(2)+1,0,0])
                    rotate([0,45,0])
                            cube([70,70,70],center=true);
               translate([-((rotor_head_bearing_width+global_clearance)/2+1.5*rotor_head_cardan_clearance+rotor_head_brit_width),0,0])
                translate([-(35*sqrt(2)+1),0,0])
                    rotate([0,45,0])
                            cube([70,70,70],center=true);

                }

                // montazni otvor
                translate([-30/2-50-2, -30/2, -rotor_head_bearing_a1-20-4])
                    cube([30+50, 30, 13]);

            }

	}

}


888_1015(draft);

if(draft){
    translate([0, 0, rotor_head_height+4])
    rotate([180, 9, 0])
    888_1022();
}

//kardan_brit_oposite_model(50);
