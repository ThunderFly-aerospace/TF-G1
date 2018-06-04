
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

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


module 666_1201(draft = false, holes = true){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 970;       // celková délka polotovaru
    core_thickness = 1.0;       // tloušťka jádra
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    airfoil_thickness = (airfoil_NACA/100) * (airfoil_depth + bridge_thickness); // vypočtená maximální tloušťka profilu
    milling_cutter_radius = 1.5;

    echo("Minimum material thickness", airfoil_thickness);

    difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar
        union(){
            // profil rotorového listu
            //color("Blue",0.5)
            intersection(){
                cube([airfoil_depth, length,airfoil_thickness], center = true);

                translate ([ -airfoil_depth/2, length/2, 0])
                    rotate([90, 0, 0])
                        airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = draft ? 50 : 300, h = length, open = false);  
            }

            // kořen rotorevého listu
            translate ([0, -length/2 + 110/2, 0])
                cube([airfoil_depth, 110, airfoil_thickness], center = true);

            // přechod z kořenu rotorového listu na list
            intersection(){
                cube([airfoil_depth, length, airfoil_thickness], center = true);

                translate ([ -airfoil_depth/2, -length/2, 0])
                    rotate([-90,0,0])
                        bevel(110,15,15,draft ? 5 : 100)
                            airfoil(naca = airfoil_NACA, L = airfoil_depth, N = draft ? 50 : 200, h = length, open = false);

            }

            //zakončení listu
            translate ([-airfoil_depth/2, length/2, 0])
               intersection(){
                    translate ([airfoil_depth/2, 0, 0])
                        cube([airfoil_depth, length, airfoil_thickness], center = true);
            
                    rotate([0,90,0])
                        rotate_extrude($fn = draft ? 50 : 200)
                            rotate([0,0,90])
                                difference()
                                {
                                  polygon(points = airfoil_data(naca=airfoil_NACA, L = airfoil_depth + bridge_thickness, N=draft ? 50 : 200)); 
                                  square(airfoil_depth + bridge_thickness); 
                                }
                }

        }

        if (holes)
        {
            // díry pro uchycení listu
            translate([-airfoil_depth/4,-length/2,0])
                rotate([180,0,90])
                    union(){
                        // díry pro uchycení rotorového listu
                        translate([23-14,0,-1])
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([43-14,18,-1])   
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([63-14, 0, -1])  
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([83-14, 21-5, -1]) 
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([103-14, 0, -1]) 
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);
                    }

            // díry pro vyvážení
            translate([-airfoil_depth/4,length/4,0])
                rotate([0,0,90])
                    union(){
                        // díry pro uchycení rotorového listu
                        translate([-15,0,0])
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([0,0,0])   
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);

                        translate([15, 0, 0])  
                            cylinder (h = 2*airfoil_thickness, r = 3.6/2, $fn = 50, center = true);
                    }

        }


    }

}

module 666_1201_doc(length = 970, material_width = 50, twosided = true, draft = false){

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

666_1201(draft = draft, holes = true);
666_1201_doc(length=970);



use <./lib/naca4.scad>
use <./lib/bevel.scad>
use <./lib/dimlines.scad>
include <../Parameters.scad>
