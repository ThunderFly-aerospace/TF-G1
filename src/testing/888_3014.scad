
//  Pripravek pro testovani rozsahu kuloveho loziska EFSM-12

include <../../parameters.scad>
$fn = 100;

module 888_3014(){
    height =  20;
    neck = 16;

    difference(){
        union(){
            cylinder(d = 15.4, h = height);
            cylinder(d = 11.9-0.2, h = height+neck);
        }

        cylinder(d = M8_screw_diameter, h = 50);
    }
}


888_3014();
