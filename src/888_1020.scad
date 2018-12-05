include <../Parameters.scad>

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
    motor_distance = 80.66; // vzdalenost prerotatoru od hlavni pos_y
    motor_diameter = 35+2;
    motor_axis_diameter = 6.2;
    motor_screw_diameter = M3_screw_diameter;
    motor_mounting_diameter = 25; // vzdalenost protejsich sroubu pro pridelani prerotatoru
    motor_sink = 15 - 11.5; // pro zapusteni bez podlozek na motoru...

    plate_overlap =  35; // jak moc velký má být přesah směrem k motoru..

    servo_join_y = 78; // vzdalenost kloubu pro servo
    servo_join_x = 45; // vzdalenost kloubku od osy rotoru
    servo_join_size = 15;

    plate_size_y = 50;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 5;

    plate_bearing_center_distance = 7;


    joint_size_x = 60+1; // delka dorazu podle osy x
    joint_size_y = 50+1; //delka dorazu podle osy y
    joint_wall_thickness = 4;

    bearing_inner_diameter = 12.2;
    outer_diameter = bearing_efsm_12_d + 3;
    bearing_ball_height = 10.1;
    rim_height = 1;

    difference(){

    }

      translate([0,0, plate_bearing_center_distance])
        difference(){
            union(){

                hull(){
                    translate([-plate_overlap, -plate_size_y/2, 0])
                        cube([plate_size_x - motor_diameter, plate_size_y, plate_size_z]);

                    // cast nad motorem
                    translate([motor_distance, 0, 0])
                        cylinder(d = motor_diameter+10, h=plate_size_z);

                    // ramecek pro dil 888_1015
                    translate([-(joint_size_x + joint_wall_thickness*2)/2, - (joint_size_y  + joint_wall_thickness*2)/2, -plate_bearing_center_distance])
                        cube([joint_size_x + joint_wall_thickness*2, joint_size_y + joint_wall_thickness*2, 7]);
                }

                // rameno, na kterem jsou kloubky pro servo
                translate([servo_join_x-servo_join_size/2, -servo_join_y/2, 0])
                    cube([servo_join_size, servo_join_y ,plate_size_z]);
            }

            // vyrez pro dil 888_1015
            translate([-joint_size_x/2, -joint_size_y/2, -plate_bearing_center_distance - .05])
                cube([joint_size_x, joint_size_y, 7.1]);

            // otvor pro sroub rotoru
            translate([0, 0, -global_clearance/2])
                cylinder(d = rotor_axis_diameter, h = plate_size_z + global_clearance);

            // otvor pro osu motoru
            translate([motor_distance, 0, -global_clearance/2])
                cylinder(d = motor_axis_diameter, h = plate_size_z + global_clearance);

            // Otvory pro pridelani motoru
            translate([motor_distance, 0, -global_clearance/2])
                rotate([0,0,45]){
                    translate([motor_mounting_diameter/2, 0, 0]){
                        cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);
                        translate([0,0, plate_bearing_center_distance - 4])
                            cylinder(d = M3_nut_diameter, h = M3_screw_head_height);
                    }

                    translate([-motor_mounting_diameter/2, 0, 0]){
                        cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);
                        translate([0,0, plate_bearing_center_distance - 4])
                            cylinder(d = M3_nut_diameter, h = M3_screw_head_height);
                    }

                    translate([0, motor_mounting_diameter/2, 0]){
                        cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);
                        translate([0,0, plate_bearing_center_distance - 4])
                            cylinder(d = M3_nut_diameter, h = M3_screw_head_height);
                    }

                    translate([0, -motor_mounting_diameter/2, 0]){
                        cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);
                        translate([0,0, plate_bearing_center_distance - 4])
                            cylinder(d = M3_nut_diameter, h = M3_screw_head_height);
                    }
                }

            // diry pro pridelani kloubku
            translate([servo_join_x, -servo_join_y/2 + 20, plate_size_z/2])
                rotate([90, 0, 0])
                    cylinder(d = M2_5_screw_diameter, h=100);

            translate([servo_join_x - M2_5_nut_pocket/2, -servo_join_y/2 + 5, plate_size_z/2- M2_5_nut_height])
                cube([M2_5_nut_pocket, M2_5_nut_height, plate_size_z]);

            translate([servo_join_x, servo_join_y/2 - 20, plate_size_z/2])
                rotate([-90, 0, 0])
                    cylinder(d = M2_5_screw_diameter, h=100);

            translate([servo_join_x - M2_5_nut_pocket/2, servo_join_y/2 - 5, plate_size_z/2- M2_5_nut_height])
                cube([M2_5_nut_pocket, M2_5_nut_height, plate_size_z]);

            //Otvor na hallovu sondu
            translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, plate_size_z - hall_thickness])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);

            translate([hall_distance + hall_length/2 + 2, -3, - plate_bearing_center_distance])
                cube([3, 6, 50]);

            // zapusteni motoru
            translate([motor_distance, 0, 0])
                rotate([180, 0, 0])
                    cylinder(d = motor_diameter, h=50);

        }


        difference(){
            union(){
                translate([0, 0, -rim_height + plate_bearing_center_distance])
                    cylinder(h = rim_height, d = outer_diameter, $fn = 50);

                translate([0, 0, -bearing_ball_height/2 + plate_bearing_center_distance])
                    cylinder(h = bearing_ball_height/2, d = bearing_inner_diameter, $fn = 50);
            }

            // otvor pro sroub rotoru
            translate([0, 0, -global_clearance/2])
                cylinder(d = rotor_axis_diameter, h = plate_size_z + global_clearance);
        }
}
888_1020();
