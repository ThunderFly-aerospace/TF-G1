

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 333_1037(twosided = true, draft = false){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 970;       // celková délka polotovaru
    core_thickness = 1.0;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem

    if(twosided) // výpis vypočtené tloušťky profilu
        echo("Minimum material thickness", airfoil_thickness);
    else
        echo("Minimum material thickness", airfoil_thickness/2 - core_thickness/2);  

    difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar
        union(){
            // laminátové jádro listu
            difference (){
                cube([70, length, airfoil_thickness], center = true);

                // odečet frézovaného objemu, pokud jde o jednostranný polotovar, tak musí být zanechán materiál pro přidržení rámečku materiálu.
            	translate ([0, 0, 10/2 + (twosided ? (core_thickness/2) : (bridge_thickness + core_thickness/2))])
                    cube([70 - 2*7.5, length, 10], center = true);

                translate ([0, 0, -10/2 - (twosided ? core_thickness/2 : (bridge_thickness + core_thickness/2))])
                    cube([70 - 2*7.5, length, 10], center = true);
            }

            // kořeny rotorového listu
            translate ([ 0.1, -970/2 + 60, 0])
                cube ([50, 120, airfoil_thickness], center = true);

            translate ([ 0.1, 970/2 - 60, 0])
                cube ([50, 120, airfoil_thickness], center = true);

            // Samotný profil rotorového listu
            color("Blue",0.5)
            translate ([ -70/2 + 2.6 + 7.5, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);  

            // přechod z kořenu rotorového listu na list
            intersection(){
                translate ([ 0.1, 0, 0])
                    cube([50,length,airfoil_thickness], center = true);

                union(){
                    translate ([ -70/2 + 2.6 + 7.5, length/2, 0])
                        rotate([90, 0, 0])
                            bevel(120,15,15, draft ? 5 : 50)
                                airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);

                    translate ([ -70/2 + 2.6 + 7.5, -length/2, 0])
                        rotate([-90,0,0])
                            bevel(120,15,15,draft ? 5 : 50)
                                airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 100, h = length, open = false);
                }
            }
        }

        if(twosided == false)        // odečtení spodní poloviny listu a kompozitního jádra
            translate ([0, 0, -10/2 + core_thickness/2])
                cube([70, length, 10], center = true);
    }
}


333_1037(twosided = false, draft = true);

use <./lib/naca4.scad>
use <./lib/bevel.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>