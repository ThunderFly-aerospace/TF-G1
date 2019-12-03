include <../../parameters.scad>
use <../lib/blade.scad>

translate([0, -10, 0]) blade_printpart(5);
translate([0, 10, 0]) blade_printpart(5);
translate([0, -30, 0]) blade_printpart(6);
translate([0, 30, 0]) blade_printpart(6);
