use <666_1004.scad>
use <666_1006.scad>
use <666_1014.scad>
use <666_1017.scad>
use <666_1026.scad>
include <../Parameters.scad>


translate([0,0,0])
666_1017();


translate([50,0,0])
666_1026();



translate([100,2,-3])
666_1004();



translate([150,90,0])
rotate([90,0,0])
666_1006();

translate([0,90,0])
rotate([90,0,0])
666_1006();

translate([0,-90,0])
rotate([-90,0,0])
666_1006();

translate([150,-90,0])
rotate([-90,0,0])
666_1006();



translate([200,0,0])
666_1014();


