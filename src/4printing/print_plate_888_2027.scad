include <../../parameters.scad>

use <../888_2027.scad>

rotate([0, 180, 0])
    888_2027(front = true, draft=false);

translate([-35, 0, 0])
rotate([0, 180, 180])
    888_2027(front = false, draft=false);
