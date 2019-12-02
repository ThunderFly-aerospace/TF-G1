include <../../parameters.scad>
use <../lib/blade.scad>

//translate([0, 0, 0]) blade_printpart(0);
//translate([0, 20, 0]) blade_printpart(0);
translate([0, -20, 0]) blade_printpart(1);
translate([0, 40, 0]) blade_printpart(1);
translate([0, -40, 0]) blade_printpart(2);
translate([0, 60, 0]) blade_printpart(2);
