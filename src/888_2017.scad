include <../parameters.scad>
draft = true;

module 888_2017(right = 0, draft, print_orientation = 0){

    suspension_bolt_length = 20+1;
    suspension_pipe_screw_length = 20 - M3_nut_height*2;                        // delka sroubu skrz tenkou trubu
    suspension_wall_thickness = 4;                                              // tloustka materialu okolo trubky ramena podvozku
    suspension_bolt_diameter = M4_screw_diameter;                               // prumer licovaneho sroubu
    suspension_mount_offset = [2017_bearing_mount_offset[2], 2017_bearing_mount_offset[0], 2017_bearing_mount_offset[1]];                                       // Umisteni osy kuloveho loziska v souradnicovem syst. dilu
    pipe_mount_offset = [2017_pipe_mount_offset[2], 2017_pipe_mount_offset[0], 2017_pipe_mount_offset[1]];                                        // Umisteni tyce podvozku loziska v souradnicovem syst. dilu
    suspension_mount_pipe_end = 2017_pipe_bottom;                                              // Jak daleko nad zemi konci tyc
    fork_cutout_width = 20+1;

    vec_r = [chassis_height, chassis_pipe_baselength_r, chassis_pipe_wheelbase];
    vec_f = [chassis_height, -chassis_pipe_baselength_f, chassis_pipe_wheelbase];

    rotate([180, 0, 0] * print_orientation)
    orientate([chassis_height, 0, chassis_pipe_wheelbase/2+10/2] * print_orientation)
    
    mirror([0, 1, 0]*right)
    difference(){
        union(){

            // sloupek pro pridelani kuloveho kloubu
            difference(){
                hull(){
                    translate(suspension_mount_offset)
                        rotate([90, 0, 0])
                            cylinder(d = suspension_bolt_diameter + 8, h = suspension_bolt_length + 18, center = true, $fn = 100);

                    translate([suspension_mount_offset[0], 0, 0])
                        cube([5, 30, 2], center = true);
                //}
                // Vnejsi cast na pripevneni trubek
                //hull(){
                    translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                        orientate(vec_f)
                            cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = 80);

                    translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                        orientate(vec_r)
                            cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = 80);

                }
            }
        }

        // diry na licovany sroub skrz kulove lozisko
        union(){
            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    cylinder(d = suspension_bolt_diameter, h = suspension_bolt_length + 10 + 30, center = true, $fn = 80);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, suspension_bolt_length/2])
                        cylinder(d =M4_nut_diameter, h = 50, $fn = 6);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, -suspension_bolt_length/2 - 50])
                        cylinder(d = M4_nut_diameter, h = 50, $fn = 60);

            hull(){
                translate(suspension_mount_offset)
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = 100);
                translate(suspension_mount_offset + [0, 0, 100])
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = 100);
                translate(suspension_mount_offset + [20, 0, 5])
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = 100);
            }

        }


        // diry pro trubky ramen podvozku
        union(){

            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, suspension_mount_pipe_end])
                        #cylinder(d = tube_for_undercarriage_outer_diameter, h = 400, $fn = draft? 15 : 60);

            // sroub skrze trubku
            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 15])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = draft? 15 : 60);
                            translate([0,0, suspension_pipe_screw_length/2])
                                    cylinder(d = M3_nut_diameter, h = 40, $fn = draft? 15 :60);
                            translate([0,0, -suspension_pipe_screw_length/2 - M3_nut_height/2])
                                rotate([0, 0, 30])
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            translate([-100 , -M3_nut_diameter/2, -suspension_pipe_screw_length/2 - M3_nut_height/2])
                                cube([100, M3_nut_diameter, M3_nut_height]);
                        }

            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 35])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = draft? 15 : 60);
                            translate([0,0, suspension_pipe_screw_length/2])
                                    cylinder(d = M3_nut_diameter, h = 40, $fn = draft? 15 :60);
                            translate([0,0, -suspension_pipe_screw_length/2 - M3_nut_height/2])
                                rotate([0, 0, 30])
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            translate([-100 , -M3_nut_diameter/2, -suspension_pipe_screw_length/2 - M3_nut_height/2])
                                cube([100, M3_nut_diameter, M3_nut_height]);
                        }


            // Dira pro tyc k podvozku
            #translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, suspension_mount_pipe_end])
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = 400, $fn = draft? 15 : 60);

            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 10+5])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = 60);
                            translate([0, 0, -suspension_pipe_screw_length/2 -20])
                                cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
                            translate([0,0, suspension_pipe_screw_length/2 - M3_nut_height/2])
                                rotate([0, 0, 30])
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            translate([-100 , -M3_nut_diameter/2, suspension_pipe_screw_length/2 - M3_nut_height/2])
                                cube([100, M3_nut_diameter, M3_nut_height]);
                    }

            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 10+25])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = 60);
                            translate([0, 0, -suspension_pipe_screw_length/2 -20])
                                cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
                            translate([0,0, suspension_pipe_screw_length/2 - M3_nut_height/2])
                                rotate([0, 0, 30])
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            translate([-100 , -M3_nut_diameter/2, suspension_pipe_screw_length/2 - M3_nut_height/2])
                                cube([100, M3_nut_diameter, M3_nut_height]);
                    }

            rotate([0, chassis_camber, 0]){
                // Diry na srouby pro sesroubovani do vidlice
                translate([suspension_mount_offset[0]+10 - 25, 0, 0])
                    cylinder(h = 50, d = M4_screw_diameter, $fn = 60);
                translate([suspension_mount_offset[0]+10 - 25, 0, 8+5])
                    cylinder(h = 50, d = M4_nut_diameter, $fn = 60);

                translate([suspension_mount_offset[0]-10 - 25, 0, 0])
                    cylinder(h = 50, d = M4_screw_diameter, $fn = 60);
                translate([suspension_mount_offset[0]-10 - 25, 0, 8+5])
                    cylinder(h = 50, d = M4_nut_diameter, $fn = 60);
            }

            /* translate([0, 0, -0.1])
                linear_extrude(0.9)
                    translate([-20, -5, 0]) rotate([180, 0, 0]) text("888_2017", size = 5, halign = "center");

            translate([0, 0, -0.1])
                linear_extrude(0.9)
                    translate([-20, 8, 0]) rotate([180, 0, 0]) text(right? "Right": "Left", size = 5, halign = "center"); */


            //rotate([0, chassis_camber, 0])
                //translate([-250, -250, -500])
                  //  cube(500);

            rotate([0, chassis_camber, 0])
                translate([-250, -fork_cutout_width/2, -500+3])
                    cube([500, fork_cutout_width, 500]);
        }
    }
}



mirror([0,1,0])
    888_2017(right = 1, draft = draft);
