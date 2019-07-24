include <../../parameters.scad>
use <../888_2014.scad>


translate([-10, -10, 0]) 888_2014();
translate([-10, 0, 0]) 888_2014();
translate([-10, 10, 0]) 888_2014();

translate([0, -10, 0]) 888_2014();
translate([0, 0, 0]) 888_2014();
translate([0, 10, 0]) 888_2014();

translate([10, -10, 0]) 888_2014();
translate([10, 0, 0]) 888_2014();
translate([10, 10, 0]) 888_2014();
