include <../parameters.scad>

module 888_1020(draft = true){


    hall_distance = 35; // distance between axis and magnet

    hall_length = 16;
    hall_length_offset = (11/2-2); // positiv is further from axis
    hall_width = 25+2;
    hall_thickness = 3;

    rotor_axis_diameter = 8.2;


    // 666_1236
    // 666_1007
    // 666_1212
    motor_distance = rotor_head_prerotator_distance; // vzdalenost prerotatoru od hlavni pos_y
    motor_diameter = 35+2;
    motor_axis_diameter = 6.3;
    motor_puller_diameter = 20;
    motor_screw_diameter = M3_screw_diameter;
    motor_mounting_diameter = 25; // vzdalenost protejsich sroubu pro pridelani prerotatoru
    motor_sink = 9.5; // pro zapusteni bez podlozek na motoru...

    plate_overlap =  30; // jak moc velký má být přesah směrem k motoru..

    servo_join_y = 78; // vzdalenost kloubu pro servo
    servo_join_x = 45; // vzdalenost kloubku od osy rotoru
    servo_join_size = 12;
    servo_joint_z = 7; // jak moc nizko bude kloubek

    plate_size_y = 55.5;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 5;


    joint_size_x = 90+0.5; // delka dorazu podle osy x
    joint_size_y = 55+0.5; //delka dorazu podle osy y
    joint_wall_thickness = 4;

    bearing_inner_diameter = 12.2;
    outer_diameter = bearing_efsm_12_d + 3;
    bearing_ball_height = 10.1;
    rim_height = 1;

    back_part_crop = 20;
    
    zebra_inplate=3;
    zebra_x=(rotor_head_kardan_inner_x )/2;
    zebra_y=rotor_head_kardan_inner_y/2;
    zebra_th=2;

    // pro EFSM-8

    /* bearing_inner_diameter = 8;
    outer_diameter = bearing_efsm_08_d + 3;
    bearing_ball_height = 10.1;
    rim_height = 1; */

                        // rameno, na kterem jsou kloubky pro servo
                        hull(){
                                translate([servo_join_x-servo_join_size/2, -servo_join_y/2, 0])
                                    cube([servo_join_size, servo_join_y/4 ,servo_joint_z + 10]);
                                translate([0, -plate_size_y/2, 0])
                                    cube([plate_size_x - motor_diameter - 1.5*back_part_crop, plate_size_y ,plate_size_z]);
                            }
                        // rameno, na kterem jsou kloubky pro servo
                        hull(){
                            translate([servo_join_x-servo_join_size/2, servo_join_y/2 - servo_join_y/5, 0])
                                cube([servo_join_size, servo_join_y/5 ,servo_joint_z + 10]);
                            translate([0, -plate_size_y/2, 0])
                                cube([plate_size_x - motor_diameter - 1.5*back_part_crop, plate_size_y ,plate_size_z]);
                        }


        difference(){
            union(){
                hull(){
                    translate([-(joint_size_x + joint_wall_thickness*2)/2 + back_part_crop, -plate_size_y/2, rotor_head_limiter_above])
                        cube([plate_size_x - motor_diameter - back_part_crop, plate_size_y, plate_size_z]);

                    // cast nad motorem
                    translate([motor_distance, 0, rotor_head_limiter_above])
                        cylinder(d = motor_diameter+10, h=plate_size_z, $fn = draft ? 10 : 100);

                    // ramecek pro dil 888_1015
                    translate([-(joint_size_x + joint_wall_thickness*2)/2 + back_part_crop, - (joint_size_y  + joint_wall_thickness*2)/2, - rotor_head_limiter_below])
                        cube([joint_size_x + joint_wall_thickness*2 - back_part_crop, joint_size_y + joint_wall_thickness*2, rotor_head_limiter_below]);
                }

                // rameno, na kterem jsou kloubky pro servo
                translate([0, 0, rotor_head_limiter_above])
                    hull(){
                        translate([servo_join_x-servo_join_size/2, -servo_join_y/2, -servo_joint_z - 5])
                            cube([servo_join_size, servo_join_y/4 ,servo_joint_z + 10]);
                        translate([servo_join_x-servo_join_size, -plate_size_y/2, -plate_size_z+2])
                            cube([servo_join_size*2, plate_size_y ,plate_size_z*2-2]);
                    }
                // rameno, na kterem jsou kloubky pro servo
                translate([0, 0, rotor_head_limiter_above])
                    hull(){
                        translate([servo_join_x-servo_join_size/2, servo_join_y/2 - servo_join_y/5, -servo_joint_z - 5])
                            cube([servo_join_size, servo_join_y/5 ,servo_joint_z + 10]);
                        translate([servo_join_x-servo_join_size, -plate_size_y/2, -plate_size_z+2])
                            cube([servo_join_size*2, plate_size_y ,plate_size_z*2-2]);
                    }


    // Vymezovaci podlozka pod motor, misto hlinikove 6.5mm silne podlozky
                /* translate([motor_distance, 0, 0])
                    hull(){
                        rotate([180, 0, 0])
                            cylinder(d = motor_diameter, h=6.5, $fn = draft ? 20 : 50);

                        rotate([180, 0, 0])
                            cylinder(d = motor_diameter+10, h=0.1, $fn = draft ? 20 : 50);
                    } */


                    // Otvory pro pridelani motoru
                    translate([motor_distance, 0, -global_clearance/2 ])
                        rotate([0,0,45]){
                            for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                                translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, 0]){
                                    translate([0,0,M3_screw_head_height+global_clearance+0.03])
                                        cylinder(d = motor_screw_diameter, h = 50, , $fn = draft ? 10 : 50);
                                    cylinder(d = M3_nut_diameter, h = M3_screw_head_height+ global_clearance, $fn = draft ? 10 : 50);
                                }
                            }
                        }
                    }
            }

            // vyrez pro dil 888_1015
            //translate([-joint_size_x/2, -joint_size_y/2, -plate_bearing_center_distance - .05])
            //    cube([joint_size_x, joint_size_y, 7.1]);

            intersection(){
                rotate([90,0,0])
                        cylinder(h=200, d=joint_size_x, $fn = draft ? 20 : 200, center = true);
                rotate([0,90,0])
                        cylinder(h=200, d=joint_size_y, $fn = draft ? 20 : 200, center = true);
                translate([-joint_size_x/2, -joint_size_y/2, -rotor_head_limiter_below])
                    cube([joint_size_x, joint_size_y, rotor_head_limiter_above + rotor_head_limiter_below]);
            }

            // otvor pro sroub rotoru
            translate([0, 0, -global_clearance/2])
                cylinder(d = rotor_axis_diameter, h = 50, $fn = draft ? 20 : 80);

            // otvor pro osu motoru
            translate([motor_distance, 0, -global_clearance/2-10])
                cylinder(d = motor_axis_diameter, h = 50, $fn = draft ? 10 : 100);

            // otvor pro  remenici
            translate([motor_distance, 0, -global_clearance/2-10])
                cylinder(d = motor_puller_diameter, h = 50, $fn = draft ? 10 : 100);


            // Otvory pro pridelani motoru
            translate([motor_distance, 0, -global_clearance/2 ])
                rotate([0,0,45]){
                    for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                        translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, 0]){
                            translate([0,0,0])
                                cylinder(d = motor_screw_diameter, h = 50, , $fn = draft ? 10 : 50);
                            translate([0,0, rotor_head_limiter_above+plate_size_z - M3_screw_head_height + global_clearance])
                                cylinder(d = M3_nut_diameter, h = M3_screw_head_height, $fn = draft ? 10 : 50);
                        }
                    }
                }

            // diry pro pripojeni tahla k servu
            translate([servo_join_x, -servo_join_y/2 + 20, -servo_joint_z + rotor_head_limiter_above])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h=50, $fn = draft ? 10 : 30);

            translate([servo_join_x, -servo_join_y/2 + 5, -servo_joint_z + rotor_head_limiter_above])
                rotate([-90, 0, 0])
                    cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);


                    //otvor por kardan      
                    //brity
           
                   translate([0,0,plate_size_z+brit_height])
                        rotate([0,rotor_head_pitch_stop,0])
                            kardan_center_part_model();
                              
                   translate([0,0,plate_size_z+brit_height])
                        rotate([0,-rotor_head_pitch_stop,0])
                            kardan_center_part_model();
                   
                    xdst=(rotor_head_kardan_inner_x/2+rotor_head_brit_width-(rotor_head_wall_height/2+rotor_head_plate_thickness)*tan(rotor_head_pitch_stop))*cos(rotor_head_pitch_stop);
                    xsize=(plate_size_x - motor_diameter)/2-(rotor_head_kardan_inner_x/2+rotor_head_brit_width)-global_clearance;
                                        
                    translate([-xdst-15,
                                0,
                                15+plate_size_z])
                            cube([30,
                            rotor_head_kardan_inner_y+2*rotor_head_brit_width+2*rotor_head_cardan_clearance,
                            30], center=true);
                    
                    translate([xdst+(zebra_x+rotor_ax_neck_diameter/2-xdst)/2,
                                0,
                                15+plate_size_z])
                            cube([(zebra_x+rotor_ax_neck_diameter/2-xdst),
                                rotor_head_kardan_inner_y+2*rotor_head_brit_width+2*rotor_head_cardan_clearance,
                                30], center=true);                   
                                
                                
                                //zkoseni zadní časti       
                    translate([zebra_x+rotor_ax_neck_diameter/2,0,sqrt(2)*rotor_head_wall_height+plate_size_z])
                        rotate([0,45,0])
                            cube([2*rotor_head_wall_height,
                            rotor_head_kardan_inner_y+2*(rotor_head_brit_width+rotor_head_cardan_clearance),
                            2*rotor_head_wall_height],center=true);
                }
                
                
                difference(){
                    union(){
                        //ax_neck
                        
                        translate([0, 0,plate_size_z ])
                             cylinder(d2 = rotor_ax_neck_diameter, d1=cone_d , h = rotor_ax_neck_height);
                        //bearing ring
                        translate([0, 0,plate_size_z ])
                             cylinder(d = rotor_head_bearing_d , h = rotor_ax_neck_height+rotor_ax_bearing_ring_h);

            translate([servo_join_x, servo_join_y/2 - 20, -servo_joint_z + rotor_head_limiter_above])
                rotate([-90, 0, 0])
                    cylinder(d = M3_screw_diameter, h=50, $fn = draft ? 10 : 30);

            translate([servo_join_x, servo_join_y/2 - M3_nut_height - 5, -servo_joint_z + rotor_head_limiter_above])
                rotate([-90, 0, 0])
                    cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);

            translate([servo_join_x, servo_join_y/2 - M3_nut_height - 5, -M3_nut_pocket/2 - servo_joint_z + rotor_head_limiter_above])
                cube([plate_size_z*5, M3_nut_height, M3_nut_pocket]);

            //Otvor na hallovu sondu
            translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, plate_size_z - hall_thickness + rotor_head_limiter_above])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);

            difference(){
                translate([hall_distance + hall_length/2 + 2, -3, - rotor_head_plate_bearing_center_distance + rotor_head_limiter_above])
                    translate([0,0, plate_size_z+8])
                        rotate([0,-40,0])
                            translate([0,0,-20])
                                cube([3, 6, 50]);

                translate([hall_distance - hall_length/2 + hall_length_offset +2, -hall_width/2, plate_size_z - hall_thickness + rotor_head_limiter_above - global_clearance])
                    cube([hall_length, hall_width, hall_thickness+global_clearance]);

            }
            
         //žebra        
         for(i=[45,135,225,315]){
            translate([0,0,plate_size_z-zebra_inplate])
                rotate([0,0,i])                    
                        difference(){                            
                            translate([rotor_ax_neck_diameter/2,-zebra_th/2,0])
                                cube([1.54*(zebra_x),zebra_th,brit_height]);
                            for(j=[0:1:10])
                                translate([rotor_ax_neck_diameter/2+j*3*zebra_th,0,brit_height])
                                    cube([zebra_th,2*zebra_th,2*brit_height],center=true);
                        }
         }
         
         for(i=[0,90,180,270]){
            translate([0,0,plate_size_z-zebra_inplate])
                rotate([0,0,i])
                    difference(){
                        translate([rotor_ax_neck_diameter/2,-zebra_th/2,0])
                            cube([zebra_x-rotor_head_brit_width-0.5*rotor_head_cardan_clearance,zebra_th,brit_height]);
                            for(j=[0:1:10])
                                translate([rotor_ax_neck_diameter/2+j*3*zebra_th,0,brit_height])
                                    cube([zebra_th,2*zebra_th,2*brit_height],center=true);
                        }
         }
         
         
            for(i=[0,180])
            {
                rotate([0,0,i])
                    union(){
                         translate([rotor_ax_neck_diameter/2+zebra_x/2,zebra_x/2+1.5*zebra_th,+plate_size_z+brit_height/2])
                            rotate([0,0,90])
                            difference(){
                                cube([zebra_x,zebra_x,brit_height],center=true);
                                rotate([0,0,45])
                                    translate([zebra_x,0,0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                }
                                
                          translate([rotor_ax_neck_diameter/2+zebra_x/2,-(zebra_x/2+1.5*zebra_th),+plate_size_z+brit_height/2])
                            rotate([0,0,180])
                            difference(){
                                cube([zebra_x,zebra_x,brit_height],center=true);
                                rotate([0,0,45])
                                    translate([zebra_x,0,0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                }
                                
                          translate([1.5*zebra_th+zebra_x/2,(zebra_x/2+rotor_ax_neck_diameter/2),plate_size_z+brit_height/2])
                            difference(){
                                cube([zebra_x,zebra_x,brit_height],center=true);
                                rotate([0,0,-45])
                                    translate([zebra_x,0,0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                translate([0,1.5*zebra_x-rotor_head_brit_width-0.5*rotor_head_cardan_clearance,0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                }  
                                         
                           translate([1.5*zebra_th+zebra_x/2,-(zebra_x/2+rotor_ax_neck_diameter/2),plate_size_z+brit_height/2])
                            difference(){
                                cube([zebra_x,zebra_x,brit_height],center=true);
                                rotate([0,0,45])
                                    translate([zebra_x,0,0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                translate([0,-(1.5*zebra_x-rotor_head_brit_width-0.5*rotor_head_cardan_clearance),0])
                                        cube([2*zebra_x,2*zebra_x,2*brit_height], center=true);
                                }
                            } 
             }                
                        
         
        }


        difference(){
            translate([0, 0, rotor_head_limiter_above-4])
                cylinder(d = 12+2, h = 5);

            // otvor pro sroub rotoru
            translate([0, 0, -global_clearance/2])
                cylinder(d = rotor_axis_diameter, h = 50, $fn = draft ? 20 : 80);
        }



}
888_1020(false);
