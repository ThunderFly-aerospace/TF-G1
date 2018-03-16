

draft = false;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 333_1037(draft){

    airfoil_thickness = 0015;
    airfoil_depth = 50;
    length = 970;
    core_thickness = 1.0;


   difference (){
        cube([70,length,3.86*2], center = true);

    	translate ([0,0, 10/2 + core_thickness/2])
            cube([70 - 2*7.5, length, 10], center = true);

        translate ([0,0, -10/2 - core_thickness/2])
            cube([70 - 2*7.5, length, 10], center = true);
    }

    translate ([ 0.1, -970/2 + 60, 0])
        cube ([50, 120, 3.86*2], center = true);

    translate ([ 0.1, 970/2 - 60, 0])
        cube ([50, 120, 3.86*2], center = true);

    translate ([ -70/2 + 2.6 + 7.5, length/2, 0])
        rotate([90,0,0])
            airfoil(naca = airfoil_thickness, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);


    intersection(){
        translate ([ 0.1, 0, 0])
            cube([50,length,3.86*2], center = true);

        union(){
            translate ([ -70/2 + 2.6 + 7.5, length/2, 0])
                rotate([90,0,0])
                    bevel(120,15,15,20)
                        airfoil(naca = airfoil_thickness, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);

            translate ([ -70/2 + 2.6 + 7.5, -length/2, 0])
                rotate([-90,0,0])
                    bevel(120,15,15,draft ? 10 : 50)
                        airfoil(naca = airfoil_thickness, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);
        }
    }

}


333_1037(draft);

use <./lib/naca4.scad>
use <./lib/bevel.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>