include <../../parameters.scad>
draft = $preview;

use<../888_1031.scad>

888_1031_drill_a(draft=draft);
translate([30, 0, 0])888_1031_drill_a(draft=draft);
