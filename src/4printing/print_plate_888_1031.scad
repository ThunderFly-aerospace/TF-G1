include <../../parameters.scad>
draft = $preview;

use<../888_1031.scad>

translate([0, -20, 0]) rotate([-90, 0, 0]) 888_1031(draft=draft);
mirror([0, 1, 0]) rotate([-90, 0, 0]) 888_1031(draft=draft);
