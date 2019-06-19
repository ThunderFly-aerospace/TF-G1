			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module prerotator_imitation(draft){

cylinder(h = 48, r = 35/2, $fn = 100);

}




prerotator_imitation(draft);

include <../Parameters.scad>
