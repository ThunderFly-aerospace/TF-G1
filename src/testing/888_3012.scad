
//
//   Pripravek pro testovani vzdalenosti remenic na rotoru
//    vklada se do velkeho ozubeneho kola
//

include <../../parameters.scad>
$fn = 100;

difference(){

    union(){
        cylinder(d=26, h=20.2+3);
        cylinder(d=42, h=3+3);
        cylinder(d=50, h=3);
    }

    cylinder(d=M6_screw_diameter, h=25);


    translate([-32/2, 0, 0])
        cylinder(h = 20, d = M4_screw_diameter, $fn = 30);

    translate([32/2, 0, 0])
        cylinder(h = 20, d = M4_screw_diameter, $fn = 30);

    translate([0, 32/2, 0])
        cylinder(h = 20, d = M4_screw_diameter, $fn = 30);

    translate([0, -32/2, 0])
        cylinder(h = 20, d = M4_screw_diameter, $fn = 30);

}
