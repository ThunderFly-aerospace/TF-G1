include <../../../parameters.scad>
use <../888_1014.scad>

draft = false;


        888_1014_part(0, draft);

rotate([0,180,0])
    translate([-60,0,-300])
            888_1014_part(1, draft);
/*translate([-60,0,-300])
        888_1014_part(2, draft);

translate([0,-85,0])
    rotate([0,0,90])
        translate([0,0,-450])
                888_1014_part(3, draft);
*/




