// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>

draft = true;

module 888_1031(){
    difference(){
        hull(){
        translate([-beam_patern/2, 0, -beam_thickness/4])
            cube([beam_patern, beam_width/2+pilon_pipe_diameter+15, beam_thickness/2]);

        for (i=[-beam_patern/2, beam_patern/2])
            translate([i, 0, 0])
                rotate([-90, 0, 0])
                    cylinder(d = M4_nut_diameter+8, h = beam_width/2+pilon_pipe_diameter+15, $fn = draft? 20 : 60);
        }

        translate([-30, 0, 0])
            beam_plug();

        for (i=[-beam_patern/2, beam_patern/2]) {
            translate([i, 0, 0])
                rotate([-90, 0, 0]){
                    cylinder(d = M4_screw_diameter, h = 100, $fn =  draft? 20 : 60);
                    translate([0, 0, beam_width/2 + 10])
                        cylinder(d = M4_nut_diameter, h = 100, $fn =  draft? 20 : 60);

                }
        }

        translate([0, pilon_pipe_base_front_y, pilon_pipe_base_front_z])
            orientate([-pilon_pipe_base_front_x + pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), height_of_vertical_tube-pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                union(){
                    translate([0, 0, -20])
                        cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 60);

                    rotate([90, 0, 0]){
                        cylinder(d = M3_screw_diameter, h = 50, center = true, $fn =  draft? 20 : 60);
                        translate([0, 0,-beam_main_pipe_thickness/2-2-50]) cylinder(d = M3_nut_diameter, h = 50, $fn =  draft? 20 : 60);
                        translate([0, 0, pilon_pipe_diameter/2+2]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-M3_nut_diameter/2, 0, pilon_pipe_diameter/2+2]) cube([M3_nut_diameter, 50, M3_nut_height]);
                    }
            }
    }
}

888_1031();
