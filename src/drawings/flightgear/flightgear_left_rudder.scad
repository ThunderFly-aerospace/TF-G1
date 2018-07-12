			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module left_rudder(draft){

/*	translate([length_of_main_tube - 80 + global_clearance,0,0])
		rotate([0,90,0])
			translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
	    		rotate([90,-87 ,0])
	        		666_1028_rudder_flightgear(draft);
*/
	translate([length_of_main_tube - 80 + global_clearance,0,0])
		rotate([0,-90,180])
			translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
	    		rotate([90,-87 ,0])
	        		666_1028_rudder_flightgear(draft);
}


left_rudder(draft);


use <../666_1004.scad>
use <../666_1026.scad>
use <../666_1027.scad>
use <../666_1029.scad>
use <../666_1025.scad>
use <../666_1032.scad>
use <../888_1000.scad>
use <../666_1017.scad>
use <../666_1028.scad>
use <../666_1006.scad>
use <../333_1037.scad>
use <../666_1232.scad>
use <../888_1008.scad>
use <../666_1014.scad>

use <../lib/naca4.scad>
include <../../Parameters.scad>

