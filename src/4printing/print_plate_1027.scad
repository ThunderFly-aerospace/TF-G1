include <../../Parameters.scad>
use <../666_1027.scad>

translate([0,0,150])
    rotate([0,90,0])
        666_1027A();
translate([0,35,150*2])
    rotate([0,90,0])
        666_1027B();
translate([0,2*35,-150*2])
    rotate([0,-90,0])
        666_1027C();
translate([0,3*35,-150*3])
    rotate([0,-90,0])
        666_1027D();





