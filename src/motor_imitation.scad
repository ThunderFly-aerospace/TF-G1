			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module motor_imitation(draft){

cylinder(h= 49, r = 49.5/2, $fn = 100);

}




motor_imitation(draft);

include <../Parameters.scad>
