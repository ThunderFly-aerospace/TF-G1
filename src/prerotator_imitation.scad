			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module prerotator_imitation(draft){

prerotator_imitation_height = 48;
prerotator_imitation_diameter = 35;

cylinder(h = prerotator_imitation_height, r = prerotator_imitation_diameter/2, $fn = 100);

}




prerotator_imitation(draft);

include <../parameters.scad>
