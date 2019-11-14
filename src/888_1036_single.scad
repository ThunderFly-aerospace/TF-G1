// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>

$fn = 80;
draft = $preview;


strap_width = 22;
strap_thickness = 3;


module 888_1036_single(){


    difference(){
        union(){
            hull(){
                //cylinder(d = tube_for_undercarriage_outer_diameter + 2* beam_min_wall, h = tube_for_undercarriage_outer_diameter + 2*beam_min_wall, center = true);
                height = tube_for_undercarriage_outer_diameter+2.5*beam_min_wall*2;
                translate([0, height*0.5 - tube_for_undercarriage_outer_diameter*0.2, 0])
                    cube([tube_for_undercarriage_outer_diameter+2*beam_min_wall, height, tube_for_undercarriage_outer_diameter + 2*beam_min_wall], center = true);
            }

            // plochá část s otvorem pro pásku
            translate([strap_width, tube_for_undercarriage_outer_diameter + tube_for_undercarriage_outer_diameter + beam_min_wall/2, 0])
                cube([strap_width*2 + tube_for_undercarriage_outer_diameter+2*beam_min_wall, strap_thickness*3, accumulator_holder_width], center = true);
        }

        // otvor pro pásku
        translate([strap_width/2 + tube_for_undercarriage_outer_diameter, tube_for_undercarriage_outer_diameter + tube_for_undercarriage_outer_diameter + beam_min_wall/2, 0])
            cube([strap_width, strap_thickness, accumulator_holder_width+1], center = true);


        translate([0, tube_for_undercarriage_outer_diameter + beam_vertical_space_between_pipes, 0])
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter, h = tube_for_undercarriage_outer_diameter+2*beam_min_wall + 1, center = true);

        // otvory pro srouby
        translate([0, tube_for_undercarriage_outer_diameter*0.25 + beam_vertical_space_between_pipes , 0]){
            cylinder(d = M3_screw_diameter, h = 20, center = true);

            translate([0, 0, 6.5])
                cylinder(d = M3_nut_diameter, h = 20);

            translate([0, 0, -20-6.5])
                cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
        }

        cube([30, 20, 1], center = true);

    }
}




888_1036_single();
