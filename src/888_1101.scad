draft = true;
include <../parameters.scad>

rotx = ($t)*20 - 10;      //  -10 .. +10
roty = -(($t)*10 - 5);       //   -5 .. +5

rotx = 0;
roty = 0;

use <888_1015.scad>
use <888_1020.scad>
use <lib/servo.scad>
use <lib/igus.scad>

888_1101_dev(){
color([0.2, 0.2, 0.8])
    translate([0, 0, 0])
        //rotate([0,9,0])
                efsm_12();

difference(){
    union(){
    color([0.8, 0.3, 0.6])
        rotate([0, -9, 0])
            translate([10, 0, -rotor_head_height])
                888_1015();

    rotate([0, -9, 0]) translate([25, -43, -56]) rotate([0, 180, 0]) LW_20MG();

    color([0.2, 0.8, 0.2, 0.9])
        translate([0,0, 0])
            rotate([rotx,roty,0])
                translate([0,0,0])
                    888_1020();


    }
    translate([0, 0, -250])
        cube(500);
    }
}



function 888_1101_translation() = [rotor_head_width/2 - 17.5, 0, -height_666_1026];
function 888_1101_rotation() = [0, 0, 0];

module 888_1101(){
    translate([rotor_head_bearind_x_shift, 0, rotor_head_height])
        rotate([0,rotor_head_rank_angle,0])
            efsm_12();

    888_1015();

    translate([rotor_head_bearind_x_shift,0, rotor_head_height])
        rotate([rotx,roty,0])
            translate([0,0,0])
                888_1020();

}

translate(888_1101_translation())
    888_1101();
