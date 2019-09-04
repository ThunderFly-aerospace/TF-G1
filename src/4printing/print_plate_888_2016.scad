include <../../parameters.scad>

use <../888_2016.scad>

        translate([-8, -17, 0])
            rotate([0, 0, 0])
                888_2016(draft=false);
        //translate([-30, 60, 0])
        //    rotate([0, 90, -90])
        //        888_2016_drill(draft=false);

        translate([8, 17, 0])
            rotate([0, 0, 0])
                888_2016(draft=false);
        //translate([30, 60, 0])
        //    rotate([0, 90, -90])
        //        888_2016_drill(draft=false);
/*

translate([50, 25, 0])
    888_2016_drill();

translate([42, -25, 0])
    888_2016_drill(); */
