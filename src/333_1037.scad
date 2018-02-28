

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 333_1037(draft){

    airfoil_thickness = 0015;
    airfoil_depth = main_tube_outer_diameter*2;
    lenght = 970;


    difference (){
        %cube ([970,70,3.86*2], center = true);

    	translate ([120,- hull_wall_thickness/2,- 2*global_clearance])
            cube ([60,hull_wall_thickness,height_of_vertical_tube + 4*global_clearance]);
    }

    //translate ([120,- hull_wall_thickness/2,- 2*global_clearance])
    rotate([90,0,0])
        airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes, open = false);

}



333_1037(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>