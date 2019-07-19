include <../parameters.scad>


module 888_2017(){

    suspension_bolt_length = 20+1;
    suspension_pipe_screw_length = 20 - M3_nut_height*2;                        // delka sroubu skrz tenkou trubu
    suspension_wall_thickness = 4;                                              // tloustka materialu okolo trubky ramena podvozku
    suspension_bolt_diameter = M8_screw_diameter;                               // prumer licovaneho sroubu
    suspension_mount_offset = [2017_bearing_mount_offset[2], 2017_bearing_mount_offset[0], 2017_bearing_mount_offset[1]];                                       // Umisteni osy kuloveho loziska v souradnicovem syst. dilu
    pipe_mount_offset = [2017_pipe_mount_offset[2], 2017_pipe_mount_offset[0], 2017_pipe_mount_offset[1]];                                        // Umisteni tyce podvozku loziska v souradnicovem syst. dilu
    suspension_mount_pipe_end = 2017_pipe_bottom;                                              // Jak daleko nad zemi konci tyc


    vec_r = [chassis_height, -chassis_pipe_baselength_r, chassis_pipe_wheelbase];
    vec_f = [chassis_height, chassis_pipe_baselength_f, chassis_pipe_wheelbase];


    difference(){
        union(){

            // sloupek pro pridelani kuloveho kloubu
            difference(){
                hull(){
                    translate(suspension_mount_offset)
                        rotate([90, 0, 0])
                            cylinder(d = suspension_bolt_diameter + 8, h = suspension_bolt_length + 10, center = true, $fn = 100);

                    translate([suspension_mount_offset[0], 0, 4])
                        cube([30, 40, 8], center = true);
                }


                // vyrez pro kulovy cep na pistnici
                translate(suspension_mount_offset)
                    rotate([90, 0, 0])
                        cube([50, 20, 12.3+0.2], center = true);
            }

            // Vnejsi cast na pripevneni trubek
            union(){
                translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                    orientate(vec_r)
                        cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = 80);

                translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                    orientate(vec_f)
                        cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = 80);

                /* %translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                    orientate(vec_r)
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = mod(vec_r), $fn = 80);

                %translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                    orientate(vec_f)
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = mod(vec_f), $fn = 80); */
            }

            translate([-50, -40/2, 0])
                cube([50, 40, 8]);

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

            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, suspension_mount_pipe_end])
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = 50, $fn = 60);

            // sroub skrze trubku
            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 15])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = 60);
                            translate([0,0, suspension_pipe_screw_length/2])
                                    cylinder(d = M3_nut_diameter, h = 40, $fn = 60);
                            translate([0,0, -suspension_pipe_screw_length/2 - 5])
                                    cylinder(d = M3_nut_diameter, h = 5, $fn = 6);
                        }


            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, suspension_mount_pipe_end])
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = 50, $fn = 60);

            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 15])
                        rotate([90, 0, 0]){

                            cylinder(d = M3_screw_diameter, h = 20, center=true, $fn = 60);
                            translate([0, 0, -suspension_pipe_screw_length/2 -20])
                                cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
                            translate([0, 0, suspension_pipe_screw_length/2])
                                cylinder(d = M3_nut_diameter, h = 5, $fn = 6);
                    }

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



mirror([0,1,0])
    888_2017();
