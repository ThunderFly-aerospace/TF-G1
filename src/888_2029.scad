//========== Tahlo predniho kolecka ==========//
include <../parameters.scad>

module 888_2029() {

screw_distance = 10;


difference(){
    union(){
        hull(){
            cube([8, 3, 23]);
            cube([40, 3, 3]);
        }
        cube([45, 23, 3]);
    }

    translate([4, 0, 8])
        rotate([90, 0, 0])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 30, center = true);

    translate([4, 0, 8+10])
        rotate([90, 0, 0])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 30, center = true);


        translate([45/2, 25/2, 0]){
            cube([DS313MG_M, DS313MG_A, 10], center = true);

            translate([(DS313MG_M+6)/2,0, 0])
                cylinder(d = M3_screw_diameter, h = 10, $fn = 30);

            translate([-(DS313MG_M+6)/2, 0, 0])
                cylinder(d = M3_screw_diameter, h = 10, $fn = 30);
        }

    /* #union(){
        translate([main_tube_outer_diameter-vyska/2+servo_lever, 0, (DS313MG_J-DS313MG_M)/2+DS313MG_M-servo_overhang+fix_screw_distance])
            rotate([-90, 0, 0])
                cylinder(d=M2_5_screw_diameter, h=100, $fn=15);

        translate([main_tube_outer_diameter-vyska/2+servo_lever, 0, (DS313MG_J-DS313MG_M)/2+DS313MG_M-servo_overhang+fix_screw_distance])
            rotate([90, 0, 0])
                cylinder(d=4, h=100, $fn=15);

        translate([main_tube_outer_diameter-vyska/2+servo_lever, 2.5+DS313MG_G, (DS313MG_J-DS313MG_M)/2+DS313MG_M-servo_overhang+fix_screw_distance])
            rotate([-90, 0, 0])
                cylinder(d=M2_5_nut_diameter, h=M2_5_nut_height, $fn=6);

        translate([main_tube_outer_diameter-vyska/2+servo_lever, 2.5+DS313MG_G, (DS313MG_J-DS313MG_M)/2+DS313MG_M-servo_overhang-M2_5_nut_pocket/2+fix_screw_distance])
            cube([100, M2_5_nut_height, M2_5_nut_pocket]);

        translate([main_tube_outer_diameter-vyska/2+servo_lever-DS313MG_A/2, -2.5, -servo_overhang])
            cube([DS313MG_A, DS313MG_G, DS313MG_J]);

        translate([main_tube_outer_diameter-vyska/2+servo_lever-DS313MG_A/2, 0, -servo_overhang])
            cube([DS313MG_A+0.1, 100, (DS313MG_J-DS313MG_M)/2+DS313MG_M]);

        translate([main_tube_outer_diameter-vyska/2, -2.5, -servo_overhang])
            cube([servo_lever, 5, DS313MG_J]);
        } */

}


}

mirror([0,1,0])
888_2029();
