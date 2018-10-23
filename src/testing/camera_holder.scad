include <../../Parameters.scad>
draft = true;

$fs = draft?50:100;
//$fa  = 10;
 


camera_angle = 30; 
camera_diameter = 120; 
camera_holder_height = 50 ;

module 888_3008(draft){    /////// 1. díl (AZ, YAW)

    difference(){
        cylinder(d = camera_diameter, h= camera_holder_height, $fn=draft?50:100, center = true);

        /*rotate([0, camera_angle, 0])
            translate([0,0, camera_diameter/2   + 20])
                cube([2*camera_diameter, 2*camera_diameter, camera_diameter], center = true);
*/
        translate([0,0,-global_clearance/2])
            cylinder(d=M8_screw_diameter, h=g3_8_magnet_wall_thickness+global_clearance, $fn=draft?50:100);
        
        
            // dira skrz pro lozisko
            translate([0,0, g3_8_magnet_wall_thickness])
                cylinder(d = bearing_efsm_08_db, h = g3_8_cylinder_h+global_clearance, $fn =  draft ? 50 :100);
            
            // diry pro pripevneni kamery
            // prumer kruznice na ktere jsou umisteny srouby
            camera_screws_position = 94 - 2*5.5 - 5.5;

            %for (i=[0:2]) 
                rotate([0, 0, 120*i]){
                    translate([0, camera_screws_position/2, -global_clearance/2])
                        cylinder(h = camera_holder_height, d=M4_screw_diameter, $fn=draft? 50:100);

                    
                    translate([0, camera_screws_position/2, -M4_nut_height - 0.5 + g3_8_pocket_wall])
                        rotate([0, 0, 30])
                            cylinder(h = M4_nut_height + global_clearance, d = M4_nut_diameter, $fn = 6);
                
                    translate([-M4_nut_pocket/2, camera_screws_position/2, -M4_nut_height - 0.5 + g3_8_pocket_wall])
                        cube([M4_nut_pocket, 100, M4_nut_height + global_clearance]);
                }
    }
}

difference(){
888_3008(draft);
//translate([0,0,-1]) rotate([0,0,45]) cube(200);
}