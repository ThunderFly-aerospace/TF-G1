//========== Tahlo predniho kolecka ==========//
include <../parameters.scad>

module 888_2029() {

screw_distance = 10;
wall = 4;

difference(){
    union(){
        hull(){
            cube([8, wall, 23]);
            cube([50, wall, 20]);
        }


        translate([20, 0, 0]){
            translate([-5+2, 0, 0])
                cube([5, wall + 4.5, 15]);


            translate([-2 + 27.5, 0, 0])
                cube([5, wall + 4.5, 15]);
        }
    }

    translate([4, 0, 8])
        rotate([90, 0, 0])
            cylinder(d = M3_screw_diameter, h = 10, $fn = 30, center = true);


        translate([4, 0, 8+10])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 10, $fn = 30, center = true);

        translate([20, 0, 0]){
            translate([0, 3+layer, 3])
                rotate([-90, 0, 0])
                    #cylinder(d = M2_screw_diameter, h = 20, $fn = 30);

            translate([0, 0, 3])
                rotate([-90, 0, 0])
                    #cylinder(d = M2_nut_diameter, h = 3, $fn = 6);


            translate([27.5, 3+layer, 3])
                rotate([-90, 0, 0])
                    #cylinder(d = M2_screw_diameter, h = 20, $fn = 30);

            translate([27.5, 0, 3])
                rotate([-90, 0, 0])
                    #cylinder(d = M2_nut_diameter, h = 3, $fn = 6);

        }
    }
}

mirror([0,1,0])
    888_2029();
