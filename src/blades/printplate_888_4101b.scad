include <../../parameters.scad>
use <../lib/blade.scad>

translate([0, 0, 0]) blade_printpart(3);
translate([0, 20, 0]) blade_printpart(3);
translate([0, -20, 0]) blade_printpart(4);
translate([0, 40, 0]) blade_printpart(4);
translate([0, -40, 0]) blade_printpart(5);
translate([0, 60, 0]) blade_printpart(5);
