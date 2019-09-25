use <./888_1029.scad>
use <./888_1022_without_desk.scad>
use <./888_1020.scad>

include <../parameters.scad>


desk_thickness=4;
plate_thickness=2;
plate_diameter=40;
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

roll=10;
pitch=15;


//difference()
{
    union()
    {
        draft=true;
        translate([-12,0,0])
            rotate([0,0,180])
                888_1029();

    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])
        rotate([roll,0,0])        
            translate([0,0,4])
                rotate([180,0,0])
                    888_1022();
    
    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])    
        rotate([roll,0,0])
            rotate([0,pitch,0])
                translate([0,0,12])
                    union()
                    {
                        rotate([180,0,0])
                            888_1020();
                        translate([0,0,-(neck_height+desk_thickness)])
                        neck_model();
                    }
    }
}




//neck_model();
 