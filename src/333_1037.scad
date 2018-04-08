
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 250;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

// Nastavení zobrazení
$vpr = [38, 0, 38];
$vpt = [0, 0, 0];
$vpd = 1960;



module 333_1037(twosided = true, draft = false){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 970;       // celková délka polotovaru
    material_width = 70;
    core_thickness = 1.0;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    milling_cutter_radius = 2.5;

    if(twosided) // výpis vypočtené tloušťky profilu
        echo("Minimum material thickness", airfoil_thickness);
    else
        echo("Minimum material thickness", airfoil_thickness/2 - core_thickness/2);  

    difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar
        union(){
            // laminátové jádro listu
            difference (){
                cube([material_width, length, airfoil_thickness], center = true);

                // odečet frézovaného objemu, pokud jde o jednostranný polotovar, tak musí být zanechán materiál pro přidržení rámečku materiálu.
            	translate ([0, 0, 10/2 + (twosided ? (core_thickness/2) : (bridge_thickness + core_thickness/2))])
                    minkowski()
                    {
                      cube([material_width - 2*7.5 - 2* milling_cutter_radius, length, 10 - 2* milling_cutter_radius], center = true);
                      rotate([90,0,0])
                        cylinder(r=milling_cutter_radius, h=1, $fn = draft ? 20 :50);
                    }

                translate ([0, 0, -10/2 - (twosided ? core_thickness/2 : (bridge_thickness + core_thickness/2))])
                    cube([material_width - 2*7.5, length, 10], center = true);
            }

            // kořeny rotorového listu
            translate ([ 0.1, -970/2 + 60, 0])
                cube ([50, 120, airfoil_thickness], center = true);

            translate ([ 0.1, 970/2 - 60, 0])
                cube ([50, 120, airfoil_thickness], center = true);

            // Samotný profil rotorového listu
            //color("Blue",0.5)
            translate ([ -material_width/2 + 2.6 + 7.5, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);  

            // přechod z kořenu rotorového listu na list
            intersection(){
                union(){
                translate ([ 0.1, 0, 0])
                    cube([50,length,airfoil_thickness], center = true);
                }

                union(){
                    translate ([ -material_width/2 + 2.6 + 7.5, length/2, 0])
                        rotate([90, 0, 0])
                            bevel(120,15,15, draft ? 5 : 50)
                                airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);

                    translate ([ -material_width/2 + 2.6 + 7.5, -length/2, 0])
                        rotate([-90,0,0])
                            bevel(120,15,15,draft ? 5 : 50)
                                airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);
                }
            }
        }

        if(twosided == false)        // odečtení spodní poloviny listu a kompozitního jádra
            translate ([0, 0, -10/2 + core_thickness/2])
                cube([material_width, length, 10], center = true);
    }
}

module 333_1037_doc(length = 970, material_width = 70, twosided = true, draft = false){

    translate([0, 0, DOC_HEIGHT])
    color("Black")
        union(){
            translate([-material_width / 2, length/ 2 , 0])
                rotate([0, 0, 90])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, length/ 2 , 0])
                rotate([0, 0, 90])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, length/ 2 , 0])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);

            translate([material_width / 2, -length/ 2 , 0])
                line(DIM_SPACE * 3, line_width=DIM_LINE_WIDTH);


            translate([-material_width / 2, length/2 + DIM_SPACE * 2 , 0])
                dimensions(material_width, line_width=DIM_LINE_WIDTH, loc=DIM_CENTER);

            translate([material_width / 2 + DIM_SPACE * 2, -length/ 2 , 0])
                rotate([0, 0, 90])
                    dimensions(length, line_width=DIM_LINE_WIDTH, loc=DIM_CENTER);
        }

}

333_1037(twosided = false, draft = draft);
333_1037_doc(length=970);


use <./lib/naca4.scad>
use <./lib/bevel.scad>
use <./lib/dimlines.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>
