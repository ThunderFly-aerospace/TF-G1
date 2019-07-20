include <../../parameters.scad>
use <../888_2013.scad>


rotate([0, 0, 0])
    888_2013(false, rotate = 1, right = 1);

translate([-35, 0, 0])
    rotate([0, 0, 0])
        888_2013(true, rotate = 1, right = 1);

translate([-35, -25, 0])
    rotate([0, 0, 180])
        888_2013(false, rotate = 1, right = 0);

translate([0, -25, 0])
    rotate([0, 0, 180])
        888_2013(true, rotate = 1, right = 0);
