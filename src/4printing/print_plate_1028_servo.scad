include <../../Parameters.scad>
use <../888_1012.scad>

draft = false;

rotate([0,-90,0])
    888_1012_C();

translate([20,0,0])
    rotate([0,90,0])
        888_1012_B();





