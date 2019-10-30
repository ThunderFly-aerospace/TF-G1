use <../888_2017.scad>


translate([0,  23, 0]) 888_2017(right = 0, print_orientation = 1);
translate([0, -23, 0]) rotate([0, 0, 180]) 888_2017(right = 1, print_orientation = 1);
