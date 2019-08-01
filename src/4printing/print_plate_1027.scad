include <../../parameters.scad>
use <../666_1027.scad>

//draft = false;

draft = true;

$vpd = 680;

translate([-3,0,0])
    rotate([0,-90,0])
        666_1027_part(1, 1, draft);

translate([-3,35,-base_division[1]])
    rotate([0,-90,0])
        666_1027_part(2, 1, draft);

translate([-3,2*35, -base_division[2]])
    rotate([0,-90,0])
        666_1027_part(3, 1, draft);

translate([-3,3*35,-base_division[3]])
    rotate([0,-90,0])
        666_1027_part(4, 1, draft);



translate([3,0,0])
    rotate([0,-90,0])
        666_1027_part(1, 0, draft);

translate([3,35,-base_division[1]])
    rotate([0,-90,0])
        666_1027_part(2, 0, draft);

translate([3,2*35, -base_division[2]])
    rotate([0,-90,0])
        666_1027_part(3, 0, draft);

translate([3,3*35,-base_division[3]])
    rotate([0,-90,0])
        666_1027_part(4, 0, draft);
