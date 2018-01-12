include <../../Parameters.scad>
use <../666_1027.scad>

draft = false;

$vpd = 680;

translate([0,0,base_division[1]])
    rotate([0,90,0])
        666_1027_part(1, draft);
translate([0,30,base_division[2]])
    rotate([0,90,0])
        666_1027_part(2, draft);
translate([0,2*30, -base_division[2]])
    rotate([0,-90,0])
        666_1027_part(3, draft);
        
translate([0,3*30,-base_division[3]])
    rotate([0,-90,0])
        666_1027_part(4, draft);





