// drzak podvozku za podelnou tyc virniku

include <../parameters.scad>
use <lib/igus.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.

module 888_2013_old(draft) {
    material_plus = 10;

    difference(){
        union(){
            intersection(){
                union(){

                    // zakladni cast okolo trubky
                    translate([-888_2013_width/2, 0, -main_tube_outer_diameter/2 - material_plus])
                        cube([888_2013_width, main_tube_outer_diameter/2 + material_plus, main_tube_outer_diameter + material_plus*2]);

                    hull(){
                        translate([-50, 0, -main_tube_outer_diameter/2-material_plus])
                            cube([100, main_tube_outer_diameter/2 + material_plus, material_plus/2]);

                        // kostka, na kterou je pridelane loziska
                        translate(chassis_top_bearing_position)
                            rotate(chassis_top_bearing_rotation)
                                translate([-100/2, 0, -15/2])
                                    cube([100, 15, 15]);
                    }

                translate(chassis_top_bearing_position)
                    rotate(chassis_top_bearing_rotation)
                        translate([-100, -5, -15/2])
                            cube([200, 20, 15]);

                }

                // kostka, na kterou je pridelane loziska
                translate([-888_2013_width/2, global_clearance, -100])
                    cube([888_2013_width, 100, 200]);

            }
        }

        // dira na podelnou trubku
        rotate([0, 90, 0])
            translate([0, 0, -888_2013_width/2 - global_clearance])
                cylinder(d = main_tube_outer_diameter, h = 888_2013_width+ 2*global_clearance);

        // zkoseni nahore
        rotate([45, 0, 0])
            translate([-888_2013_width/2-global_clearance, main_tube_outer_diameter/2+material_plus, -25])
                cube([888_2013_width+2*global_clearance, 50, 50]);

        // diry pro sesroubovani
        rotate([-90, 0, 0]){
            translate([888_2013_width/4, 0, 0])
                cylinder(d = M4_screw_diameter, h = 100);

            translate([888_2013_width/4, 0, 35/2])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);

            translate([-888_2013_width/4, 0, 0])
                cylinder(d = M4_screw_diameter, h = 100);

            translate([-888_2013_width/4, 0, 35/2])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);

            translate([0, main_tube_outer_diameter/2+5, 0])
                cylinder(d = M4_screw_diameter, h = 100);

            translate([0, main_tube_outer_diameter/2+5, 35/2])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
        }


        // diry pro prisroubovani kuloveho loziska.
        translate(chassis_top_bearing_position)
            rotate(chassis_top_bearing_rotation)
                rotate([-90, 0, 0]){
                    translate([kstm_hole_distance(10)/2, 0, 0])
                        cylinder(d = M4_screw_diameter, h = 80, center = true);
                    translate([-kstm_hole_distance(10)/2, 0, 0])
                        cylinder(d = M4_screw_diameter, h = 80, center = true);
                    translate([kstm_hole_distance(10)/2, 0, 15/2-4])
                        cylinder(d = M4_nut_diameter, h = 50, $fn =6);
                    translate([-kstm_hole_distance(10)/2, 0, 15/2-4])
                        cylinder(d = M4_nut_diameter, h = 50, $fn = 6);
                }
    }
}

module 888_2013_old_drillhelper(){

    difference(){
        cube([main_tube_outer_diameter+20, main_tube_outer_diameter+20, 888_2013_width], center = true);

        cylinder( d = main_tube_outer_diameter, h = 888_2013_width, center = true);

        translate([0, 0, 888_2013_width/4])
            rotate([90, 0, 0])
                cylinder( d = M4_screw_diameter, h = 100, center = true);

        translate([0, 0, -888_2013_width/4])
            rotate([90, 0, 0])
                cylinder( d = M4_screw_diameter, h = 100, center = true);
    }
}



module 888_2013(){

    chassis_arm_mount_patern = 10.16;
    chassis_arm_mount_plate_thicknes = 8;

    chassis_arm_mount_plate = [40, 50];

    width = chassis_arm_mount_plate[1];
    length = chassis_arm_mount_plate[0];

    screw_length = 26;
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
                    translate([0, 0, 22+10])
                        rotate([0, 90, 0])
                            cylinder(d = 22, h = column_width, center = true, $fn = 100);
                }

                translate([0, 0, 22+10])
                    rotate([0, 90, 0])
                        cylinder(d = M8_screw_diameter, h = 40, center = true, $fn = 100);

                translate([screw_length/2, 0, 22+10])
                    rotate([0, 90, 0])
                        cylinder(d = M8_nut_diameter, h = 40, center = false, $fn = 6);

                translate([-screw_length/2, 0, 22+10])
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
                cylinder(d = M4_nut_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([-length/2, width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([length/2, -width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

            translate([length/2, width/2, chassis_arm_mount_plate_thicknes-M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h= chassis_arm_mount_plate_thicknes, $fn = 60);

    }



}


888_2013(draft);

//888_2013_drillhelper();
