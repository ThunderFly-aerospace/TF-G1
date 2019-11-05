//========== drzak KSTM lozisek podvozku pod nosnikem virniku ==========//

include <../parameters.scad>
use <lib/vector.scad>
use <lib/igus.scad>

kstm_width = 9;
kstm_length = 47;
kstm_holes = 35;
kstm_center_height = 10;
kstm_screw = 4;

draft = true;

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


module 888_2027(front = true) {

    tran_f = [0, chassis_top_bearing_position_y, -chassis_top_bearing_position_z];
    vec_f = [front? chassis_baselength_f-2017_pipe_mount_offset[0]:chassis_baselength_r-2017_pipe_mount_offset[0], -chassis_pipe_wheelbase+chassis_top_bearing_position_z/2, chassis_height];

    /*translate([0, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
        orientate(vec_f){
            rotate([180, 0, 90]) kstm_08();
        }
    mirror([0,1,0])
    translate([0, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
        orientate(vec_f){
            rotate([180, 0, 90]) kstm_08();
        }
    */

    difference() {
        hull(){

            translate(tran_f)
                orientate(vec_f)
                    translate([0, 0, kstm_center_height])
                        hull(){
                            translate([0, (kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                            translate([0, -(kstm_length-kstm_width)/2, 0])
                                cylinder(d = kstm_width, h = 1);
                        }

            mirror([0, 1, 0])
            #translate(tran_f)
                orientate(vec_f)
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
        translate(tran_f)
            orientate(vec_f)
                translate([0, 0, kstm_center_height])
                    holes();
        mirror([0, 1, 0])
        translate(tran_f)
            orientate(vec_f)
                translate([0, 0, kstm_center_height])
                    holes();


        /* translate([0, 0, -100])
            cylinder(d = M3_screw_diameter, h = 100);
        translate([0, 0, -105])
            cylinder(d = M3_nut_diameter, h = 100, $fn = 6); */

        translate([beam_patern/4, 0, -100])
            cylinder(d = M3_screw_diameter, h = 100);
        translate([beam_patern/4, 0, -105])
            cylinder(d = M3_nut_diameter, h = 100, $fn = 6);

        translate([-beam_patern/4, 0, -100])
            cylinder(d = M3_screw_diameter, h = 100);
        translate([-beam_patern/4, 0, -105])
            cylinder(d = M3_nut_diameter, h = 100, $fn = 6);


        translate([0, 0, -0.3])
            rotate([0, 0, 90])
                linear_extrude(0.5)
                    text(front?"front":"rear", halign = "center", valign = "center", size = 8);


    }
}

888_2027(front = true);
