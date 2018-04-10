
module 888_1008_A(){


    curvedPipe([[0,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],        //body ohybu
                [radius_undercarriage + 45 - tube_for_undercarriage_outer_diameter/2,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],
                [radius_undercarriage + 45 + vzdalenost_y,- vzdalenost_x + 2* main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,0],
                [radius_undercarriage + 45 + vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [+ vzdalenost_y + 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);


}

module 888_1008_B(){

    curvedPipe([[0,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],        //body ohybu
                [- radius_undercarriage - 45 + tube_for_undercarriage_outer_diameter/2,2 * main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,131],
                [- radius_undercarriage - 45 - vzdalenost_y,- vzdalenost_x + 2* main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter/2,0],
                [- radius_undercarriage - 45 - vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [- vzdalenost_y - 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);


}

translate([length_of_undercarriage_tube/2,0,0])
		888_1008_A();

translate([- length_of_undercarriage_tube/2,0,0])
		888_1008_B();


use <./lib/naca4.scad>
use <./lib/curvedPipe.scad>
include <../Parameters.scad>