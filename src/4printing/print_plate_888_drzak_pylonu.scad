include <../../parameters.scad>

use <../888_1030.scad>
use <../888_1031.scad>
$fn = 80;

translate([-20, 0, 0])
    888_1030();

translate([0, 20, 0])
    rotate([-90, 0, 0])
        translate([0, -beam_width/2 - pilon_pipe_diameter-15, 0])
            888_1031();

mirror([0, 1, 0])
translate([0, 20, 0])
    rotate([-90, 0, 0])
        translate([0, -beam_width/2 - pilon_pipe_diameter-15, 0])
            888_1031();
