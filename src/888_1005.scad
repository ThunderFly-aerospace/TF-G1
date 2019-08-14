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
                    translate([main_tube_outer_diameter, - (hull_z_size - 2*hull_wall_thickness - 2*global_clearance)/2, -beam_thickness/2]) // podložka je vepředu seříznuta posunutím v ose X, aby vznikla toleranční mezera za přední částí krytu.
                        cube([hull_drop_length - main_tube_outer_diameter, hull_z_size - 2*hull_wall_thickness - 2*global_clearance, beam_thickness]);

                    translate([0, beam_side_edge_width/2, 0])
                        rotate([beam_edge_angle, 0, 0])
                            translate([0, 0, -50]) cube([1000, 50, 100]);


                    translate([0, beam_side_edge_width/2, 0])
                        rotate([-beam_edge_angle, 0, 0])
                            translate([0, 0, -50]) cube([1000, 50, 100]);
                }
            }
            for (j=[1,-1])
                for (i=[0:10]) {
                    translate([beam_patern*i + 5*j, 0, j*(beam_main_pipe_thickness+beam_vertical_space_between_pipes)])
                        rotate([-90, 0, 0])
                            cylinder(d = beam_main_pipe_thickness, h = hull_x_size);
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
        }
    }
}

888_1005();

use <./lib/naca4.scad>
include <../parameters.scad>
use <888_1000.scad>
