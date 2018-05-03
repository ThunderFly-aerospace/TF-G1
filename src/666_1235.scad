
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 250;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

draft = false;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

// Nastavení zobrazení
/*$vpr = [38, 0, 38];
$vpt = [0, 0, 0];
$vpd = 1960;
*/


module 333_1035(twosided = true, draft = false){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 40;       // celková délka polotovaru
    material_width = 70;
    thickness = 0.3;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    milling_cutter_radius = 1.5;


    difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar
       //color("Blue",0.5)

        translate ([ -airfoil_depth/3, 0, 0])
            cube([airfoil_depth/1.5, length, 20], center = true);

        difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar

            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    hollow_airfoil(naca = airfoil_NACA, L = airfoil_depth, N = 100, h = length, open = true, wall_thickness = thickness); 

            translate([ airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 20], center = true);
        }

        difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar
            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8], center = true);

            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8 - 2*thickness], center = true);

        }

        translate([-airfoil_depth/10,0,0])
            rotate([0,0,90])
                union(){
                    // díry pro uchycení rotorového listu
                    translate([-15,0,0])
                        cylinder (h = 50, r = 3/2, $fn = 50, center = true);

                    translate([0,0,0])   
                        cylinder (h = 50, r = 3/2, $fn = 50, center = true);

                    translate([15, 0, 0])  
                        cylinder (h = 50, r = 3/2, $fn = 50, center = true);
                }

    } 
}

module 333_1037_doc(length = 970, material_width = 70, twosided = true, draft = false){

    translate([0, 0, DOC_HEIGHT])
    color("Black")
        union(){
            translate([-material_width / 2, length/ 2, 0])
                rotate([0, 0, 90])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, length/ 2, 0])
                rotate([0, 0, 90])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, length/ 2, 0])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, -length/ 2, 0])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);


            translate([-material_width / 2, length/2 + DIM_SPACE * 2 , 0])
                dimensions(material_width, line_width=DIM_LINE_WIDTH, loc=DIM_CENTER);

            translate([material_width / 2 + DIM_SPACE * 2, -length/ 2 , 0])
                rotate([0, 0, 90])
                    dimensions(length, line_width=DIM_LINE_WIDTH, loc=DIM_CENTER);
        }

}

333_1035();
//333_1037_doc(length=970);



use <./lib/naca4.scad>
use <./lib/bevel.scad>
use <./lib/dimlines.scad>
include <../Parameters.scad>
