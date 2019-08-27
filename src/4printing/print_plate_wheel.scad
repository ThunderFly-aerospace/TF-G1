include <../../parameters.scad>
use <../888_2011.scad>
use <../888_2012.scad>


translate([-25, 0, 0]) 888_2012();
translate([ 25, 0, 0]) 888_2012();
translate([0 , 30, 0]) 888_2011();
translate([0 , -30, 0]) 888_2011();
