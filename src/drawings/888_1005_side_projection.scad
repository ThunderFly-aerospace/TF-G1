			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


include <../../parameters.scad>


translate(center_of_gravity_position)
	color("green")
		sphere(10);  

projection(cut = false)  888_1005(draft);

use <./888_1005.scad>

