use <../lib/naca4.scad>
include <../../Parameters.scad>
use <../666_1025.scad>

/*    rotate([90,90,0])
        666_1025A();
*/

translate([0,0,10])
    rotate([90,0,0])
        666_1025_part(1);

/*
translate([0,0,-170])
    rotate([90,-90,0])
        666_1025B();

translate([0,0,-340])
    rotate([90,-90,0])
        666_1025C();

*/

/*translate([30,0,-510])
    rotate([90,-90,0])
        666_1025D();
        */



