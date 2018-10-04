

cylinder (h = 400, r = main_tube_outer_diameter/2);

		666_1026_drillhelper();

translate([- height_666_1017 + main_tube_outer_diameter/2 + 2*thickness_between_tubes,0,main_pilon_position])
	rotate([-90,0,-90])
		666_1017_drillhelper();
translate([0,0,350])
	rotate([0,0,90])
		666_1028_drillhelper();


use <666_1026.scad>
use <666_1017.scad>
use <666_1028.scad>

include <../Parameters.scad>