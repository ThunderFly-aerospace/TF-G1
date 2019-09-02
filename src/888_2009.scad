/*============= Dil pro pripevneni predniho kolecka k nosniku =============== */

include <../parameters.scad>
use <888_1004.scad>

column_upper_diameter = 20;
column_lower_diameter = 40;
column_height = 50;
column_offset = 40;

joint_diameter = 40;
screw_length = 10.8;
washer_diameter = 20;
screw_distance = 42.5;
stops_overhang = 5;
layer_height = 0.2;
slope = 15;

shoulder_screw_length = 20; // jak hluboko je licovani v tomto dile
module 888_2009(){
    difference(){

        //sloupek
        union(){
            hull(){
                translate([-engine_holder_beam_depth-10, -(beam_width-22)/2, -0.1])
                    cube([engine_holder_beam_depth-10, beam_width-22, 0.1]);
                translate([0, 0, -5])
                    //rotate([0, 5, 0])
                        cylinder (h=5, d=10, $fn=60);
                translate([-column_offset, 0, -column_height])
                        rotate([0, slope, 0])
                            cylinder (h=1, d=column_lower_diameter, $fn=60);
            }

            translate([-column_offset, 0, 0]){
                rotate([0, slope, 0])
                    rotate([0, 0, -max_angle_of_ratation/2])
                        translate([-column_lower_diameter/2+ 4, 5 + stop_width/2, -column_height-stops_overhang])
                            cube([10, 5, 30]);
                rotate([0, slope, 0])
                    rotate([0, 0, max_angle_of_ratation/2])
                        translate([-column_lower_diameter/2 +4, -9 - stop_width/2, -column_height-stops_overhang])
                            cube([10, 5, 30]);
            }
        }

        // odcteni sikme plochy
        translate([-column_offset, 0, -column_height])
            rotate([0, slope, 0]){
            //translate([0, 0, -column_lower_diameter]){

                translate([0, 0, -50])
                    cylinder(d=column_lower_diameter+global_clearance+1, h=50, $fn=50);

                // Otvory pro licovany sroub
                translate([0, 0, -1])
                    cylinder(d = M8_screw_diameter, h = shoulder_screw_length+1, $fn = 50);

                translate([0, 0, shoulder_screw_length + layer])
                    rotate([0, 0, 30])
                        cylinder(d = M6_nut_diameter, h = M6_nut_height, $fn = 6);

                translate([0, 0, shoulder_screw_length + layer])
                    cylinder(d = M6_screw_diameter, h = 15, $fn = 50);

                translate([0, -M6_nut_diameter/2, shoulder_screw_length + layer])
                    cube([50, M6_nut_diameter, M6_nut_height]);
            }



        translate([-engine_holder_beam_depth + beam_patern/2, (beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -95])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);

        }

        translate( [-engine_holder_beam_depth + beam_patern/2, -(beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -20])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -95])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
        }

        translate([-engine_holder_beam_depth + beam_patern*1.25, 0, -beam_thickness/3]){
            translate([0, 0, -10])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, 0])
                rotate(30)
                    cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
            rotate(-90)
                translate([-M4_nut_diameter/2, 0, 0])
                    cube([M4_nut_diameter, 50, M4_nut_height]);
        }


    }
}

888_2009();
