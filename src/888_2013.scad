// drzak podvozku za podelnou tyc virniku

include <../parameters.scad>
use <lib/igus.scad>
use <lib/vector.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.


module 888_2013(front = true, left = 1, rotate = false){
    tube_wall = 5;
    kstm_ball_thickness = 12;
    kstm_screw_length = 20;
    pipe_screw_length = 20;

    length = 50;
    thickness = 18;

    difference(){
        hull(){
            intersection(){
                translate([-9, -(kstm_screw_length+M4_screw_head_height*3)/2, -thickness/2])
                    cube([18, kstm_screw_length+M4_screw_head_height*3, thickness]);
                rotate([90, 0, 0])
                    cylinder(d = 20, h = 100, center=true, $fn = 70);
            }
            translate([0, -thickness/2, -thickness/2])
                cube([length, thickness, thickness]);
        }

        translate([0, 0, 0])
            rotate([90, 0, 0])
                cylinder(d = 25, h = kstm_ball_thickness, center = true, $fn = 80);

        difference(){
            cube([30, kstm_ball_thickness, 23], center = true);

        translate([25, 0, 0])
            rotate([90, 0, 0])
                cylinder(d = 25, h = kstm_ball_thickness, center = true, $fn = 80);

        }

    // Otvory sroubu pro pridelani KSTM
        translate([0, 0, 0])
            rotate([90, 0, 0])
                cylinder(d = M4_screw_diameter, h = 50, center = true, $fn = 40);
        translate([0, kstm_screw_length/2+20, 0])
            rotate([90, 0, 0])
                cylinder(d = M4_nut_diameter, h = 20, $fn = 6);
        translate([0, -kstm_screw_length/2, 0])
            rotate([90, 0, 0])
                cylinder(d = M4_nut_diameter, h = 20, $fn = 6);


        translate([15-0.5, 0, 0])
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = length, $fn = 60);

            for (i=[15+10, 15+25])
                translate([i, 0, 0]) {
                    translate([0, 0, 0])
                        rotate([90, 0, 0])
                            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 40);
                    translate([0, pipe_screw_length/2+20, 0])
                        rotate([90, 0, 0])
                            cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
                    translate([0, -pipe_screw_length/2, 0])
                        rotate([90, 0, 0])
                            cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
                }

    }
}



//rotate([-chassis_top_bearing_rotation[2], 0, 0])
    888_2013(false);

//888_2013_drillhelper();
