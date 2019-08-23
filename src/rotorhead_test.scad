use <./888_1015.scad>
use <./888_1022.scad>
use <./888_1020.scad>

include <../parameters.scad>


888_1015(true);
translate([0,0,rotor_head_height])
    rotate([10,rotor_head_rank_angle,0])
        translate([0,0,3+6])
            rotate([180,0,0])
                888_1022();
        
        
translate([0,0,rotor_head_height])
    rotate([10,rotor_head_rank_angle+15,0])
        translate([0,0,17.5])
            rotate([180,0,0])
                888_1020();