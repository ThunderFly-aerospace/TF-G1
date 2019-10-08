include <../../parameters.scad>
draft = $preview;
$fn = 30;
use<../888_1035.scad>

rotate([0, -90, 0]) 888_1035();
translate([2, 0, 0]) rotate([0, -90, 180]) 888_1035();
