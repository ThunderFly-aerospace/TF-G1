			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module motor_imitation(draft){

cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator - sink_of_accumulator]);

}




motor_imitation(draft);

include <../Parameters.scad>
