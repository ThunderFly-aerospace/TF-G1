include <../../parameters.scad>
use <../666_1027.scad>

draft = false;

$vpd = 680;
        
translate([0,3*35,-base_division[3]])
    rotate([0,-90,0])
        666_1027_part(4, draft);





