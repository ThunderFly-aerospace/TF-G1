module 666_1233(){

    thickness = 12; 

    difference(){
        cylinder (h = thickness, d = 5*M3_screw_diameter, $fn = 50);
        cylinder (h = thickness, d = M3_screw_diameter, $fn = 20);
    }
}
666_1233();

include <../parameters.scad>