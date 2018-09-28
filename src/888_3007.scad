use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;

$fs =  draft ? 50 :100;
//$fa  = 10;


module 888_3007(draft){    /////// 1. díl (AZ, YAW)

    difference(){
        union (){
            translate([-g3_7_length/2, -g3_7_width/2, -g3_7_height/2]) cube([g3_7_length, g3_7_width, g3_7_height]);
        }
        
        // zapusteni kuloveho loziska
        translate([-(bearing_efsm_17_width+bearing_efsm_space)/2, -(bearing_efsm_17_width+bearing_efsm_space)/2, 0]) cube([bearing_efsm_17_width+bearing_efsm_space, bearing_efsm_17_width+bearing_efsm_space, g3_7_height]);
        
        // dira skrz pro lozisko
        translate([0,0, -(g3_7_height+global_clearance)/2])
            cylinder(d = bearing_efsm_17_db, h = g3_7_height+global_clearance, $fn =  draft ? 50 :100);
        
        // diry pro pridelani loziska
        for (i=[0:3]) rotate([0, 0, 90*i]){
        translate([bearing_efsm_17_boltd, bearing_efsm_17_boltd, -(g3_7_height+global_clearance)/2])
            cylinder(h=g3_7_height+global_clearance, d=bearing_efsm_17_n, $fn=draft? 50:100);
        translate([bearing_efsm_17_boltd, bearing_efsm_17_boltd, -(g3_7_height+global_clearance)/2])
            cylinder(h=M6_head_height, d=M6_head_diameter, $fn=draft? 50:100);
        }
            
        for (i=[0:1]) rotate([0,0,180*i]){
            translate([bearing_efsm_17_width/2 + 2, 0, 0]) rotate([0, 90, 0]) 
                cylinder(d=M8_screw_diameter, h=100, $fn=draft? 50:100);
            translate([bearing_efsm_17_width/2+ 2 + 5, -M8_nut_pocket/2, -M8_nut_diameter/2]) 
                cube([M8_nut_height, M8_nut_pocket, 30]);
        }
    }
}


888_3007(draft);
