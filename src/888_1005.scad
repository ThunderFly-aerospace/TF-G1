include <../parameters.scad>
use <./lib/stdlib/naca4.scad>
//use <666_1025.scad>
use <888_1000.scad>

/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = $preview;

module screw_top (position_number, draft){
    //funkce

    distance_top = - hull_drop_length * surface_distance(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
    //echo (distance_top);

    if (position_number > 2 && position_number < 5) //tato podmínka znamená, že v pozici 2,3 a 4 se šroub neotáčí podle surface_angle a ani neposouvá podle surface_distance, protože je na podložce rovná hrana. Je tam tedy dané pevné posunugí -hull_z_size/2
    {


        if (distance_top <= -(hull_z_size-2*hull_corner_radius) /2)
        {
            distance_top = - (hull_z_size-2*hull_corner_radius)/2;
            translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size/2])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                            cube([M3_nut_diameter, M3_nut_diameter+20, M3_nut_height]);
                        translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                            cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                    }
            //final if
            }

        else
        {
            distance_top = distance_top;
            translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                            cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                        translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                            cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                    }
        //final if
        }
    //final if
    }
    else
    {
        if (distance_top <= -(hull_z_size-2*hull_corner_radius)/2)
        {
            distance_top = - (hull_z_size-2*hull_corner_radius)/2;
            translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
                rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                            cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                        translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                            cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                        //final union
                    }
        //fianl if
        }

        else
        {
            distance_top = distance_top;
            translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
                rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                           cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                        translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                            cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                    }
        //final if
        }
        //final if
    }
}


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

                        translate([0, 108, 0])
                            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = draft? 8 : 20);

                        translate([0, 108, -8-50])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                        translate([0, 108, 8])
                            cylinder(d = M3_nut_diameter, h = 50, $fn = 6);

                    }
                }

          //šrouby a matky HORNÍ kryt - vždy spojení šroubu a matky dohromady

            rotate([90,0,0])
                for (position_number = [2:4])
                {
                        screw_top(position_number, draft);
                }

            // drazka podel pro zastrceni krytu
            intersection(){
                difference(){
                    translate([0,-hull_z_size/2, 0])
                        cube([hull_x_size, hull_z_size, hull_wall_thickness*2]); // spodní lem

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
                    cylinder(d = beam_main_pipe_thickness, h = 1000, $fn = draft? 8 : 50);

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
    //translate([55, 0, 0])
    difference(){
        union(){
            intersection(){
                translate([beam_length , -100, -beam_thickness_below])
                    cube([50, 200, ring_thickness]);
                rotate([90, 0, 0])
                    translate([-engine_holder_beam_depth, 0, 0])
                        hollowing_skeleton(hull_wall_thickness + global_clearance, draft);

            }

        }

        translate([beam_length, -beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_diameter, h = 50);

        translate([beam_length, beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_diameter, h = 50);

        translate([ribbon_width-55,0,0])
            rotate([90, 0, 0])
                #screw_top(6, draft);

        translate([-engine_holder_beam_depth, 0, 0])

        
        

        // drazka pro kryt
        intersection(){
            difference(){
                translate([0,-hull_z_size/2, 0])
                    cube([hull_x_size, hull_z_size, hull_wall_thickness*2]); // spodní lem

                //odebrání dna
                translate([ribbon_width/2,0,0])
                    rotate([90, 0, 0])
                        hollowing_skeleton(ribbon_width, draft);
            }

        //odstranění dna z vnější strany krytu
        drop(draft);
        }

    }
}


module 888_1005_pipe(draft = true){

    echo("Vzdalenost der v limci:", 108*2);
    echo("Vzdalenost hran v limci:", hull_z_size);

    difference(){
        rotate([90, 0, 0])
            cylinder(d = beam_main_pipe_diameter, h = hull_z_size, center = true, $fn = draft? 8:50);
        rotate([90, 0, 0])
            cylinder(d = beam_main_pipe_diameter-3, h = hull_z_size+1, center = true, $fn = draft? 8:50);

        translate([0, 0, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 6:20);
        translate([0, beam_side_pipe_distance/2, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 6:20);
        translate([0,-beam_side_pipe_distance/2, 0])
            cylinder(d = M3_screw_diameter, h=50, center = true, $fn = draft? 6:20);
    }

}

translate([0,0,0])
    888_1005(draft);
mirror([0, 1, 0])
    888_1005();

888_1005_rear();

for (i=[3,4])
    translate([beam_patern*(i), 0, -(beam_main_pipe_thickness+beam_vertical_space_between_pipes)])
        888_1005_pipe(draft);