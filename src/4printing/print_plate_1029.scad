include <../../Parameters.scad>
use <../666_1029.scad>

draft = true;


/*translate([0,0,150])
    rotate([0,90,0])
        666_1029A();
translate([0,35,150*2])
    rotate([0,90,0])
        666_1029B();
translate([0,2*35,-150*2])
    rotate([0,-90,0])
        666_1029C();*/
translate([0,3*35,-150*3-10])
    rotate([0,-90,0])
        666_1029_part(2, draft);





