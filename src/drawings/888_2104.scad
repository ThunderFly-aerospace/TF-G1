draft = $preview;
include <../parameters.scad>
use <888_2013.scad>
use <888_2016.scad>
use <888_2017.scad>
use <888_2027.scad>
use <lib/igus.scad>
use <lib/vector.scad>
use <lib/piston.scad>
use <666_1027.scad>
use <888_1004.scad>
use <888_1005.scad>
//color([0.2, 0.4, 0.4, 0.5]) translate([-second_undercarriage_hole,0,main_tube_outer_diameter/2+2]) rotate([90,0,0]) 666_1027();

translate([-beam_patern*12 + engine_holder_beam_depth - beam_main_pipe_thickness/2, 0, beam_thickness_below]){
    888_1004(draft = true);
    //888_1005();
}
washer_thickness = main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness;


module piston(shift = 32){
    sphere(d = 15);

    translate([0, 0, 215])
        sphere(d = 15);

    translate([0, 0, 295])
        sphere(d = 15);

    cylinder(h = 265 + shift, d = 5);
    translate([0, 0, shift])
        cylinder(h = 150, d = 20);

}


ch = chassis_height;
color("red")
    translate([2017_pipe_mount_offset[0], 2017_bearing_mount_offset[1], -ch + 2017_pipe_mount_offset[2]])
        cube([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height]);

color("green")
    translate([-chassis_pipe_baselength_f - 2017_pipe_mount_offset[0], 2017_bearing_mount_offset[1], -ch + 2017_pipe_mount_offset[2]])
        cube([chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height]);

echo(str("Delka predniho ramene je ", mod([chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));
echo(str("Delka  zadniho ramene je ", mod([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));
//
color("blue")
    translate([ -2017_pipe_mount_offset[0], -2017_bearing_mount_offset[1] - chassis_pipe_wheelbase, -ch + 2017_pipe_mount_offset[2]])
        rotate([0, 0, 0])
        orientate([-chassis_pipe_baselength_f, chassis_wheelbase, chassis_height], [0, 0, 1])
            cylinder(d = 10, h = 500);



////////////////////////
color("red")
translate([0, chassis_top_bearing_position_y, kstm_ball_height(8)])
rotate([-15, 0, 0])
translate([0, -chassis_top_bearing_position_y+5, -kstm_ball_height(8)-9])
{

/* translate([chassis_baselength_f, -chassis_top_bearing_position_y, -kstm_ball_height(8)])
    rotate([0, 0, 180]) 888_2013(front = 1, left = 0);
translate([-chassis_baselength_r, -chassis_top_bearing_position_y, -kstm_ball_height(8)])
    rotate([0, 0, 180]) 888_2013(front = 0, left = 0);
translate([0, -chassis_wheelbase/2, -chassis_height])
    rotate([-90, -90, 0])
        888_2017(right = 0); */

/* translate([0, -chassis_wheelbase/2 + 2017_bearing_mount_offset[1], -chassis_height + 2017_bearing_mount_offset[2]])
    rotate([-28, 0, 0])
        piston(); */

}

////////////////////



translate([-chassis_baselength_f, chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
    orientate([-chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
        rotate([0, 90, 90])
            888_2013(front = 1, left = 1);

translate([-chassis_baselength_f, -chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
    orientate([-chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])
        rotate([0, 90, 90])
            888_2013(front = 0, left = 1);

translate([chassis_baselength_r, chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
    orientate([chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
        rotate([0, 90, 90])
            888_2013(front = 1, left = 0);

translate([chassis_baselength_r, -chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
    orientate([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])
        rotate([0, 90, 90])
            888_2013(front = 0, left = 0);


// KSTM kulova loziska pod nosnikem virniku
color("navy"){
    translate([chassis_baselength_r, chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
        orientate([chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
            rotate([180, 0, 90]) kstm_08();
    translate([chassis_baselength_r, -chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
        orientate([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])
            rotate([180, 0, 90]) kstm_08();
    translate([-chassis_baselength_f, chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
        orientate([-chassis_pipe_baselength_f, -chassis_pipe_wheelbase, chassis_height])
            rotate([180, 0, 90]) kstm_08();
    translate([-chassis_baselength_f, -chassis_top_bearing_position_y, -kstm_ball_height(8)-chassis_top_bearing_position_z])
        orientate([-chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])
            rotate([180, 0, 90]) kstm_08();
}


color([0.2, 0.2, 0.6, 0.7]){
    translate([-chassis_baselength_f, 0, 0])
        rotate([0, 0, 180])
            888_2027(chassis_baselength_f);

    translate([chassis_baselength_r, 0, 0])
        888_2027(chassis_baselength_r);
}


translate([0, chassis_wheelbase/2, -chassis_height])
    rotate([90, -90, 0])
        888_2017(right = 0);

translate([0, -chassis_wheelbase/2, -chassis_height])
    rotate([-90, -90, 0])
        888_2017(right = 0);


translate([0, -chassis_suspension_basewidth/2, -50])
    sphere(d = 10);
translate(-chassis_top_bearing_position_r)
    sphere(d = 10);
translate([0, -chassis_wheelbase/2 + 2017_bearing_mount_offset[1], -chassis_height + 2017_bearing_mount_offset[2]])
    sphere(d = 10);


//
//
//      Dily pro souvisejici s pricnou tyci
//
//

translate([0, 0, 0]){
    color("green"){

        // trmeny k pricne trubce
        translate([0, chassis_suspension_basewidth/2, beam_main_pipe_thickness/2 + beam_min_wall])
            rotate([-90, 180, 0])
                888_2016();
        translate([0, -chassis_suspension_basewidth/2, beam_main_pipe_thickness/2 + beam_min_wall])
            rotate([90, 0, 0])
                888_2016();

        translate([0, -chassis_suspension_basewidth/2 - 5, beam_min_wall + beam_main_pipe_thickness/2 + 9])
            rotate([20, 0, 0])
                translate([0,  -kstm_ball_height(8), 0])
                    rotate([0, 180+45, 90])
                    chassis_piston_assembly();

        /* translate([0, -chassis_suspension_basewidth/2 - kstm_ball_height(8), 0])
            rotate([0, 180+42, 90])
                chassis_piston_assembly(); */
    }

    color("Teal"){
        translate([beam_patern/2,0, beam_main_pipe_thickness/2 + beam_min_wall])
            rotate([90, 0, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = chassis_suspension_basewidth, center = true);

        translate([-beam_patern/2,0, beam_main_pipe_thickness/2 + beam_min_wall])
            rotate([90, 0, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = chassis_suspension_basewidth, center = true);


        translate([0, -chassis_suspension_basewidth/2 - 5, beam_main_pipe_thickness/2 + beam_min_wall+2])
            rotate([-20, 0, 0])
                translate([0,  -kstm_ball_height(8), 0])
                    rotate([0, -90, 90])
                        kstm_08();

        translate([0, chassis_suspension_basewidth/2 + 5, beam_main_pipe_thickness/2 + beam_min_wall+2])
            rotate([20, 0, 0])
                translate([0,  kstm_ball_height(8), 0])
                rotate([0, 90, 90])
                    kstm_08();

    }
}
