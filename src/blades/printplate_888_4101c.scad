include <../../parameters.scad>
use <../lib/blade.scad>

translate([0, -10, 0]) blade_printpart(3);
translate([0, 10, 0]) blade_printpart(3);
translate([0, -30, 0]) blade_printpart(4);
translate([0, 30, 0]) blade_printpart(4);
