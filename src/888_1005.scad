include <../parameters.scad>
use <./lib/stdlib/naca4.scad>
//use <666_1025.scad>
use <888_1000.scad>
use <888_1025.scad>

/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = $preview;


////////////////////////////
module 888_1005 (draft){

  translate([-engine_holder_beam_depth, 0, 0])
    union(){
//samotná podložka

        difference(){
            union(){
                intersection (){
                    translate([hull_wall_thickness + global_clearance, 0, 0])
                        rotate([90, 0, 0])
                            hollowing_skeleton(hull_wall_thickness + global_clearance, draft);

                    translate([main_tube_outer_diameter, - (hull_z_size - 2*hull_wall_thickness - 2*global_clearance)/2, -beam_thickness_below]) // podložka je vepředu seříznuta posunutím v ose X, aby vznikla toleranční mezera za přední částí krytu.
                        cube([hull_drop_length - main_tube_outer_diameter, hull_z_size - 2*hull_wall_thickness - 2*global_clearance, ring_thickness]);

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
                        // nosna tyc
                        rotate([-90, 0, 0])
                            cylinder(d = beam_main_pipe_thickness, h = hull_x_size, $fn = draft? 10 : 50);

                        translate([0, collar_holes_distance/2, 0])
                            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = draft? 8 : 20);

                        translate([0, collar_holes_distance/2, -8-50])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                        translate([0, collar_holes_distance/2, 8])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                    }
                }

          //šrouby a matky HORNÍ kryt - vždy spojení šroubu a matky dohromady

            rotate([90,0,0])
                for (position_number = [0:4]){
                    cover_screw(position_number, top = true, draft = draft);
                    cover_screw(position_number, top = false, draft = draft);
                }


            // drazka podel pro zastrceni krytu
            intersection(){
                difference(){
                    union(){
                        translate([0,-hull_z_size/2, 0])
                            cube([hull_x_size, hull_z_size, hull_wall_thickness*2 + 2*global_clearance]); // horni lem
                        translate([0,-hull_z_size/2, -15])
                            cube([hull_x_size, hull_z_size, hull_wall_thickness*2 + 2*global_clearance]); // spodní lem
                    }

                    //odebrání dna
                    translate([ribbon_width,0,0])
                        rotate([90, 0, 0])
                            hollowing_skeleton(ribbon_width, draft);
                }

            //odstranění dna z vnější strany krytu
                drop(draft);
            }

            /* translate([0, collar_holes_distance/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = beam_main_pipe_thickness, h = 1000, $fn = draft? 8 : 50); */


        }
    }
}


module 888_1005_cut(){
    translate([35, 0, 0])
        difference(){
            intersection(){
                translate([0, -100, beam_patern*(4)])
                    rotate([0, 90, 0])
                        translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                            888_1005($preview);

                translate([-20, -20, 0])
                    cube([40, 40, beam_patern*3.5]);
            }
            translate([-17, 0, 0]) linear_extrude(0.2) text("A", valgin = "center", halgin = "center");
        }
    translate([0, 0, 0])
        difference(){
            intersection(){
                translate([0, -100, beam_patern*(4+1)])
                    rotate([0, 90, 0])
                        translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                            888_1005($preview);

                translate([-20, -20, 0])
                    cube([40, 40, beam_patern*1]);
            }
            translate([-17, 0, 0]) linear_extrude(0.2) text("B", valgin = "center", halgin = "center");
        }
    translate([-35, 0, beam_patern*(3.5)]) rotate([180, 0, 0])
        difference(){
            intersection(){
                translate([0, -100, beam_patern*(4+1+3.5)])
                    rotate([0, 90, 0])
                        translate([- engine_holder_beam_depth + beam_patern*(1), 0, 0])
                            888_1005($preview);

                translate([-20, -20, 0])
                    cube([40, 40, beam_patern*3.5]);
            }
            translate([-17, 0, beam_patern*(3.5)]) linear_extrude(0.2) text("C", valgin = "center", halgin = "center");
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


module 888_1005_rear(){
    translate([-engine_holder_beam_depth, 0, 0])
    difference(){
        union(){
            intersection(){
                translate([beam_length + engine_holder_beam_depth, -100, -beam_thickness_below])
                    cube([50, 200, ring_thickness]);
                rotate([90, 0, 0])
                    //translate([-engine_holder_beam_depth, 0, 0])
                        hollowing_skeleton(hull_wall_thickness + global_clearance, draft);

            }

        }

        translate([beam_length, -beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_diameter, h = 50);

        translate([beam_length, beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_diameter, h = 50);

        //translate([ribbon_width-55,0,0])
        rotate([90, 0, 0]){
            cover_screw(6, true, draft);
            cover_screw(6, false, draft);
        }

        mirror([0, 1, 0])
            rotate([90, 0, 0]){
                cover_screw(6, true, draft);
                cover_screw(6, false, draft);
            }

        translate([-engine_holder_beam_depth, 0, 0])

        intersection(){
            //translate([12,0,0])
            translate([engine_holder_beam_depth, 0, 0])
                rotate([90, 0, 0])
                    translate([10, 0, 0])
                    hollowing_skeleton(10, draft);
            translate([0, -250, beam_thickness_above])
                cube([1000, 500, 20]);
        }


        // drazka pro kryt
        intersection(){
            difference(){
                union(){
                    translate([0,-hull_z_size/2, 0])
                        cube([hull_x_size, hull_z_size, hull_wall_thickness*2+2*global_clearance]); // spodní lem
                    translate([0,-hull_z_size/2, -15])
                        cube([hull_x_size, hull_z_size, hull_wall_thickness*2+2*global_clearance]); // spodní lem
                }

                //odebrání dna
                translate([ribbon_width+1.5, 0, 0])
                    rotate([90, 0, 0])
                        hollowing_skeleton(ribbon_width+1.5, draft);
            }

        //odstranění dna z vnější strany krytu
        drop(draft);
        }

    }
}


module 888_1005_pipe(draft = true){

    echo("Vzdalenost der v limci:", collar_holes_distance);
    echo("Vzdalenost hran v limci:", hull_z_size);

    difference(){
        rotate([90, 0, 0])
            cylinder(d = beam_main_pipe_diameter, h = hull_z_size, center = true, $fn = draft? 20:50);
        rotate([90, 0, 0])
            cylinder(d = beam_main_pipe_diameter-3, h = hull_z_size+1, center = true, $fn = draft? 20:50);

        translate([0, 0, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 12:30);
        translate([0, collar_holes_distance/2+8, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 12:30);
        translate([0,-collar_holes_distance/2-8, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 12:30);
    }

}

translate([0,0,0])
    888_1005(draft);
mirror([0, 1, 0])
    888_1005();

888_1005_rear();

//for (i=[3,4])
//    translate([beam_patern*(i), 0, -(beam_main_pipe_thickness+beam_vertical_space_between_pipes)])
//        888_1005_pipe(draft);
