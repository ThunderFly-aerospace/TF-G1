// drzak podvozku za podelnou tyc virniku

include <../parameters.scad>
use <lib/igus.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.


module 888_2013(draft){

    chassis_arm_mount_patern = 10.16;
    chassis_arm_mount_plate_thicknes = 8;

    width = chassis_arm_mount_plate[1];
    length = chassis_arm_mount_plate[0];

    screw_length = 25 + 3;
    column_width = screw_length+M6_nut_height*2;

    kstm_ball_thickness = 12;

    // pripevnovaci placka
    difference(){
        union(){
            // zakladni tvar placky
            hull(){
                translate([-length/2, -width/2, 0])
                    cylinder(d = M4_nut_diameter+10, h= chassis_arm_mount_plate_thicknes);
                translate([-length/2, width/2, 0])
                    cylinder(d = M4_nut_diameter+10, h= chassis_arm_mount_plate_thicknes);
                translate([length/2, -width/2, 0])
                    cylinder(d = M4_nut_diameter+10, h= chassis_arm_mount_plate_thicknes);
                translate([length/2, width/2, 0])
                    cylinder(d = M4_nut_diameter+10, h= chassis_arm_mount_plate_thicknes);
            }

            // sloupek pro lozisko
            rotate([0, 0, chassis_top_bearing_rotation[2]]) difference(){
                hull(){
                    translate([-7-column_width/2, -17, 0])
                        cube([7*2+column_width, 34, 1]);
                    translate([0, 0, chassis_top_bearing_position_z])
                        rotate([0, 90, 0])
                            cylinder(d = 22, h = column_width, center = true, $fn = 100);
                }

                translate([0, 0, chassis_top_bearing_position_z])
                    rotate([0, 90, 0])
                        cylinder(d = M8_screw_diameter, h = 40, center = true, $fn = 100);

                translate([screw_length/2, 0, chassis_top_bearing_position_z])
                    rotate([0, 90, 0])
                        cylinder(d = M6_nut_diameter, h = 40, center = false, $fn = 6);

                translate([-screw_length/2, 0, chassis_top_bearing_position_z])
                    rotate([0, -90, 0])
                        cylinder(d = 14, h = 40, center = false, $fn = 100);

                translate([0, 0, 22+10])
                    cube([kstm_ball_thickness, 30, 25], center = true);
            }
        }

            // diry pro srouby skrze placku
            translate([-length/2, -width/2, 0])
                cylinder(d = M4_screw_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([-length/2, width/2, 0])
                cylinder(d = M4_screw_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([length/2, -width/2, 0])
                cylinder(d = M4_screw_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([length/2, width/2, 0])
                cylinder(d = M4_screw_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            // zapusteni na srouby
            translate([-length/2, -width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h=100, $fn = 60);

            translate([-length/2, width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h=100, $fn = 60);

            translate([length/2, -width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h=100, $fn = 60);

            translate([length/2, width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h=100, $fn = 60);

    }



}


888_2013(draft);

//888_2013_drillhelper();
