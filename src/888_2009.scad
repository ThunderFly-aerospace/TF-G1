/*============= Dil pro pripevneni predniho kolecka k nosniku =============== */

include <../parameters.scad>
include <lib/servo.scad>
use <888_1004.scad>

column_upper_diameter = 20;
column_lower_diameter = 40;
column_height = 65;
column_offset = 50;

joint_diameter = 40;
screw_length = 10.8;
washer_diameter = 20;
screw_distance = 42.5;
stops_overhang = 5;
layer_height = 0.2;
slope = 10;

reinforcement_hole_diameter = 1;

reinforcement_vertical_hole_count = 10;
reinforcement_horizontal_hole_count = 30;

shoulder_screw_length = 70 - 2*7 - front_undercarriage_bearing_distance + 3; // jak hluboko je licovani v tomto dile
module 888_2009(){
    difference(){

        //sloupek
        union(){
            hull(){
                translate([-engine_holder_beam_depth-5, -(beam_width-22)/2, -2])
                    cube([engine_holder_beam_depth/5*2, beam_width-22, 2]);
                translate([-engine_holder_beam_depth+beam_patern*1.25, 0, -5])
                        cylinder (h=5, d=10, $fn=60);
                translate([-column_offset, 0, -column_height])
                        rotate([0, slope, 0])
                            cylinder (h=10, d=column_lower_diameter, $fn=60);
                //translate([-column_offset, 0, -column_height])
                //    rotate([0, slope, 0])
                //        translate([-25/2, -column_lower_diameter/2 - 10, 10])
                //            cube([10, column_lower_diameter/2+5, 25]);
            }


            translate([-column_offset, 0, -column_height])
                rotate([0, slope, 0])
                    rotate([0, 0, max_angle_of_ratation/2+180])
                        translate([column_lower_diameter/2-3, stop_width/2, -7])
                            rotate([0, -15, 0])
                                cube([13, stop_width, 50]);

            translate([-column_offset, 0, -column_height])
                rotate([0, slope, 0])
                    rotate([0, 0, -max_angle_of_ratation/2+180])
                        translate([column_lower_diameter/2-3, -stop_width-stop_width/2, -7])
                            rotate([0, -15, 0])
                                cube([13, stop_width, 50]);

            // translate([-column_offset, 0, -column_height])
            //     rotate([0, slope, 0])
            //         translate([0, 0, -20]){


            //             rotate([0, 0, max_angle_of_ratation/2])
            //             translate([-50, -stop_width*1.5, 0])
            //                 #cube([50, stop_width, 5]);

            //             rotate([0, 0, -max_angle_of_ratation/2])
            //                 translate([-50, stop_width*0.5, 0])
            //                     #cube([50, stop_width, 5]);
            //         }


        translate([-column_offset, 0, -column_height])
            rotate([0, slope, 0])
                translate([0, 0, 8]){


                //translate([50, 0, -10])
                //    rotate([90, 0, -90])
                //        LW_20MG();

                translate([0, -15, 4-layer])
                    cube([90, 30, layer]);

                difference(){
                    union(){
                        translate([0, -15, 0])
                            cube([90, 30, 4]);

                        hull(){
                            translate([0, -15, 0])
                                cube([90, 2, 5]);
                            translate([20, -15, 60])
                                cube([5, 2, 1]);
                        }

                        hull(){
                            translate([0, 15-2, 0])
                                cube([90, 2, 5]);
                            translate([20, 15-2, 60])
                                cube([5, 2, 1]);
                        }

                    }
                    translate([50, 0, -23])
                        rotate([90, 0, -90])
                            LW_20MG_screw(depth = 15, pocket = false);

                    translate([50, 0, -20])
                        rotate([90, 0, -90])
                            LW_20MG_base_cube(border = 0.5);
                }
            }

        }

        // odcteni sikme plochy
        translate([-column_offset, 0, -column_height])
            rotate([0, slope, 0]){
            //translate([0, 0, -column_lower_diameter]){

                translate([0, 0, -50])
                    cylinder(d=column_lower_diameter+global_clearance+1, h=50, $fn=50);

                translate([0, 0, -50+1.5])
                    cylinder(d= 19, h=50, $fn=50);

                translate([0, 0, -50-3])
                    cylinder(d=column_lower_diameter+50, h=50, $fn=50);


                // Otvory pro licovany sroub
                translate([0, 0, -1])
                    cylinder(d = M8_screw_diameter, h = shoulder_screw_length+1, $fn = 50);

                #translate([0, 0, shoulder_screw_length + layer])
                    cylinder(d = M6_screw_diameter, h = 15, $fn = 50);

                translate([-50, -M6_nut_pocket/2, shoulder_screw_length + layer])
                    cube([50*2, M6_nut_pocket, M6_nut_height]);


                //vyztuzovaci otvory svisle
                for(i = [0 : 360/reinforcement_vertical_hole_count : 360]) {
                    rotate([0, 0, i])
                        translate([M8_screw_diameter/2+3, 0, 0])
                            cylinder(d=reinforcement_hole_diameter, h=shoulder_screw_length+1, $fn=10);
                }

                //vyztuzovaci otvory vodorovne
                for(i = [0 : 1 : reinforcement_horizontal_hole_count]) {
                    translate([0, 0, i*((shoulder_screw_length-10)/reinforcement_horizontal_hole_count)+1])
                        rotate([90, 0, i*115]){
                            //cylinder(d=reinforcement_hole_diameter, h=120, $fn=10, center=true);
                            translate([M8_screw_diameter/2+0.3, 0, 0])
                                cube([28, 10, 0.2]);
                            
                            translate([-28-M8_screw_diameter/2-0.3, 0, 0])
                                cube([28, 10, 0.2]);


                            }
                }
            }


        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 13, 10+5])
        //             rotate([90, 0, 0])
        //                 cylinder(d = M3_screw_diameter, h = 50, $fn = 30);

        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 13, 10+5 + 10])
        //             rotate([90, 0, 0])
        //                 cylinder(d = M3_screw_diameter, h = 50, $fn = 30);

        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 7, 10+5+10])
        //             rotate([90, 30, 0])
        //                 cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);

        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 7, 10+5])
        //             rotate([90, 30, 0])
        //                 cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);

        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 7 - M3_nut_height, 10+5+10 - M3_nut_diameter/2])
        //             cube([20, M3_nut_height, M3_nut_diameter]);

        // translate([-column_offset, 0, -column_height])
        //     rotate([0, slope, 0])
        //         translate([-25/2 +5, -column_lower_diameter/2 -10 + 7 - M3_nut_height, 10+5 - M3_nut_diameter/2])
        //             cube([20, M3_nut_height, M3_nut_diameter]);


        // diry na svisle srouby skrze nosnik
        translate([-engine_holder_beam_depth + beam_patern/4, (beam_main_pipe_distance/2), 0]){
            translate([0, 0, -20])
                cylinder(d = M4_screw_diameter, h = 31, $fn = 20);
            translate([0, 0, -15])
                cylinder(d = M4_nut_diameter, h = M4_nut_height*1.5, $fn = 6);
            translate([-M4_nut_diameter/2, 0, -15])
                cube([M4_nut_diameter, 50, M4_nut_height]);
        }

        translate([-engine_holder_beam_depth + beam_patern/4, -(beam_main_pipe_distance/2), 0]){
            translate([0, 0, -20])
                cylinder(d = M4_screw_diameter, h = 31, $fn = 20);
            translate([0, 0, -15])
                cylinder(d = M4_nut_diameter, h = M4_nut_height*1.5, $fn = 6);
            translate([-M4_nut_diameter/2, -50, -15])
                cube([M4_nut_diameter, 50, M4_nut_height]);
        }

        // otvor pro predni pripevnovaci sroub
        translate([-engine_holder_beam_depth + beam_patern*1.25, 0, -beam_thickness/3]){
            cylinder(d = M3_screw_diameter, h = 30, $fn = 20);
            translate([0, 0, 0])
                rotate(30)
                    cylinder(d = M3_nut_diameter, h = M3_nut_height*1.5, $fn = 6);
            rotate(-90)
                translate([-M3_nut_diameter/2, 0, 0])
                    cube([M3_nut_diameter, 50, M3_nut_height]);
        }
    }
}

888_2009();
