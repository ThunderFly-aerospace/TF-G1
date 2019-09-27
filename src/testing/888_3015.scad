
//  Pripravek pro testovani rozsahu kuloveho loziska EFSM-12

include <../../parameters.scad>
$fn = 100;

module 888_3015(){
    height =  15;
    neck = 10;

    difference(){
        union(){
            cylinder(d = 15 - 0.5, h = height);
            cylinder(d = bearing_efsm_12_d, h = height+neck);
        }
        cylinder(d = M8_screw_diameter, h = 50);
    }
}


888_3015();
