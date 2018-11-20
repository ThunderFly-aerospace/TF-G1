			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


include <../../Parameters.scad>


gliding_aggle = 14; 		// tenhle úhel by se zřejmě v budoucnu měl počítat z požadované klouzavosti. 
rotor_height = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes + 30;
center_of_gravity_position = [main_pilon_position - tan(gliding_aggle)*rotor_height, 0, 0];

translate(center_of_gravity_position)
	color("green")
		sphere(10);  

projection(cut = false)  888_1005(draft);

use <./888_1005.scad>

