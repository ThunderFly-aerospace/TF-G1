//========== Tahlo predniho kolecka ==========//
include <../parameters.scad>

module 888_2028() {

screw_distance = 10;
hole_distance = 27;
hole_offset = -10;


difference(){
    union(){
        hull(){
            cube([11, 20, 4]);
            cube([3, 20, 9]);
        }
        hull(){
            cube([7, 20, 15]);
            translate([0, 10+hole_offset, hole_distance])
                rotate([0, 90, 0])
                    cylinder(d = 10, h = 6, $fn = 60);

        }
    }

    translate([-layer, 10+hole_offset, hole_distance])
        rotate([0, 90, 0])
            cylinder(d = M2_screw_diameter, h = 20, $fn = 30);

    translate([5, 10+hole_offset, hole_distance])
        rotate([0, 90, 0])
            cylinder(d = M2_nut_diameter, h = M2_nut_height, $fn = 6);

    translate([7, 10-5, -0.1])
        cylinder(d = M3_screw_diameter, h = 10, $fn = 30);

    translate([7, 10+5, -0.1])
        cylinder(d = M3_screw_diameter, h = 10, $fn = 30);


    translate([7, 10-5, -0.1+4])
        cylinder(d = M3_nut_diameter, h = 11, $fn = 30);

    translate([7, 10+5, -0.1+4])
        cylinder(d = M3_nut_diameter, h = 11, $fn = 30);


}


}

888_2028();
