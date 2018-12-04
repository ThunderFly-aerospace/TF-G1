include <../Parameters.scad>

module 888_1020(draft = true){


    hall_distance = 35; // distance between axis and magnet

    hall_length = 16;
    hall_length_offset = (11/2-2); // positiv is further from axis
    hall_width = 25+2;
    hall_thickness = 3;

    rotor_axis_diameter = 6.2;


    // 666_1236
    // 666_1007
    // 666_1212
    motor_distance = 70; // vzdalenost prerotatoru od hlavni pos_y
    motor_diameter = 35+2;
    motor_axis_diameter = 6.2;
    motor_screw_diameter = M3_screw_diameter;
    motor_mounting_diameter = 25; // vzdalenost protejsich sroubu pro pridelani prerotatoru
    motor_sink = 15 - 11.5; // pro zapusteni bez podlozek na motoru...

    plate_overlap =  35; // jak moc velký má být přesah směrem k motoru..

    servo_join_y = 65; // vzdalenost kloubu pro servo
    servo_join_x = 45; // vzdalenost kloubku od osy rotoru
    servo_join_size = 15;

    plate_size_y = 50;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 15;

    difference(){
        union(){
            hull(){
                translate([-plate_overlap, -plate_size_y/2, 0])
                    cube([plate_size_x - motor_diameter, plate_size_y, plate_size_z]);

                // cast nad motorem
                translate([motor_distance, 0, 0])
                    cylinder(d = motor_diameter+10, h=plate_size_z);
            }
            // rameno, na kterem jsou kloubky pro servo
            translate([servo_join_x-servo_join_size/2, -servo_join_y/2, 0])
                cube([servo_join_size, servo_join_y ,plate_size_z]);
        }

        // otvor pro sroub rotoru
        cylinder(d = rotor_axis_diameter, h = plate_size_z + global_clearance);

        // otvor pro osu motoru
        translate([motor_distance, 0, -global_clearance/2])
            cylinder(d = motor_axis_diameter, h = plate_size_z + global_clearance);

        // Otvory pro pridelani motoru
        translate([motor_distance, 0, -global_clearance/2])
            rotate([0,0,45]){
                translate([motor_mounting_diameter/2, 0, 0])
                    cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);

                translate([-motor_mounting_diameter/2, 0, 0])
                    cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);

                translate([0, motor_mounting_diameter/2, 0])
                    cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);

                translate([0, -motor_mounting_diameter/2, 0])
                    cylinder(d = motor_screw_diameter, h = plate_size_z + global_clearance);
            }

        // diry pro pridelani kloubku
        translate([servo_join_x, -servo_join_y/2 + 20, plate_size_z/2])
            rotate([90, 0, 0])
                cylinder(d = M2_5_screw_diameter, h=100);

        translate([servo_join_x - M2_5_nut_pocket/2, -servo_join_y/2 + 5, plate_size_z/2])
            cube([M2_5_nut_pocket, M2_5_nut_height, plate_size_z]);

        translate([servo_join_x, servo_join_y/2 - 20, plate_size_z/2])
            rotate([-90, 0, 0])
                cylinder(d = M2_5_screw_diameter, h=100);

        translate([servo_join_x - M2_5_nut_pocket/2, servo_join_y/2 - 5, plate_size_z/2])
            cube([M2_5_nut_pocket, M2_5_nut_height, plate_size_z]);

        //Otvor na hallovu sondu
        translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, plate_size_z - hall_thickness])
            cube([hall_length, hall_width, hall_thickness+global_clearance]);

        translate([hall_distance + hall_length/2 + 2, -3, -global_clearance/2])
            cube([3, 6, plate_size_z + global_clearance]);

        // zapusteni motoru
        translate([motor_distance, 0, 0])
            cylinder(d = motor_diameter, h=motor_sink);

    }
}
888_1020();
