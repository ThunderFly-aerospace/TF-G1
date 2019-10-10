// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>

$fn = 40;
draft = true;

module 888_1032(){
strap_width = 22;
strap_thickness = 3;


    difference(){
        union(){
            hull(){
                cylinder(d = tube_for_undercarriage_outer_diameter + 2* beam_min_wall, h = tube_for_undercarriage_outer_diameter + 2*beam_min_wall, center = true);
                translate([0, tube_for_undercarriage_outer_diameter, 0])
                    cube([tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter + 2*beam_min_wall], center = true);
            }

            translate([strap_width - tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter, 0])
                cube([strap_width*2 +tube_for_undercarriage_outer_diameter+2*beam_min_wall, strap_thickness*3, accumulator_holder_width], center = true);
        }

        cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall, center = true);
        translate([0, tube_for_undercarriage_outer_diameter + beam_vertical_space_between_pipes, 0])
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall, center = true);

        // otvory pro srouby
        translate([0, tube_for_undercarriage_outer_diameter + beam_vertical_space_between_pipes, 0]){
            cylinder(d = M3_screw_diameter, h = 20, center = true);

            translate([0, 0, 6.5])
                cylinder(d = M3_nut_diameter, h = 20);

            translate([0, 0, -20-6.5])
                cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
        }


        translate([0, -tube_for_undercarriage_outer_diameter/2, 0])
            rotate([0, 90, 0]){
                cylinder(d = M3_screw_diameter, h = 20, center = true);

                translate([0, 0, 5])
                    cylinder(d = M3_nut_diameter, h = 20);

                translate([0, 0, -20-5])
                    cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
            }
    }
}

888_1032();
