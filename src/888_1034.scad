// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>

$fn = 80;
draft = true;

module 888_1034(){
    difference(){
        hull(){
            //cylinder(d = tube_for_undercarriage_outer_diameter + 2* beam_min_wall, h = tube_for_undercarriage_outer_diameter + 2*beam_min_wall, center = true);
            translate([0, tube_for_undercarriage_outer_diameter/2, 0])
                cube([tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter*3.5, tube_for_undercarriage_outer_diameter + 2*beam_min_wall], center = true);
        }

        cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall+1, center = true);
        translate([0, tube_for_undercarriage_outer_diameter + beam_vertical_space_between_pipes, 0])
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall+1, center = true);

        // otvory pro srouby
        translate([0, tube_for_undercarriage_outer_diameter*1.5 + 2 + beam_vertical_space_between_pipes, 0]){


            translate([0, 0, 5+layer])
                cylinder(d = M3_screw_diameter, h = 20, center = true);

            translate([0, 0, 5])
                cylinder(d = M3_nut_diameter, h = 20);

            translate([0, 0, -20-5])
                cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
        }

        translate([0, tube_for_undercarriage_outer_diameter*1.5 + 2 + beam_vertical_space_between_pipes, 0])
            difference(){
                cube([16, 20, 1], center=true);
                cylinder(d=M3_screw_diameter+0.2, h=10, center=true);
            }

        translate([0, -tube_for_undercarriage_outer_diameter*0.5 - 2, 0])
            rotate([0, 90, 0]){
                cylinder(d = M3_screw_diameter, h = 20, center = true);

                translate([0, 0, 5])
                    cylinder(d = M3_nut_diameter, h = 20);

                translate([0, 0, -20-5])
                    cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
            }
        translate([0, -tube_for_undercarriage_outer_diameter*0.5 - 2, 0])
            cube([1, 20, 50], center=true);

    }
}

888_1034();
