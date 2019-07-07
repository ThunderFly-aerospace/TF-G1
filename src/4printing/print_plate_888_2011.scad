include <../../parameters.scad>

use <../888_2011.scad>

translate([wheel_outer_diameter/4, 0, 0]) 888_2011(true);
translate([-wheel_outer_diameter/4, 0, 0]) 888_2011(false);
