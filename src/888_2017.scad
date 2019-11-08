
// Drzak vidlice podvozku

include <../parameters.scad>
draft = $preview;

module 888_2017(left = 0, draft = true, print_orientation = 0){

    suspension_bolt_length = 20+1;
    suspension_pipe_screw_length = 20 - M3_nut_height*2;                        // delka sroubu skrz tenkou trubu
    suspension_wall_thickness = 4;                                              // tloustka materialu okolo trubky ramena podvozku
    suspension_bolt_diameter = M4_screw_diameter;                               // prumer licovaneho sroubu
    suspension_mount_offset = [2017_bearing_mount_offset[2], 2017_bearing_mount_offset[0], 2017_bearing_mount_offset[1]];                                       // Umisteni osy kuloveho loziska v souradnicovem syst. dilu
    pipe_mount_offset = [2017_pipe_mount_offset[2], 2017_pipe_mount_offset[0], 2017_pipe_mount_offset[1]];                                        // Umisteni tyce podvozku loziska v souradnicovem syst. dilu
    suspension_mount_pipe_end = 2017_pipe_bottom;                                              // Jak daleko nad zemi konci tyc
    fork_cutout_width = 20+1;

    vec_r = [chassis_height+2, chassis_pipe_baselength_r + beam_patern/2 - 2017_pipe_mount_offset[0]/2 - global_clearance, chassis_pipe_wheelbase - chassis_top_bearing_position_y/2];
    vec_f = [chassis_height+2, -chassis_pipe_baselength_f + beam_patern/2 + 2017_pipe_mount_offset[0]/2 + global_clearance, chassis_pipe_wheelbase - chassis_top_bearing_position_y/2];

    rotate([180, 0, 0] * print_orientation)
    orientate([chassis_height, 0, chassis_pipe_wheelbase/2+10/2] * print_orientation)
    
    mirror([0, 1, 0]*left)
    difference(){
        union(){

            // sloupek pro pridelani kuloveho kloubu
            difference(){
                hull(){
                    translate(suspension_mount_offset)
                        rotate([90, 0, 0])
                            cylinder(d = suspension_bolt_diameter + 8, h = suspension_bolt_length + 18, center = true, $fn = draft? 35:100);

                    translate([suspension_mount_offset[0], 0, -3])
                        cube([5, 30, 2], center = true);
                //}
                // Vnejsi cast na pripevneni trubek
                //hull(){
                    translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                        orientate(vec_f)
                            cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = draft? 35:100);

                    translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                        orientate(vec_r)
                            cylinder(d = tube_for_undercarriage_outer_diameter + suspension_wall_thickness*2, h = 40 + 10, $fn = draft? 35:100);

                }
            }
        }

        // diry na licovany sroub skrz kulove lozisko
        union(){
            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    cylinder(d = suspension_bolt_diameter, h = suspension_bolt_length + 10 + 30, center = true, $fn = draft? 15:60);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, suspension_bolt_length/2])
                        cylinder(d =M4_nut_diameter, h = 50, $fn = draft? 15:6);

            translate(suspension_mount_offset)
                rotate([90, 0, 0])
                    translate([0, 0, -suspension_bolt_length/2 - 50])
                        cylinder(d = M4_nut_diameter, h = 50, $fn = draft? 15:60);

            hull(){
                translate(suspension_mount_offset)
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = draft? 15 :100);
                translate(suspension_mount_offset + [-15, 0, 100])
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = draft? 15 :100);
                translate(suspension_mount_offset + [20, 0, 5])
                    rotate([90, 0, 0])
                        cylinder(d = 27, h = 12.5, center = true, $fn = draft? 15 :100);
            }

        }


        // diry pro trubky ramen podvozku
        union(){

            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, suspension_mount_pipe_end])
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = 400, $fn = draft? 15 : 100);

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
                        cylinder(d = tube_for_undercarriage_outer_diameter, h = 400, $fn = draft? 10 : 100);

            // otvory pro matky s kapsou
            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, global_clearance+suspension_mount_pipe_end + 10+5])
                        rotate([90, 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = draft? 15 :60);
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
                            cylinder(d = M3_screw_diameter, h = 30, center=true, $fn = draft? 15 :60);
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
                    cylinder(h = 50, d = M4_screw_diameter, $fn = draft? 15 :60);
                translate([suspension_mount_offset[0]+10 - 25, 0, 8+5])
                    cylinder(h = 50, d = M4_nut_diameter, $fn = 60);

                translate([suspension_mount_offset[0]-10 - 25, 0, 0])
                    cylinder(h = 50, d = M4_screw_diameter, $fn = draft? 15 :60);
                translate([suspension_mount_offset[0]-10 - 25, 0, 8+5])
                    cylinder(h = 50, d = M4_nut_diameter, $fn = 60);
            }

            rotate([0, chassis_camber, 0])
                translate([0, 0, -0.8])
                    linear_extrude(1)
                        translate([-20, -5, 0]) rotate([180, 0, 0]) text("888_2017", size = 3, halign = "center");

            rotate([0, chassis_camber, 0])
                translate([0, 0, -0.8])
                    linear_extrude(1)
                        translate([-20, 8, 0]) rotate([180, 0, 0]) text(left? "Left": "Right", size = 5, halign = "center");


            // vyriznuti zapusteni pro vidlici kolecka
            rotate([0, chassis_camber, 0])
                translate([-250, -fork_cutout_width/2, -500])
                    cube([500, fork_cutout_width, 500]);
        }
    }
}

module 888_2017_pipe_front(draft = draft){
    pipe_mount_offset = [2017_pipe_mount_offset[2], 2017_pipe_mount_offset[0], 2017_pipe_mount_offset[1]];
    vec_f = [chassis_height+2, chassis_pipe_baselength_f - beam_patern/2 - 2017_pipe_mount_offset[0]/2 + global_clearance, chassis_pipe_wheelbase - chassis_top_bearing_position_y/2];
    length = mod(vec_f) - 20;

            translate([pipe_mount_offset[0], pipe_mount_offset[1], 0])
                orientate(vec_f)
                    translate([0, 0, 2017_pipe_bottom+global_clearance/2])
                        difference(){
                            cylinder(d = tube_for_undercarriage_outer_diameter, h = length, $fn = draft? 15 : 100);
                            cylinder(d = tube_for_undercarriage_outer_diameter-3, h = length+1, $fn = draft? 15 : 100);

                            translate([0, 0, 15])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 20, center= true, $fn= draft? 8:30);

                            translate([0, 0, 15+20])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 20, center= true, $fn= draft? 8:30);

                            translate([0, 0, length - 5])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 40, center= true, $fn= draft? 8:30);


                            translate([0, 0, length - 5-15])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 40, center= true, $fn= draft? 8:30);
                        }
}


module 888_2017_pipe_rear(draft = draft){
    pipe_mount_offset = [2017_pipe_mount_offset[2], 2017_pipe_mount_offset[0], 2017_pipe_mount_offset[1]];    
    vec_r = [chassis_height+2, -chassis_pipe_baselength_r-beam_patern/2+2017_pipe_mount_offset[0]/2 - global_clearance, chassis_pipe_wheelbase-chassis_top_bearing_position_y/2];
    length = mod(vec_r) - 20;

            translate([pipe_mount_offset[0], -pipe_mount_offset[1], 0])
                orientate(vec_r)
                    translate([0, 0, 2017_pipe_bottom+global_clearance/2])
                        difference(){
                            cylinder(d = tube_for_undercarriage_outer_diameter, h = length, $fn = draft? 15 : 100);
                            cylinder(d = tube_for_undercarriage_outer_diameter-3, h = length+1, $fn = draft? 15 : 100);

                            translate([0, 0, 15])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 20, center= true, $fn= draft? 8:30);

                            translate([0, 0, 15+20])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 20, center= true, $fn= draft? 8:30);

                            translate([0, 0, length - 5])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 40, center= true, $fn= draft? 8:30);


                            translate([0, 0, length - 5-15])
                                rotate([90, 0, 0])
                                    cylinder(d= M3_screw_diameter, h= 40, center= true, $fn= draft? 8:30);
                        }
}


color("blue")
    888_2017_pipe_rear();

color("blue")
    888_2017_pipe_front();


888_2017(left = 1, draft = draft);
