use <./lib/naca4.scad>
include <../Parameters.scad>


module 666_3067(){

height = 36;

    difference(){
        cylinder(d=10, h = height, $fn = 100);
        cylinder(d=M4_screw_diameter, h = 100, center= true, $fn = 50);

        translate([0,0,height - M4_nut_height - global_clearance])
            cylinder(d=M4_nut_diameter, h = 2*M4_nut_height, $fn = 6);
    }

}


666_3067();