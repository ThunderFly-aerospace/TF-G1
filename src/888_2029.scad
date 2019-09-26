//========== Tahlo predniho kolecka ==========//
include <../parameters.scad>

module 888_2029() {

screw_distance = 10;


difference(){
    union(){
        hull(){
            cube([10, 20, 2]);
            cube([3, 20, 10]);
        }
        hull(){
            cube([3, 20, 10]);
            translate([0, 10, 20])
                rotate([0, 90, 0])
                    cylinder(d = 10, h = 3);

        }
    }

    translate([0, 10, 20])
        rotate([0, 90, 0])
            cylinder(d = M3_screw_diameter, h = 3.5, $fn = 30);

    translate([7, 10-5, -0.1])
        cylinder(d = M3_screw_diameter, h = 10, $fn = 30);

    translate([7, 10+5, -0.1])
        cylinder(d = M3_screw_diameter, h = 10, $fn = 30);


    translate([7, 10-5, -0.1+2])
        cylinder(d = M3_nut_diameter, h = 10, $fn = 30);

    translate([7, 10+5, -0.1+2])
        cylinder(d = M3_nut_diameter, h = 10, $fn = 30);


}


}

888_2029();
