// patka pro pridelani zadni tyce pylonu k nosniku
include <../parameters.scad>
draft = true;

module 888_1030(){

    offset = 0;
    thickness = 8;
    thickness_below_head = thickness - M4_screw_head_height;
    difference(){
        hull(){
            cylinder(h = thickness, d = M4_nut_diameter+5);
            translate([beam_patern, 0, 0])
                cylinder(h = thickness, d = M4_nut_diameter+5);
            translate([beam_patern/2 + offset, 0, 0])
                cylinder( d = pilon_pipe_diameter+10, h = 2);

            translate([beam_patern/2 + offset, 0, 0])
            orientate([+pilon_pipe_base_rear_x-pilon_pipe_head_rear_x, 0, height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
                translate([0, 0, 0+5])
                    cylinder(d = pilon_pipe_diameter+10, h = 15, $fn = draft? 20 : 50);

        }

        translate([beam_patern/2 + offset, 0, 0])
            orientate([+pilon_pipe_base_rear_x-pilon_pipe_head_rear_x, 0, height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
                translate([0, 0, 0+5])
                    cylinder(d = pilon_pipe_diameter, h = 100, $fn = draft? 20 : 50);

        translate([beam_patern/2 + offset, 0, 0])
            orientate([+pilon_pipe_base_rear_x-pilon_pipe_head_rear_x, 0, height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
                translate([0, 0, 5+10])
                    rotate([90, 0, 0]){
                        cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 50);
                        translate([0, 0, 15/2])
                            cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
                        translate([0, 0, -15/2-20])
                            cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
                    }

        cylinder(h = thickness, d = M4_screw_diameter);

        translate([beam_patern, 0, 0])
            cylinder(h = thickness, d = M4_screw_diameter);

        translate([0, 0, thickness_below_head]) {
            cylinder(h = 20, d = M4_nut_diameter);
            translate([beam_patern, 0, 0])
                cylinder(h = 20, d = M4_nut_diameter);
        }
    }
}


888_1030();
