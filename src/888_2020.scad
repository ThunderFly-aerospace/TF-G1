include <../parameters.scad>
use <lib/igus.scad>
$fn = 70;

module 888_2020(){

    thickness = 8;
    width = chassis_bearing_distance + kstm_flange_length(8) + 10;
    length = chassis_pipe_baselength_f + 10;

    difference(){
        union(){
            translate([0, -width/2, 0])
                cube([length, width, thickness]);

            translate([0, -width/2, 0])
                cube([5, width, thickness + 10]);
        }

        rotate([0, -90, 0]){
            translate([thickness+5, 0, 0])
                cylinder(d = M3_screw_diameter, h = 100, center = true);

            translate([thickness+5, width/3, 0])
                cylinder(d = M3_screw_diameter, h = 100, center = true);

            translate([thickness+5, -width/3, 0])
                cylinder(d = M3_screw_diameter, h = 100, center = true);


        }

        translate([chassis_pipe_baselength_f, 0, -global_clearance]){
            translate([0, -chassis_bearing_distance/2 - kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);

            translate([0, -chassis_bearing_distance/2 + kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);


            translate([0, chassis_bearing_distance/2 + kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);

            translate([0, chassis_bearing_distance/2 - kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);
        }


        translate([chassis_pipe_baselength_r, 0, -global_clearance]){
            translate([0, -chassis_bearing_distance/2 - kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);

            translate([0, -chassis_bearing_distance/2 + kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);


            translate([0, chassis_bearing_distance/2 + kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);

            translate([0, chassis_bearing_distance/2 - kstm_flange_holes_distance(8)/2, 0])
                cylinder(d = M3_screw_diameter, h = 100);
        }


        translate([main_tube_outer_diameter/2, 0, -global_clearance]){
            translate([0, 0, 0])
                cylinder(d = M3_screw_diameter, h = 100);

            translate([0, -(chassis_top_bearing_position_y+10 + M3_nut_diameter), 0])
                cylinder(d = M3_screw_diameter, h = 100);


            translate([0, (chassis_top_bearing_position_y+10 + M3_nut_diameter), 0])
                cylinder(d = M3_screw_diameter, h = 100);

        }

    }


}

888_2020();
