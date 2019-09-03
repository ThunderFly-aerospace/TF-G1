/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;



////////////////////////////
module 888_1005(draft){


    translate([-engine_holder_beam_depth, 0, 0])
    union(){
//samotná podložka

        difference(){
            union(){
                intersection (){
                    rotate([90, 0, 0])
                        hollowing_skeleton(hull_wall_thickness + global_clearance, draft);
                    translate([main_tube_outer_diameter, - (hull_z_size - 2*hull_wall_thickness - 2*global_clearance)/2, -beam_thickness_below]) // podložka je vepředu seříznuta posunutím v ose X, aby vznikla toleranční mezera za přední částí krytu.
                        cube([hull_drop_length - main_tube_outer_diameter, hull_z_size - 2*hull_wall_thickness - 2*global_clearance, beam_thickness]);

                    translate([0, beam_side_edge_width/2, 0])
                        rotate([beam_edge_angle, 0, 0])
                            translate([ - engine_holder_beam_depth + beam_patern*(0.25+3), 0, -50])
                                cube([beam_patern*8, 50, 100]);

                    translate([0, beam_side_edge_width/2, 0])
                        rotate([-beam_edge_angle, 0, 0])
                            translate([0, 0, -50])
                                cube([800, 50, 100]);
                }
            }
                for (i=[3:8]) {
                    translate([beam_patern*(i+0.25), 0, -(beam_main_pipe_thickness+beam_vertical_space_between_pipes)]){
                        rotate([-90, 0, 0])
                            cylinder(d = beam_main_pipe_thickness, h = hull_x_size);

                        translate([0, 108, 0])
                            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 20);

                        translate([0, 108, -8-50])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                        translate([0, 108, 8])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                    }
                }


            intersection(){
                difference(){
                    translate([0,-hull_z_size/2, 0])
                        cube([hull_x_size, hull_z_size, hull_wall_thickness]); // spodní lem

                    //odebrání dna
                    translate([ribbon_width/2,0,0])
                        rotate([90, 0, 0])
                            hollowing_skeleton(ribbon_width, draft);
                }

            //odstranění dna z vnější strany krytu
                drop(draft);
            }

            translate([0, beam_side_pipe_distance/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = beam_main_pipe_thickness, h = 1000);

            rotate([90, 0, 0]) for (position_number = [1:5])
            {
                screw_top(position_number, draft);
                mirror([0,0,1])
                    screw_top(position_number, draft);
            }
        }
    }
}


module 888_1005_cut(){
    translate([35, 0, 0])
    intersection(){
        translate([0, -100, beam_patern*(4)])
            rotate([0, 90, 0])
                translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                    888_1005();

        translate([-20, -20, 0])
            cube([40, 40, beam_patern*3.5]);
    }
    translate([0, 0, 0])
    intersection(){
        translate([0, -100, beam_patern*(4+1)])
            rotate([0, 90, 0])
                translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                    888_1005();

        translate([-20, -20, 0])
            cube([40, 40, beam_patern*1]);
    }
    translate([-35, 0, beam_patern*(3.5)]) rotate([180, 0, 0])
        intersection(){
            translate([0, -100, beam_patern*(4+1+3.5)])
                rotate([0, 90, 0])
                    translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                        888_1005();

            translate([-20, -20, 0])
                cube([40, 40, beam_patern*3.5]);
        }

/*

    translate([-40, 20, beam_patern*(3+0.5)])
        rotate([0, 90, 0])
            translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                888_1005();



    translate([40, 0, beam_patern*3+beam_patern*5])
        rotate([0, 90, 0])
            translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                888_1005(); */
}

888_1005();
//888_1005_cut();

use <./lib/naca4.scad>
use <666_1025.scad>
include <../parameters.scad>
use <888_1000.scad>
