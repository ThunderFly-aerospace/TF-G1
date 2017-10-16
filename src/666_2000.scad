use <666_1004.scad>
use <666_1006.scad>
use <666_1014.scad>
use <666_1017.scad>
use <666_1026.scad>
use <666_1028.scad>
include <../Parameters.scad>


translate([222,0,52.5])
rotate ([0,180,90])
666_1017();


translate([460-main_tube_outer_diameter*2,0,0])
rotate ([0,90,0])
666_1026();

translate([0,0,150])
666_1026();

translate([392-(main_tube_outer_diameter+2*(main_tube_outer_diameter/5))/2,2,1])
rotate ([90,0,90])
666_1004();


translate([-167,2,1])
rotate ([90,0,90])
666_1004();



translate([149,150,-27])
rotate([90,0,0])
666_1006();

translate([-149,150,-27])
rotate([90,0,0])
666_1006();

translate([-149,-150,-27])
rotate([-90,0,0])
666_1006();

translate([149,-150,-27])
rotate([-90,0,0])
666_1006();

translate ([-220,0,0])
rotate ([-90,0,90])
666_1028();

translate([-220,0,0])
rotate ([90,0,-90])
666_1028 ();

translate([90,-184.5,-92])
rotate ([-90,0,90])
666_1014();

translate([-90,-184.5,-92])
rotate ([-90,0,90])
666_1014();

translate([90,184.5,-92])
rotate ([-90,0,90])
666_1014();

translate([-90,184.5,-92])
rotate ([-90,0,90])
666_1014();


//hlavní trubky
difference (){

translate([-460,0,0])
rotate ([0,90,0])
cylinder (h = 920, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate([-303,0,0])
rotate([0,90,0])
cylinder (h = 606, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}


difference(){
cylinder (h = 200, r1 = Help_main_tube_outer/2, r2 = Help_main_tube_outer/2, $fn = 200);

translate ([0,0,-3])
cylinder (h = 306, r1 = Help_main_tube_inner/2, r2 = Help_main_tube_inner/2, $fn = 200);
}

difference(){
translate([392-(main_tube_outer_diameter+2*(main_tube_outer_diameter/5))/2,150,-27])
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

//trubky pro podvozek

translate ([150,-150,-27])
rotate ([90,0,0])
cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([150,-185,-27])
rotate ([180,0,0])
cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([152,-183,-92])
rotate ([180,90,0])
cylinder (h = 300, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([-150,-150,-27])
rotate ([90,0,0])
cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([-150,-185,-27])
rotate ([180,0,0])
cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);



translate ([150,190,-27])
rotate ([90,0,0])
cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([150,185,-27])
rotate ([180,0,0])
cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);


translate ([-150,190,-27])
rotate ([90,0,0])
cylinder (h = 40, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([-150,185,-27])
rotate ([180,0,0])
cylinder (h = 70, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

translate ([152,183,-92])
rotate ([180,90,0])
cylinder (h = 300, r1 = Help_tube_for_undercarriage_outer/2, r2 = Help_tube_for_undercarriage_outer/2, $fn = 200);

