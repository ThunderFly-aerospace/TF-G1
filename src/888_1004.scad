include <../parameters.scad>


module beam_profile(l = 100){
    difference(){
        translate([l/2, 0, 0])
            cube([l, beam_width, beam_thickness], center = true);

        for (i=[0,2])
            translate([-global_clearance/2, 0, 0])
                rotate([90*i, 0, 0])
                    translate([0, -beam_width/2, 0]){
                        rotate([90-beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);

                        rotate([180+beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);
                    }

        translate([-global_clearance/2, -beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_thickness, h = l + global_clearance, $fn = 50);

        translate([-global_clearance/2, beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_thickness, h = l + global_clearance, $fn = 50);
    }
}

module beam_plug(l = 100, side_pipes = true){
    difference(){
        translate([l/2 - global_clearance, 0, 0])
            cube([l, beam_width, beam_thickness], center = true);

        for (i=[0,2])
            translate([-global_clearance*1.5, 0, 0])
                rotate([90*i, 0, 0])
                    translate([0, -beam_width/2 - global_clearance, 0]){
                        rotate([90-beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);

                        rotate([180+beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);
                    }
/*

        for (i=[0:n])
            translate([i*patern+patern/2, 0, 0]){
                for (k=[1,-1])
                    for (j=[1, -1]) translate([5*k, j*beam_main_pipe_distance/2, 0]){
                        cylinder(d = M3_screw_diameter, h = beam_thickness, center = true, $fn = 50);
                        translate([0, 0, k*(beam_main_pipe_thickness+beam_vertical_space_between_pipes) + screw_length/2]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
                        translate([0, 0, k*(beam_main_pipe_thickness+beam_vertical_space_between_pipes) - screw_length/2 - beam_thickness]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
                    }

                // diry pro pricne tyce
                for (j=[1, -1]) translate([5*j, 0, j*(beam_main_pipe_thickness+beam_vertical_space_between_pipes)]){
                    rotate([90, 0, 0]) cylinder(d = beam_main_pipe_thickness, h = beam_width, center = true, $fn = 50);
                }
            }



    */

    }
}

module beam_holes_patern(n = 1){

    screw_length = 20 - M3_nut_height*1.5;
    screw2_length = beam_main_pipe_thickness*3+6;
    patern = beam_patern;

    for (i=[1:n])
        translate([i*patern, 0, 0]){


            // diry pro pricne tyce
            for (j=[1, -1]) translate([5*j, 0, j*(beam_main_pipe_thickness+beam_vertical_space_between_pipes)]){
                rotate([90, 0, 0]) cylinder(d = beam_main_pipe_thickness, h = beam_width, center = true, $fn = 50);
            }

            for (k=[1,-1])
                for (j=[1, -1]) translate([5*k, j*(beam_main_pipe_distance/2-beam_main_pipe_thickness/2-2), 0]){
                    cylinder(d = M3_screw_diameter, h = beam_thickness, center = true, $fn = 50);
                    translate([0, 0, k*(beam_main_pipe_thickness+beam_vertical_space_between_pipes) + screw_length/2]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
                    translate([0, 0, k*(beam_main_pipe_thickness+beam_vertical_space_between_pipes) - screw_length/2 - beam_thickness]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
                }


            // diry skrz podelnou trubku
            for (j=[1, -1]) translate([patern/2, j*(beam_main_pipe_distance/2), 0]){
                cylinder(d = M3_screw_diameter, h = beam_thickness, center = true, $fn = 50);
                translate([0, 0, + screw_length/2]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
                translate([0, 0, - screw_length/2 - beam_thickness]) cylinder(d = M3_nut_diameter, h = beam_thickness, $fn = 6);
            }

            // diry pro bocni pripevneni
            for (j=[0, 1]) mirror([0, j, 0]) translate([patern/2, 0, 0]){
                translate([0, beam_width/2, 0])
                    rotate([90, 0, 0])
                        cylinder(d = M4_screw_diameter, h = beam_width - beam_main_pipe_distance-12, center = true, $fn = 50);

                translate([0, beam_width/2 - 8, 0])
                    rotate([90, 0, 0])
                        cylinder(d = M4_nut_diameter, h = M3_nut_height, $fn = 6);

                translate([-M3_nut_diameter/2, beam_width/2 - 8 - M3_nut_height, 0])
                    cube([M3_nut_diameter, M3_nut_height, 50]);
            }

            // stredove M4 diry
            translate([patern/2, 0, 0]){
                cylinder(d = M4_screw_diameter, h = beam_thickness, center = true, $fn = 50);
                translate([0, 0, screw_length/2]) cylinder(d = M4_nut_diameter, h = beam_thickness, $fn = 6);
                translate([0, 0, -screw_length/2-beam_thickness]) cylinder(d = M4_nut_diameter, h = beam_thickness, $fn = 6);
            }
        }

        // motor mount
        for(i = [-1, 1])
        translate([patern/2, i*(beam_main_pipe_distance/2-beam_main_pipe_thickness-3), 0]){
            cylinder(d = M4_screw_diameter, h = beam_thickness, center = true, $fn = 50);
            translate([0, 0, -beam_thickness*1.5 + M4_nut_height*2]) cylinder(d = M4_nut_diameter, h = beam_thickness, $fn = 6);
            translate([0, 0, beam_thickness/2 - M4_nut_height*2]) cylinder(d = M4_nut_diameter, h = beam_thickness, $fn = 6);
        }

        rotate([0, 90, 0])
            for (i=[1,-1])
                for (j=[-1,1])
                    translate([15*j, 10*i, -global_clearance]){
                        cylinder(d = M4_screw_diameter, h = 15, $fn = 50);
                        translate([0, 0, 7]) cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
                        translate([0, i*20, 7+M4_nut_height/2]) cube([M4_nut_diameter, 40, M4_nut_height], center = true);
                    }


}

module 888_1004(){

    difference(){
        beam_profile(beam_length + engine_holder_beam_depth);
        beam_holes_patern((beam_length+engine_holder_beam_depth)/30);

    }
}

888_1004();
