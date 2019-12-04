include <../../parameters.scad>
use <../lib/blade.scad>

rotate([0, 180, 0]){
translate([0, -5, 0])
difference(){
  translate([0, 0, 0]) rotate([0, 0, 0]) blade_printpart(0);
  translate([-20, 0, 0]) cube([100, 10, 140]);
}
translate([0, -20, 0])
difference(){
  translate([0, 0, 0]) rotate([0, 0, 0]) blade_printpart(0);
  translate([-20, 0, 0]) cube([100, 10, 140]);
}

translate([0, 5, 0])
difference(){
  translate([0, 0, 0]) rotate([0, 0, 0]) blade_printpart(0);
  translate([-20, -10, 0]) cube([100, 10, 140]);
}

translate([0, 20, 0])
difference(){
  translate([0, 0, 0]) rotate([0, 0, 0]) blade_printpart(0);
  translate([-20, -10, 0]) cube([100, 10, 140]);
}
}
