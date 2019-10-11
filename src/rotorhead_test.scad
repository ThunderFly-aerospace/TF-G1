use <./888_1029.scad>
use <./888_1022.scad>
use <./888_1020.scad>
use <lib/igus.scad>

include <../parameters.scad>

stl = true;
plastick = false;

desk_thickness=rotorhead_desk_thickness;
plate_thickness=rotorhead_neck_plate_thickness;
plate_diameter=rotorhead_neck_plate_diameter;
neck_height=rotorhead_neck_height;
bearing_neck_length=10;
neck_diameter=14;

ax_diameter=8;
bearing_diameter=12;

draft = $preview;


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
pitch=rotor_head_pitch_stop;

roll=0;
pitch=0;

difference()
{
    union()
    {
        draft=true;
        union(){
            translate([-rotor_head_bearing_x_shift,0,0])
                rotate([0,0,180])
                    if(stl){
                        import("../STL/888_1029.stl", convexity=3);
                        //888_1022();
                    }else{
                        888_1029();
                    }
            translate([-1,0,rotor_head_height-rotor_head_bearing_a_center_of_rotation])
                rotate([0,rotor_head_rank_angle,0])
                union(){
                    efsm_12();
                    for (i=[-1,1])
                        for(j=[-1,1])
                            translate([i*14,j*14,rotor_head_bearing_a1+3/2])
                                cylinder(d=9,h=3,center=true);
                }
    //}

    // streni dil kardanu - ramecek
    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])
        rotate([roll,0,0])
            translate([0,0,4])
                rotate([180,0,0])
                    if(false){
                        import("../STL/888_1022.stl", convexity=3);
                        //888_1022();
                    }else{
                        888_1022();
                    }
    }
    translate([0,0,rotor_head_height])
    rotate([0,rotor_head_rank_angle,0])
        rotate([roll,0,0])
            rotate([0,pitch,0])
                translate([0,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+4])
                    color([0.8, 0.8, 0.8, 0.5])
                    if(stl){
                        if(plastick){
                            rotate([180,0,0])
                                import("../STL/888_1020_plastick_neck.stl", convexity=3);
                                translate([0,0,0])
                                    import("../STL/666_1264.stl", convexity=3);
                        }else{
                            rotate([180,0,0])
                                import("../STL/888_1020.stl", convexity=3);

                            translate([0,0,-(desk_thickness)])
                                import("../STL/666_1265.stl", convexity=3);
                            translate([0,0,0])
                                import("../STL/666_1264.stl", convexity=3);
                        }

                    }
                    else{
                        {
                            %rotate([180,0,0])
                                888_1020();
                            #translate([0,0,-(neck_height+desk_thickness)])
                                #neck_model();
                        }
                    }
      }

    //translate([-40,0,0])
    //    cube([100,100,100],center=true);
}




//neck_model();
