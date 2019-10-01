use <./888_1029.scad>
use <./888_1022_without_desk.scad>
use <./888_1020.scad>
use <lib/igus.scad>

include <../parameters.scad>


desk_thickness=4;
plate_thickness=2;
plate_diameter=38;
neck_height=rotorhead_neck_height;
bearing_neck_length=10;
neck_diameter=14;

ax_diameter=8;
bearing_diameter=12;


module neck_model(){
    difference()
    {
        union()
        {
            
            cylinder(h=desk_thickness+neck_height,d=neck_diameter);
            translate([0,0,(neck_height-bearing_neck_length)/2])
                cylinder(h=bearing_neck_length+neck_height,d=bearing_diameter,center=true);
            translate([0,0,neck_height-plate_thickness])
                cylinder(h=plate_thickness,d=plate_diameter);
            
        }
        cylinder(h=4*(desk_thickness+neck_height),d=ax_diameter,center=true);
    }
}

roll=rotor_head_roll_stop;
pitch=rotor_head_pitch_stop
;


difference()
{
    union()
    {
        draft=true;
        union(){
            translate([-rotor_head_bearing_x_shift,0,0])
                rotate([0,0,180])
                    888_1029();
            translate([-1,0,rotor_head_height-rotor_head_bearing_a_center_of_rotation])
                rotate([0,rotor_head_rank_angle,0])
                union(){
                    efsm_12();
                    for (i=[-1,1])
                        for(j=[-1,1])
                            translate([i*14,j*14,rotor_head_bearing_a1+1.5])            
                                cylinder(d=9,h=3,center=true);
                }
    }


    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])
        rotate([roll,0,0])        
            translate([0,0,4])
                rotate([180,0,0])
                    888_1022();
    }
    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])    
        rotate([roll,0,0])
            rotate([0,pitch,0])
                translate([0,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+4])
                    union()
                    {
                        rotate([180,0,0])
                            888_1020();
                        translate([0,0,-(neck_height+desk_thickness)])
                        neck_model();
                    }
      //}
    
    //translate([-40,0,0])
      //  cube([100,100,100],center=true);
}




//neck_model();
 