use <666_1004.scad>
use <666_1006.scad>
use <666_1014.scad>
use <666_1017.scad>
use <666_1026.scad>
include <../Parameters.scad>


translate([0,0,52.5])
rotate ([0,180,90])
666_1017();


translate([50,0,0])
666_1026();



translate([132,2,1])
rotate ([90,0,90])
666_1004();


translate([-167,2,1])
rotate ([90,0,90])
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

//hlavní trubky
difference (){

translate([-300,0,0])
rotate ([0,90,0])
cylinder (h = 600, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate([-303,0,0])
rotate([0,90,0])
cylinder (h = 606, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}


difference(){
cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate ([0,0,-3])
cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}

difference(){
translate([150,150,-27])
rotate ([90,0,0])
cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate([150,153,-27])
rotate ([90,0,0])
cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}

difference(){
translate([-150,150,-27])
rotate ([90,0,0])
cylinder (h = 300, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate([-150,153,-27])
rotate ([90,0,0])
cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}