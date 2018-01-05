include <../../Parameters.scad>
use <../666_1027.scad>

draft = false;


translate([0,0,150])
    rotate([0,90,0])
        666_1027A(draft);
translate([0,35,150*2])
    rotate([0,90,0])
        666_1027B(draft);
translate([0,2*35,-150*2])
    rotate([0,-90,0])
        666_1027C(draft);
translate([0,3*35,-150*3])
    rotate([0,-90,0])
        666_1027D(draft);





