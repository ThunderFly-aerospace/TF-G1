use <./888_1015.scad>
use <./888_1022.scad>
use <./888_1020.scad>

include <../parameters.scad>

roll=-10;
pitch=-15;


//difference()
{
    //union()
    {
    888_1015(true);

    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])
        rotate([roll,0,0])        
            translate([0,0,3+6])
                rotate([180,0,0])
                    888_1022();
    }
    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])    
        rotate([roll,0,0])
            rotate([0,pitch,0])
                translate([0,0,20.5])
                    rotate([180,0,0])
                        888_1020();
}
 