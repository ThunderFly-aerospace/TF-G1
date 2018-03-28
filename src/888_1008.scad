module 888_1008(){


    curvedPipe([[0,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],        //body ohybu
                [radius_undercarriage,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],
                [radius_undercarriage + vzdalenost_y,- vzdalenost_x + 2* main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,0],
                [radius_undercarriage + vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [+ vzdalenost_y + 10/2, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                10,
                8);


translate([- length_of_undercarriage_tube, 0,0,])

mirror([1,0,0])
    curvedPipe([[0,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],        //body ohybu
                [radius_undercarriage,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],
                [radius_undercarriage + vzdalenost_y,- vzdalenost_x + 2* main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,0],
                [radius_undercarriage + vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [+ vzdalenost_y + 10/2, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                10,
                8);
}



888_1008();

use <./lib/naca4.scad>
use <./lib/curvedPipe.scad>
include <../Parameters.scad>