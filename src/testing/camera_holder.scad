include <../../Parameters.scad>
draft = false;

$fs = draft?50:100;
//$fa  = 10;
 


camera_angle = 30; 
camera_diameter = 116; 
camera_holder_height = 50 ;

module 888_3008(draft){    /////// 1. díl (AZ, YAW)

    difference(){
        translate([0,0,-camera_holder_height/2])
            cylinder(d = camera_diameter, h = 2 * camera_holder_height, $fn=draft?50:100, center = true);
        
                    
        // diry pro pripevneni kamery
        // prumer kruznice na ktere jsou umisteny srouby
        camera_screws_position1 = 94 - 2*5.5 - 5.5;

        for (i=[0:2]) 
            rotate([0, 0, 120*i]){
                translate([0, camera_screws_position1/2, -global_clearance/2])
                    cylinder(h = camera_holder_height, d=M4_screw_diameter, $fn=draft? 50:100);

                
                translate([0, camera_screws_position1/2, -M4_nut_height - 0.5 + g3_8_pocket_wall])
                    rotate([0, 0, 30])
                        cylinder(h = M4_nut_height + global_clearance, d = M4_nut_diameter, $fn = 6);
            
                translate([-M4_nut_pocket/2, camera_screws_position1/2, -M4_nut_height - 0.5 + g3_8_pocket_wall])
                    cube([M4_nut_pocket, 100, M4_nut_height + global_clearance]);
            }

        // diry pro pripevneni kamery
        // prumer kruznice na ktere jsou umisteny srouby
        camera_screws_position2 = 116 - 2*9 - 4.5;

        for (i=[0:3]) 
            rotate([0, 0, 90*i]){
                translate([0, camera_screws_position2/2, -global_clearance/2])
                    cylinder(h = camera_holder_height, d=M4_screw_diameter, $fn=draft? 50:100);

                
                translate([0, camera_screws_position2/2, -M4_nut_height + camera_holder_height/2 -  5])
                    rotate([0, 0, 30])
                        cylinder(h = M4_nut_height + global_clearance, d = M4_nut_diameter, $fn = 6);
            
                translate([-M4_nut_pocket/2, camera_screws_position2/2, -M4_nut_height + camera_holder_height/2 -5 ])
                    cube([M4_nut_pocket, 100, M4_nut_height + global_clearance]);
            }


        rotate([0, camera_angle, -45])
        {
            translate([0,0, -camera_holder_height   - 20])
                cube([2*camera_diameter, 2*camera_diameter, 2*camera_holder_height], center = true);

            // dira skrz pro upevnovaci sroub
            translate([0,0, -10])
                cylinder(d = M6_nut_diameter, h = 100, $fn =  6);

            translate([0,0,-10])
                cylinder(d=M6_screw_diameter, h=100, $fn=draft?50:100, center = true);

        }


    }
}

difference(){
888_3008(draft);
//translate([0,0,-1]) rotate([0,0,45]) cube(200);
}