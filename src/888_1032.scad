// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>

draft = true;

module 888_1032(){
    difference(){
        hull(){
            cylinder(d = tube_for_undercarriage_outer_diameter + 2* beam_min_wall, h = tube_for_undercarriage_outer_diameter + 2*beam_min_wall, center = true);
            translate([0, tube_for_undercarriage_outer_diameter, 0])
                cube([tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter+2*beam_min_wall, tube_for_undercarriage_outer_diameter + 2*beam_min_wall], center = true);
        }

        cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall, center = true);
        translate([0, tube_for_undercarriage_outer_diameter + beam_vertical_space_between_pipes, 0])
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall, center = true);
    }
}

888_1032();
