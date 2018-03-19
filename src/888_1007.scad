draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1007(){

translate([0,main_tube_outer_diameter*2,0])
    rotate([0,-90,90])
        666_1026_drillhelper();
   
translate([0,-2 + length_of_main_tube*0.75,0])
    rotate([270,90,0])
        666_1028_drillhelper();

    rotate([-90,0,0])
        cylinder (h = length_of_main_tube*0.75, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

translate([0,main_pilon_position,70 - coupling_wall_thickness + main_tube_outer_diameter/2 - main_tube_outer_diameter])
    rotate([180,0,0])
        666_1017_drillhelper();

translate([0, main_pilon_position,main_tube_outer_diameter/2 + thickness_between_tubes])
        cylinder (h = height_of_vertical_tube*0.75, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

translate([0,main_pilon_position,+ main_tube_outer_diameter/2 + thickness_between_tubes + height_of_vertical_tube*0.75 - 2*main_tube_outer_diameter])
    rotate([0,0,90])
        666_1026_drillhelper();

//final module
}


888_1007();




use <./lib/naca4.scad>
include <../Parameters.scad>

use<666_1026.scad>
use<666_1028.scad>
use<666_1017.scad>