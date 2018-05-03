
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
    thickness = 0.5;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    milling_cutter_radius = 1.5;


    difference (){
       //color("Blue",0.5)

        translate ([ -airfoil_depth/2, 0, 0])
            cube([airfoil_depth - airfoil_depth/4, length, 30], center = true);

        difference (){ // profil listu

            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    hollow_airfoil(naca = airfoil_NACA, L = airfoil_depth, N = 100, h = length, open = true, wall_thickness = thickness); 

            translate([ airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 20], center = true);
        }

        difference (){ // profil závaží

            translate ([ -airfoil_depth/2 - 4, length/2, 0])
                rotate([90, 0, 0])
                    hollow_airfoil(naca = airfoil_NACA, L = airfoil_depth, N = 100, h = length, open = true, wall_thickness = thickness); 

            translate([ airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 20], center = true);
        }


        difference (){  // odečet tloušťky plechu v rovné části
            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8], center = true);

            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8 - 2*thickness], center = true);

        }

        translate([-airfoil_depth/4,0,0])
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


module 333_1035_A(twosided = true, draft = false){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 40;       // celková délka polotovaru
    material_width = 70;
    thickness = 0.5;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    weight_thickness = 4;


    difference (){
       //color("Blue",0.5)

        translate ([ -airfoil_depth/2, 0, 0])
            cube([airfoil_depth - airfoil_depth/4, length, 30], center = true);


        difference (){ // profil závaží

            translate ([ -airfoil_depth/2 - weight_thickness, length/2, 0])
                rotate([90, 0, 0])
                    hollow_airfoil(naca = airfoil_NACA, L = airfoil_depth, N = 100, h = length, open = true, wall_thickness = thickness); 

            translate([ airfoil_depth/4 - weight_thickness, 0, 0])
                cube([airfoil_depth, length, 20], center = true);
        }


        difference (){  // odečet tloušťky plechu v rovné části
            translate ([airfoil_depth/4 - weight_thickness, 0, 0])
                cube([airfoil_depth, length, 8], center = true);

            translate ([airfoil_depth/4 - weight_thickness, 0, 0])
                cube([airfoil_depth, length, 8 - 2*thickness], center = true);

        }

        translate([-airfoil_depth/4,0,0])
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


module 333_1035_B(twosided = true, draft = false){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 40;       // celková délka polotovaru
    material_width = 70;
    thickness = 0.5;       // tloušťka jádra
    airfoil_thickness = (airfoil_NACA/100) * airfoil_depth; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    milling_cutter_radius = 1.5;


    difference (){
       //color("Blue",0.5)

        translate ([ -airfoil_depth/2, 0, 0])
            cube([airfoil_depth - airfoil_depth/4, length, 30], center = true);

        difference (){ // profil listu

            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    hollow_airfoil(naca = airfoil_NACA, L = airfoil_depth, N = 100, h = length, open = true, wall_thickness = thickness); 

            translate([ airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 20], center = true);
        }

        difference (){  // odečet tloušťky plechu v rovné části
            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8], center = true);

            translate ([airfoil_depth/4, 0, 0])
                cube([airfoil_depth, length, 8 - 2*thickness], center = true);

        }

        translate([-airfoil_depth/4,0,0])
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


333_1035_A();
//333_1037_doc(length=970);

/*probe(volume=true) {
    sphere(20);
    echo("volume is ",volume);
}*/



use <./lib/naca4.scad>
use <./lib/bevel.scad>
use <./lib/dimlines.scad>
include <../Parameters.scad>
