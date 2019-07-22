include <../parameters.scad>
use <888_2013.scad>
use <888_2016.scad>
use <888_2017.scad>
use <888_2018.scad>
use <lib/igus.scad>
use <lib/vector.scad>
use <666_1027.scad>

//color([0.2, 0.4, 0.4, 0.5]) translate([-second_undercarriage_hole,0,main_tube_outer_diameter/2+2]) rotate([90,0,0]) 666_1027();

washer_thickness = main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness;


module piston(){
    sphere(d = 15);

    translate([0, 0, 215])
        sphere(d = 15);

    translate([0, 0, 295])
        sphere(d = 15);

    cylinder(h = 295, d = 5);
    translate([0, 0, 30])
        cylinder(h = 150, d = 20);

}

module bearing_set(x = 0, rot_x = 0, front = true){
    r = atan((chassis_pipe_wheelbase)/(chassis_height+80));
    translate([x, chassis_top_bearing_position_y, -kstm_ball_height(8)]){
            //rotate([0, 90, 90+rot_x])
                //rotate([0, 90 + r, 90+rot_x])
                //orientate([chassis_pipe_wheelbase, chassis_baselength_f, chassis_height], [0, 0, 1])
            //translate([0, 0, -20])
                    888_2013(front);

            rotate([180, 0, 90])
                kstm_08();
    }
}


ch = chassis_height;
color("red");
     translate([0, 2017_bearing_mount_offset[1], -ch + 2017_pipe_mount_offset[2]])
        cube([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height]);

color("green")
    translate([-chassis_pipe_baselength_f - 2017_pipe_mount_offset[0], 2017_bearing_mount_offset[1], -ch + 2017_pipe_mount_offset[2]])
        cube([chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height]);

        echo(str("Delka predniho ramene je ", mod([chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));
        echo(str("Delka  zadniho ramene je ", mod([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));

color("blue")
    translate([ - 2017_pipe_mount_offset[0], 2017_bearing_mount_offset[1] + chassis_pipe_wheelbase, -ch + 2017_pipe_mount_offset[2]])
        rotate([0, 0, 180])
        orientate(chassis_arm_f, [0, 0, 1])
            cylinder(d = 10, h = 500);



mirror([0, 0, 0])
    #bearing_set(chassis_baselength_r, chassis_pipe_angle_r_z, false);
mirror([1, 0, 0])
    bearing_set(chassis_baselength_f, chassis_pipe_angle_f_z);
mirror([0, 1, 0])
    bearing_set(chassis_baselength_r, chassis_pipe_angle_r_z, false);
mirror([1, 0, 0])
    mirror([0, 1, 0])
        bearing_set(chassis_baselength_f, chassis_pipe_angle_f_z);




translate([0, chassis_wheelbase/2, -chassis_height])
    rotate([90, -90, 0])
        888_2017();

mirror([0, 1, 0])
    translate([0, chassis_wheelbase/2, -chassis_height])
        rotate([90, -90, 0])
            888_2017();


translate([0, -chassis_wheelbase/2 + 2017_bearing_mount_offset[1], -chassis_height + 2017_bearing_mount_offset[2]])
    sphere(d = 10);

translate([0, -chassis_wheelbase/2 + 2017_bearing_mount_offset[1], -chassis_height + 2017_bearing_mount_offset[2]])
    rotate([-38, 0, 0]){
        cylinder(d = 20, h = 220);
        cylinder(d = 10, h = 290);
    }
    translate([0, -chassis_wheelbase/2 + 2017_bearing_mount_offset[1], -chassis_height + 2017_bearing_mount_offset[2]])
        rotate([-22, 0, 0])
            piston();

translate([0, -chassis_suspension_basewidth/2, -50])
    sphere(d = 10);


translate([-chassis_top_bearing_position_x, chassis_top_bearing_position_y, 0])
    sphere(d = 10);






// dil na pridelani pricne tyce k podlozce
//#rotate([0, 180, 0])
translate([0,0, washer_thickness])
    888_2018();


// trmeny k pricne trubce
translate([0, chassis_suspension_basewidth/2, washer_thickness +main_tube_outer_diameter/2 + 2018_thickness_above_pipe*2])
    rotate([0, 0, 90])
        888_2016();

translate([0, -chassis_suspension_basewidth/2, washer_thickness +main_tube_outer_diameter/2 + 2018_thickness_above_pipe*2])
    rotate([0, 0, 90])
        888_2016();


translate([0, -chassis_suspension_basewidth/2, washer_thickness - 2018_thickness_above_pipe - 4 - kstm_ball_height(8)])
    rotate([0, 180, 90])
        kstm_08();

translate([0, chassis_suspension_basewidth/2, washer_thickness -2018_thickness_above_pipe - 4 - kstm_ball_height(8)])
    rotate([0, 180, 90])
        kstm_08();
