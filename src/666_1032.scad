

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 666_1032(draft){

    airfoil_thickness = 0030;
    depth = main_tube_outer_diameter*2;
    width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
    height = depth;

    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

    difference (){
        union(){

            difference(){
            	airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + coupling_wall_thickness, open = false);
            	translate ([hull_wall_thickness,0,45])
                    resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*airfoil_thickness/100)- 2*hull_wall_thickness,height_of_vertical_tube + main_tube_outer_diameter/2 + 4*global_clearance + coupling_wall_thickness], auto=true) 
                        airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + coupling_wall_thickness, open = false);
            }
            //lem spodní a horní díl
            intersection(){
                difference(){
                    translate([0,-75,cover_pilon_division[1] - hull_wall_thickness])
                            cube([190,150,2*hull_wall_thickness]);

                    translate ([ribbon_width,0,45])
                        resize([170 - ribbon_width - trailing_wall*ribbon_width,(170*airfoil_thickness/100)- 2*ribbon_width,210], auto=true) 
                            airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance, open = false);
                }
                airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + coupling_wall_thickness, open = false);
            }
        }
    	//pro otevření
    	translate ([120,- hull_wall_thickness/2,- 2*global_clearance])
    	   cube ([60,hull_wall_thickness,height_of_vertical_tube + 4*global_clearance]);

    	translate ([main_tube_outer_diameter + coupling_wall_thickness*2,-depth/2 - global_clearance,height_of_vertical_tube - main_tube_outer_diameter*2 - global_clearance/2 + coupling_wall_thickness + main_tube_outer_diameter/2])
    	   cube ([width*5,depth + 2*global_clearance,height+global_clearance + main_tube_outer_diameter]);

        // hull shell from 666_1025.scad
        translate ([ - cover_pilon_position,0,0])
            rotate ([90,0,0])
                drop(draft);
    //final difference
    }
//final module
}


//pro tisk

module 666_1032_A(draft){
        intersection(){
                666_1032(draft);
            translate([0,- 75,0])
                cube([180,150,cover_pilon_division[1]]);
        }
}

module 666_1032_B(draft){
    translate([0,0,20])
        intersection(){
                666_1032(draft);
            translate([0,- 75,cover_pilon_division[1]])
                cube([180,150,cover_pilon_division[2] - cover_pilon_division[1]]);
        }
}

666_1032(draft);
//666_1032_A(draft);
//666_1032_B(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>