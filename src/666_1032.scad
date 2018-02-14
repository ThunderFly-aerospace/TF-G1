

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

    	airfoil(naca = airfoil_thickness, L = 170, N=101, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + coupling_wall_thickness, open = false);
    	translate ([hull_wall_thickness,0,45])
            resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*airfoil_thickness/100)- 2*hull_wall_thickness,210], auto=true) 
                airfoil(naca = airfoil_thickness, L = 170, N=101, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance, open = false);

    	//pro otevření
    	translate ([160,- hull_wall_thickness/2,- 2*global_clearance])
    	   cube ([20,hull_wall_thickness,height_of_vertical_tube + 4*global_clearance]);

    	translate ([main_tube_outer_diameter + coupling_wall_thickness*2,-depth/2 - global_clearance,height_of_vertical_tube - main_tube_outer_diameter*2 - global_clearance/2 + main_tube_outer_diameter/2 + coupling_wall_thickness])
    	   cube ([width*5,depth + 2*global_clearance,height+global_clearance + main_tube_outer_diameter]);

        // hull shell from 666_1025.scad
        translate ([- cover_pilon_position,0,0])
            rotate ([90,0,0])
                drop(draft);
    }
}

666_1032(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>