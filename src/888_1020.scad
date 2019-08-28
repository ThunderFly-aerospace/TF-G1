include <../parameters.scad>

module kardan_center_part_model()
{
    
    b=2*rotor_head_wall_height;

    inner_x=rotor_head_kardan_inner_x;
    inner_y=rotor_head_kardan_inner_y;
    plate_thickness=rotor_head_plate_thickness;
    brit_width=rotor_head_brit_width;
    wall_height=rotor_head_wall_height;
    kardan_clearance=rotor_head_cardan_clearance;
    
    outer_x = inner_x + 2*brit_width;
    outer_y = inner_y + 2*brit_width+2*kardan_clearance;
    outer_height = wall_height + plate_thickness ;
    
    translate([0,0,-plate_thickness-wall_height/2])
        difference(){     
            translate ([0,0,outer_height/2]) {
                cube([outer_x,outer_y,outer_height],center = true);
                }
            /*translate([0,0,wall_height + plate_thickness]){
                cube([inner_x,inner_y,wall_height*2],center = true);
                } */      

            translate([0,-b/2-inner_y/2+0.01,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
                rotate ([0,45,0]){
                    cube(b,center=true);
                    }
                }
            translate([0,b/2+inner_y/2-0.01,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
                rotate ([0,45,0]){
                    cube(b,center=true);
                    }
                }           
            }
}


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

    wall_thickness=4;

    brit_height=(rotor_head_wall_height/2+rotor_head_plate_thickness+(rotor_head_bearing_width/2+rotor_head_brit_width+rotor_head_cardan_clearance)*tan(rotor_head_pitch_stop))*cos(rotor_head_pitch_stop);
    
    
    rotor_ax_neck_diameter=rotor_head_bearing_d+2;
    rotor_ax_neck_height=brit_height-(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation);
    rotor_ax_bearing_ring_h=3;


    plate_size_y = rotor_head_kardan_inner_y+2*rotor_head_brit_width+2*wall_thickness;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 5;



    back_part_crop = 20;

        difference(){
            union(){
                hull(){
                    translate([ ( back_part_crop)/2,0, plate_size_z/2])
                        cube([plate_size_x - motor_diameter - back_part_crop, plate_size_y, plate_size_z],center=true);   
                    // cast nad motorem
                    translate([motor_distance, 0, 0])
                        cylinder(d = motor_diameter+10, h=plate_size_z, $fn = draft ? 10 : 100);
                    
                    //ramecek pro kardan
                    translate([ ( back_part_crop)/2+5,0, brit_height+plate_size_z/2])
                        cube([plate_size_x - motor_diameter - back_part_crop+5, plate_size_y, plate_size_z],center=true);

                }

                // rameno, na kterem jsou kloubky pro servo
                hull(){
                        translate([servo_join_x-servo_join_size/2, -servo_join_y/2, 0])
                            cube([servo_join_size, servo_join_y/4 ,servo_joint_z + 10]);
                        translate([servo_join_x-servo_join_size, -plate_size_y/2, 0])
                            cube([servo_join_size*2, plate_size_y ,plate_size_z*2-2]);
                    }
                // rameno, na kterem jsou kloubky pro servo
                hull(){
                    translate([servo_join_x-servo_join_size/2, servo_join_y/2 - servo_join_y/5, 0])
                        cube([servo_join_size, servo_join_y/5 ,servo_joint_z + 10]);
                    translate([servo_join_x-servo_join_size, -plate_size_y/2, 0])
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
                            translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, plate_size_z]){
                                    cylinder(d1 = M3_screw_diameter*4, d2 = M3_screw_diameter*2, h = motor_sink, $fn = draft?10:60);
                            }
                        }
                    }
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

            //misto pro motor
            translate([motor_distance,0,plate_size_z+motor_sink])
                cylinder(d=motor_diameter, h=20,$fn = draft ? 10 : 100);

            // Otvory pro pridelani motoru
            translate([motor_distance, 0, -global_clearance/2 ])
                rotate([0,0,45]){
                    for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                        translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, 0]){
                            cylinder(d = motor_screw_diameter, h = 50, , $fn = draft ? 10 : 50);
                            cylinder(d = M3_nut_diameter, h = M3_screw_head_height+ global_clearance, $fn = draft ? 10 : 50);
                        }
                    }
                }

            // diry pro pripojeni tahla k servu
            translate([servo_join_x, -servo_join_y/2 + 20, servo_joint_z])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h=50, $fn = draft ? 10 : 30);

            translate([servo_join_x, -servo_join_y/2 + 5, servo_joint_z ])
                rotate([-90, 0, 0])
                    cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);


            translate([servo_join_x, -servo_join_y/2 + 5,  -M3_nut_pocket/2 + servo_joint_z])
                cube([plate_size_z*5, M3_nut_height, M3_nut_pocket]);

            translate([servo_join_x, servo_join_y/2 - 20, servo_joint_z])
                rotate([-90, 0, 0])
                    cylinder(d = M3_screw_diameter, h=50, $fn = draft ? 10 : 30);

            translate([servo_join_x, servo_join_y/2 - M3_nut_height - 5, servo_joint_z])
                rotate([-90, 0, 0])
                    cylinder(d = M3_nut_diameter, h=M3_nut_height, $fn = 6);

            translate([servo_join_x, servo_join_y/2 - M3_nut_height - 5, -M3_nut_pocket/2 + servo_joint_z])
                cube([plate_size_z*5, M3_nut_height, M3_nut_pocket]);

            //Otvor na hallovu sondu
            translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, -global_clearance/2])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);

            difference(){
                translate([hall_distance+hall_length_offset+hall_length/2, 0, hall_thickness])
                    rotate([0,40,0])
                        translate([-1.5,0,0])
                            cube([3, 6, 50], center=true);
                
                 translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, 0])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);
            }


            //otvor por kardan
           /* translate([back_part_crop/2-wall_thickness,0,plate_size_z+25])
                cube([plate_size_x - motor_diameter - back_part_crop,
                      rotor_head_kardan_inner_y,
                      50], center=true);*/
           
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
            
            translate([xdst+xsize/2,
                        0,
                        15+plate_size_z])
                    cube([xsize,
                        rotor_head_kardan_inner_y+2*rotor_head_brit_width+2*rotor_head_cardan_clearance,
                        30], center=true);                     
                    
            translate([(plate_size_x - motor_diameter - back_part_crop)/2+5,0,brit_height+plate_size_z])
                rotate([0,40,0])
                    cube([rotor_head_wall_height,
                    rotor_head_kardan_inner_y+2*(rotor_head_brit_width+rotor_head_cardan_clearance),
                    rotor_head_wall_height],center=true);
        }
        
        
        difference(){
            union(){
                //ax_neck         
                translate([0, 0,plate_size_z ])
                     cylinder(d = rotor_ax_neck_diameter , h = rotor_ax_neck_height);
                //bearing ring
                translate([0, 0,plate_size_z ])
                     cylinder(d = rotor_head_bearing_d , h = rotor_ax_neck_height+rotor_ax_bearing_ring_h);
            }
            
            //otvor pro sroub rotoru
            translate([0, 0, -(rotor_ax_neck_height+rotor_ax_bearing_ring_h)/2])
                cylinder(d = rotor_axis_diameter, h = 2*(rotor_ax_neck_height+rotor_ax_bearing_ring_h), $fn = draft ? 20 : 80);
        }

}

888_1020(false);
//translate([0,0,40])
   // kardan_center_part_model();
