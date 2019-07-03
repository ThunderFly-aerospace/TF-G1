include <../parameters.scad>
use <888_2013.scad>
use <lib/igus.scad>
use <666_1027.scad>

color([0.2, 0.4, 0.4, 0.5]) translate([-second_undercarriage_hole,0,main_tube_outer_diameter/2+2]) rotate([90,0,0]) 666_1027();


translate([-chassis_baselength/2, 0, 0]){
    rotate([180, 0, 0])
        888_2013();
translate(chassis_top_bearing_position)
    rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, -chassis_pipe_angle_z])
            rotate([90, 0, 0])
                    kstm_10();
mirror([0, 1, 0])
    translate(chassis_top_bearing_position)
        rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, -chassis_pipe_angle_z])
                rotate([90, 0, 0])
                        kstm_10();
}

mirror([1, 0, 0])
    translate([-chassis_baselength/2, 0, 0]){
        rotate([180, 0, 0])
            888_2013();
        translate(chassis_top_bearing_position)
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, -chassis_pipe_angle_z])
                    rotate([90, 0, 0])
                            kstm_10();
        mirror([0, 1, 0])
            translate(chassis_top_bearing_position)
                rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, -chassis_pipe_angle_z])
                        rotate([90, 0, 0])
                                kstm_10();
    }
