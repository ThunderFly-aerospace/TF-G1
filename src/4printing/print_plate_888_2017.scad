use <../888_2017.scad>


translate([0,  23, 0]) 888_2017(left = 0, print_orientation = 1, draft = $preview);
translate([0, -23, 0]) rotate([0, 0, 180]) 888_2017(left = 1, print_orientation = 1, draft = $preview);
