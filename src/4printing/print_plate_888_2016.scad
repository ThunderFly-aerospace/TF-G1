include <../../parameters.scad>

use <../888_2016.scad>
        translate([-24, 0, 0])
            rotate([0, 90, 90])
                888_2016(draft=false);
        //translate([-30, 60, 0])
        //    rotate([0, 90, -90])
        //        888_2016_drill(draft=false);

        translate([24, 0, 0])
            rotate([0, 90, 90])
                888_2016(draft=false);
        //translate([30, 60, 0])
        //    rotate([0, 90, -90])
        //        888_2016_drill(draft=false);
