//========== drzak KSTM lozisek podvozku pod nosnikem virniku ==========//

include <../parameters.scad>
use <lib/vector.scad>

kstm_width = 9;
kstm_length = 47;
kstm_holes = 35;
kstm_center_height = 10;
kstm_screw = 4;


module holes(){
    rotate([180, 0, 0]){
        translate([0, (kstm_holes)/2, -5+layer])
            cylinder(d = M4_screw_diameter, h = 20, $fn = 30);
        translate([0, (kstm_holes)/2, -5 - 10])
            cylinder(d = M4_screw_diameter, h = 9, $fn = 30);

        translate([0, (kstm_holes)/2, -M4_nut_height - 5])
            rotate(30)
                cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
        translate([0, -M4_nut_diameter/2 + kstm_holes/2, -5 - M4_nut_height])
            cube([20, M4_nut_diameter, M4_nut_height]);


        translate([0, -(kstm_holes)/2, -5+layer])
            cylinder(d = M4_screw_diameter, h = 20, $fn = 30);
        translate([0, -(kstm_holes)/2, -5 - 10])
            cylinder(d = M4_screw_diameter, h = 9, $fn = 30);

        translate([0, -(kstm_holes)/2, -M4_nut_height - 5])
            rotate(30)
                cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
        translate([0, -M4_nut_diameter/2 - kstm_holes/2, -5 - M4_nut_height])
            cube([20, M4_nut_diameter, M4_nut_height]);
    }
}

//holes();

//translate([chassis_baselength_f, chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
//    orientate([chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])


module 888_2027(baselength) {
    difference() {
        hull(){

            translate([0, chassis_top_bearing_position_y, -chassis_top_bearing_position_z  - kstm_center_height])
                orientate([baselength, -chassis_pipe_wheelbase, chassis_height])
                    translate([0, 0, kstm_center_height])
                        hull(){
                            translate([0, (kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                            translate([0, -(kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                        }
            translate([0, -chassis_top_bearing_position_y, -chassis_top_bearing_position_z  - kstm_center_height])
                orientate([baselength, chassis_pipe_wheelbase, chassis_height])
                    translate([0, 0, kstm_center_height])
                        hull(){
                            translate([0, (kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                            translate([0, -(kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                        }
            translate([-15, -30, -1])
                cube([30, 60, 1]);
        }

        // diry pro prisroubovani KSTM lozisek
        translate([0, -chassis_top_bearing_position_y, -chassis_top_bearing_position_z  - kstm_center_height])
            orientate([baselength, chassis_pipe_wheelbase, chassis_height])
                translate([0, 0, kstm_center_height])
                    holes();
        translate([0, chassis_top_bearing_position_y, -chassis_top_bearing_position_z  - kstm_center_height])
            orientate([baselength, -chassis_pipe_wheelbase, chassis_height])
                translate([0, 0, kstm_center_height])
                    holes();

        translate([0, 0, -100])
            cylinder(d = M4_screw_diameter, h = 100);
        translate([0, 0, -110])
            cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
        

        /* for (i=[-5:5]) {
            #translate([beam_patern*i - chassis_suspension_basewidth/2, 0, -100]) {
                cylinder(d = M4_screw_diameter, h = 100);

                translate([0, 0, -10]) {
                    cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
                }
            }
        } */

    }

}

888_2027();
