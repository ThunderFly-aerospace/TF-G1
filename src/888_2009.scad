/*============= Dil pro pripevneni predniho kolecka k nosniku =============== */

include <../parameters.scad>
use <888_1004.scad>

column_upper_diameter = 60;
column_lower_diameter = 608_bearing_outer_diameter*2;
column_height = 80;

joint_diameter = 40;
screw_length = 10.8;
height = 25;
washer_diameter = 20;
screw_distance = 42.5;
stops_overhang = 3;
layer_height = 0.2;

module 888_2009(){
    difference(){

        //sloupek
        hull(){

            translate([-engine_holder_beam_depth-10, -(beam_width+10)/2, -0.1])
                cube([engine_holder_beam_depth+10, beam_width+10, 0.1]);

            translate([0, 0, -column_height]) cylinder (h=column_height, d=column_lower_diameter, $fn=50);
        }


        translate([-engine_holder_beam_depth + beam_patern/2, (beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -5-100])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);

        }

        translate( [-engine_holder_beam_depth + beam_patern/2, -(beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -5-100])
                cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
        }

        translate([-engine_holder_beam_depth + beam_patern*1.25, 0, -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 20, $fn = 20);
            translate([0, 0, -10])
                rotate(30)
                    cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
            rotate(-90)
                translate([-M4_nut_diameter/2, 0, -10])
                    cube([M4_nut_diameter, 50, M4_nut_height]);
        }


        //dira pro hlavni M5 osou
        translate([0, 0, -1-column_height])
            cylinder(h=column_height-80, d=M5_screw_diameter, $fn=50);

        //kapsa pro M5 matici
        rotate([0, 0, 90])
            translate([0, -M5_nut_pocket/2, column_height*1.5])
                hull() {
                    translate([0,M5_nut_pocket/2,0]) cylinder(h=M5_nut_height, d=M5_nut_diameter, $fn=6);
                    cube ([column_upper_diameter/2, M5_nut_pocket, M5_nut_height ]);
                }

                    /* difference() {
                        union() {
                            translate([0, 0, -5])
                            cylinder(d=joint_diameter, h=height+5, $fn=100);

                            hull() {
                                translate([0, 0, height/2])
                                    cylinder(d=joint_diameter, h=height/2, $fn=100);

                                translate([0, 0, height-5])
                                    cylinder(d=screw_distance+10, h=5, $fn=100);
                            }

                            //zarážka
                            hull() {
                                translate([stop_width/2, 0, -stops_overhang])
                                    rotate([0, 0, max_angle_of_ratation/-2])
                                        translate([0, joint_diameter/2-10, 0])
                                            cube([8, stop_size+10, 10]);

                                translate([stop_width/2, 0, -stops_overhang+10])
                                    rotate([0, 0, max_angle_of_ratation/-2])
                                        translate([0, joint_diameter/2-10, 0])
                                            cube([8, stop_size, 10]);
                            }
                            //zarážka
                            hull() {
                                translate([stop_width/-2, 0, -stops_overhang])
                                    rotate([0, 0, max_angle_of_ratation/2])
                                        translate([-8, joint_diameter/2-10, 0])
                                            cube([8, stop_size+10, 10]);

                                translate([stop_width/-2, 0, -stops_overhang+10])
                                    rotate([0, 0, max_angle_of_ratation/2])
                                        translate([-8, joint_diameter/2-10, 0])
                                            cube([8, stop_size, 10]);
                            }
                        }
                        rotate([5, 0, 0])
                        translate([0, 0, -10])
                            cylinder(d=joint_diameter+1, h=10, $fn=50);

                        //šroub uchycení podvozku
                        rotate([5, 0, 0]) {
                            translate([0, 0, -0.1])
                                cylinder(d=M8_screw_diameter, h=screw_length-layer_height, $fn=20);
                            translate([0, 0, screw_length])
                                cylinder(d=washer_diameter, h=100, $fn=40);
                        }

                        //šrouby pro připevnění k motorovému dílu
                        translate([screw_distance/2, 0, 0])
                            cylinder(d=M4_screw_diameter, h=100, $fn=20);

                        translate([screw_distance/-2, 0, 0])
                            cylinder(d=M4_screw_diameter, h=100, $fn=20);

                        translate([screw_distance/2, 0, -10])
                            cylinder(d=M4_screw_diameter+5, h=height+5, $fn=20);

                        translate([screw_distance/-2, 0, -10])
                            cylinder(d=M4_screw_diameter+5, h=height+5, $fn=20);
                    } */

    }
}

888_2009();
