draft = true;
include <../parameters.scad>
include <lib/servo.scad>
use <lib/igus.scad>
use <888_1015.scad>
use <888_1020.scad>
use <888_1029.scad>
use <888_1022_without_desk.scad>

rotx = ($t)*20 - 10;      //  -10 .. +10
roty = -(($t)*10 - 5);       //   -5 .. +5

rotx = -0;
roty = 0;

use <888_1015.scad>
use <888_1020.scad>
use <lib/servo.scad>
use <lib/igus.scad>
use <lib/motor.scad>


function 888_1101_translation() = [rotor_head_width/2 - 17.5, 0, -height_666_1026];
function 888_1101_joint_translation() = [-rotor_head_bearing_x_shift, 0, rotor_head_height-height_666_1026];
function 888_1101_prerotpulley_translation() = [rotor_head_prerotator_distance , 0,  rotor_head_limiter_below + rotor_head_plate_bearing_center_distance];
function 888_1101_rotorpulley_translation() = [0 , 0,  rotor_head_limiter_below + rotor_head_plate_bearing_center_distance];
function 888_1101_rotation() = [rotor_head_roll, rotor_head_pitch+rotor_head_rank_angle, 0];

module 888_1101(){
    //888_1029();
    //888_1029_servoholder();
    difference(){union(){
        translate([0, 0, rotor_head_height])
            rotate([rotx, rotor_head_rank_angle, 180])
                translate([rotor_head_bearing_x_shift, 0, 5.5])
                    rotate([180, 0, 0])
                        888_1022();

        import("../STL/888_1029.stl", convexity=3);

        //pipes_top_screw();
        //pipes();
        if(draft)

        //import("../STL/333_1001.stl", convexity=3);
        //rotate([-rotx, -rotor_head_rank_angle-roty, 0])
        translate([0, 0, rotor_head_height])
        translate([-rotor_head_bearing_x_shift, 0, 0])
        rotate([-rotx, -roty-rotor_head_rank_angle, 0]){
            //sphere(r=5);
            translate([0, 0, 11.5]) rotate([180, 0, 180]) import("../STL/888_1020.stl", convexity=3);
        }
        //888_1020();

        if(draft)
        translate([0, 0, rotor_head_height])
            rotate([0, rotor_head_rank_angle, 180])
                translate([rotor_head_bearing_x_shift, 0, -7])
                    efsm_12();
    }

    cube(500);
    }
}

translate(888_1101_translation())
    888_1101();
