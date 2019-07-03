include <../parameters.scad>
use <888_2013.scad>
use <lib/igus.scad>


translate([chassis_baselength/2, 0, 0]){
888_2013();
translate(chassis_top_bearing_position)
    rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
        translate([0, -19, 0])
            rotate([90, 0, 0])
                    kstm_10();
mirror([0, 1, 0])
    888_2013();
mirror([0, 1, 0])
    translate(chassis_top_bearing_position)
        rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
            translate([0, -19, 0])
                rotate([90, 0, 0])
                        kstm_10();
}

mirror([1, 0, 0])
    translate([chassis_baselength/2, 0, 0]){
        888_2013();
        translate(chassis_top_bearing_position)
            rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                translate([0, -19, 0])
                    rotate([90, 0, 0])
                            kstm_10();
        mirror([0, 1, 0])
            888_2013();
        mirror([0, 1, 0])
            translate(chassis_top_bearing_position)
                rotate([chassis_pipe_angle_x, chassis_pipe_angle_y, chassis_pipe_angle_z])
                    translate([0, -19, 0])
                        rotate([90, 0, 0])
                                kstm_10();
    }
