draft = true;

module 888_3014(draft){


    intersection(){
  
        translate ([140,75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
            rotate([90,-87,0])
                hollow_airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
     
       // víčko  pro servo
        translate([143,19.8,30])
            rotate([0,3,0])
                union(){
                    translate([-6, -(22.8 - 19.3) - 1.25, -4.95 - 1 - 0.25])
                        cube([13.5,22.8 + 4.5, 32.5 + 2 + 0.5]);
               	}
    }
}



888_3014();

use <888_1012.scad>

use <./lib/naca4.scad>
include <../Parameters.scad>
