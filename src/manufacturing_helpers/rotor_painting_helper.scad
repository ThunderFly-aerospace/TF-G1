
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <../lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

// Nastavení zobrazení
/*$vpr = [38, 0, 38];
$vpt = [0, 0, 0];
$vpd = 1960;
*/


module painting_helper(draft = false, holes = true){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 52; // hloubka profilu
    length = 100;       // celková délka polotovaru
    core_thickness = 1.0;       // tloušťka jádra
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    airfoil_thickness = (airfoil_NACA/100) * (airfoil_depth + bridge_thickness); // vypočtená maximální tloušťka profilu
    milling_cutter_radius = 1.5;

    difference(){
        translate([-airfoil_depth/4, - airfoil_depth/2, 0])
            cube([airfoil_depth*1.5, airfoil_depth, length + length/10]);
           
        translate([0,0,length/10])
            airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = draft ? 50 : 300, h = length, open = false);  
    }
}

painting_helper(draft = draft, holes = true);



use <../lib/naca4.scad>
use <../lib/bevel.scad>
use <../lib/dimlines.scad>
include <../../parameters.scad>
