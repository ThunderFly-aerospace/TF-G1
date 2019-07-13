include <../parameters.scad>


module 888_2017(){

    suspension_bolt_length = 20+1;
    suspension_pipe_screw_length = 20 - M3_nut_height*2;
    suspension_wall_thickness = 4;
    suspension_bolt_diameter = M8_screw_diameter;
    suspension_mount_offset = [25, 0, 18];
    suspension_mount_pipe_end = 8;


    difference(){
        union(){

            // sloupek pro pridelani kuloveho kloubu
            difference(){
                hull(){
                    translate(suspension_mount_offset)
                        rotate([90, 0, 0])
                            cylinder(d = suspension_bolt_diameter + 8, h = suspension_bolt_length + 10, center = true);

                    translate([suspension_mount_offset[0], 0, 4]) cube([30, 40, 8], center = true);
                }


                translate(suspension_mount_offset)
                    rotate([90, 0, 0])
                        cube([50, 20, 12.3+0.2], center = true);

            }

            // Vnejsi cast na pripevneni trubek
            union(){
                rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                    cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40);

                rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, 180 - chassis_pipe_angle_z])
                    cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40);
            }

            translate([-10, -20, 0])
                cube([40, 40, 8]);

        }

        // diry na licovany sroub skrz kulove lozisko
        union(){
            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    cylinder(d = suspension_bolt_diameter, h = suspension_bolt_length + 10 + 30, center = true, $fn = 80);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, suspension_bolt_length/2])
                        cylinder(d =M6_nut_diameter, h = 50, $fn = 6);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, -suspension_bolt_length/2 - 50])
                        cylinder(d = 15, h = 50, $fn = 60);

        }


        // diry pro trubky ramen podvozku
        union(){
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                translate([0, 0, suspension_mount_pipe_end])
                    cylinder(d = tube_for_undercarriage_outer_diameter, h = 40, $fn = 60);

            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, 180 - chassis_pipe_angle_z])
                translate([0, 0, suspension_mount_pipe_end])
                    cylinder(d = tube_for_undercarriage_outer_diameter, h = 40, $fn = 60);

            // sroub skrze trubku
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                translate([0, 0, global_clearance+suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_screw_diameter, h = 40, center=true, $fn = 60);
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                translate([0, -suspension_pipe_screw_length/2, global_clearance+suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 40, $fn = 6);
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                translate([0, 40 + suspension_pipe_screw_length/2, global_clearance+suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 40, $fn = 66);

            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, 180 - chassis_pipe_angle_z])
                translate([0, 0, global_clearance + suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_screw_diameter, h = 40, center=true, $fn = 60);
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, 180 - chassis_pipe_angle_z])
                translate([0, -suspension_pipe_screw_length/2, global_clearance+suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 40, $fn = 6);
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, 180 - chassis_pipe_angle_z])
                translate([0, 40 + suspension_pipe_screw_length/2, global_clearance+suspension_mount_pipe_end + 15])
                    rotate([90, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 40, $fn = 66);


            // Diry na srouby pro sesroubovani do vidlice
            translate([suspension_mount_offset[0]+10, 0, 0])
                cylinder(h = 50, d = M3_screw_diameter, $fn = 60);
            translate([suspension_mount_offset[0]+10, 0, 4])
                cylinder(h = 50, d = M3_nut_diameter, $fn = 60);

            translate([suspension_mount_offset[0]-10, 0, 0])
                cylinder(h = 50, d = M3_screw_diameter, $fn = 60);
            translate([suspension_mount_offset[0]-10, 0, 4])
                cylinder(h = 50, d = M3_nut_diameter, $fn = 60);


            translate([-250, -250, -500])
                cube(500);
        }
    }
}



888_2017();
