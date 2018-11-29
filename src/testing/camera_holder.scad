include <../../Parameters.scad>
draft = false;

$fs = draft?50:100;
//$fa  = 10;
 


camera_angle = 45; 
camera_diameter = 116; 
camera_holder_height = 50;
camera_holder_screw_lenght = 5;

module camera_holder(draft){    /////// 1. díl (AZ, YAW)

    intersection(){
        difference(){
            translate([0,0,-3* camera_holder_height ])
                cylinder(d = camera_diameter, h = camera_holder_height + 3*camera_holder_height , $fn=draft?50:100);
            
                        
            // diry pro pripevneni kamery
            // prumer kruznice na ktere jsou umisteny srouby
            camera_screws_position1 = 94 - 2*5.5 - 5.5;

            for (i=[0:2]) 
                rotate([0, 0, 120*i]){
                    translate([0, camera_screws_position1/2, camera_holder_height - 2*camera_holder_screw_lenght])
                        cylinder(h = camera_holder_height, d = M4_screw_diameter, $fn = 50);

                    
                    translate([0, camera_screws_position1/2,  camera_holder_height - camera_holder_screw_lenght - M4_nut_height])
                        rotate([0, 0, 30])
                            cylinder(h = M4_nut_height + global_clearance, d = M4_nut_diameter, $fn = 6);
                
                    translate([-M4_nut_pocket/2, camera_screws_position1/2, camera_holder_height - camera_holder_screw_lenght - M4_nut_height])
                        cube([M4_nut_pocket, 100, M4_nut_height + global_clearance]);
                }

            // diry pro pripevneni kamery
            // prumer kruznice na ktere jsou umisteny srouby
            camera_screws_position2 = 116 - 2*9 - 4.5;

            rotate([0, 0, -15])
                for (i=[0:3]) 
                    rotate([0, 0, 90*i]){
                        translate([0, camera_screws_position2/2, camera_holder_height - 2*camera_holder_screw_lenght])
                            cylinder(h = camera_holder_height, d = M4_screw_diameter, $fn = 50);
                        
                        translate([0, camera_screws_position2/2, camera_holder_height - 2*camera_holder_screw_lenght - M4_nut_height])
                            rotate([0, 0, 30])
                                cylinder(h = M4_nut_height + global_clearance, d = M4_nut_diameter, $fn = 6);
                    
                        translate([-M4_nut_pocket/2, camera_screws_position2/2, camera_holder_height - 2*camera_holder_screw_lenght - M4_nut_height])
                            cube([M4_nut_pocket, 100, M4_nut_height + global_clearance]);
                    }

            // seříznutí podstavy pro náklon kamery 
            rotate([0, camera_angle, -45])
            {
                translate([0,0, -camera_holder_height   - 20])
                    cube([2*camera_diameter, 2*camera_diameter, 2*camera_holder_height], center = true);

                // dira skrz pro upevnovaci sroub
                translate([0,0, -13])
                    cylinder(d = M6_nut_diameter, h = 100, $fn =  6);

                translate([0,0,-10])
                    cylinder(d=M6_screw_diameter, h=100, $fn=draft?50:100, center = true);

            }
        }

            // seříznutí podstavy pro náklon kamery 
            rotate([0, camera_angle, -45])
            {
                translate([0,0, -10])
                    cylinder(d = 155, h = 200, $fn =  150, center = true);

            }

    }
}

camera_holder(draft);
