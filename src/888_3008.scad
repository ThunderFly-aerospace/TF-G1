use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;

$fs = draft?50:100;
//$fa  = 10;
 

magnet_d = g3_8_magnet_diameter;


module 888_3008(draft){    /////// 1. díl (AZ, YAW)

difference(){
    union (){
        cylinder(d = magnet_d, h= g3_8_magnet_wall_thickness, $fn=draft?50:100);
        cylinder(d = g3_8_cylinder_d, h=g3_8_cylinder_h, $fn=draft?50:100);
    }
    translate([0,0,-global_clearance/2])
        cylinder(d=M8_screw_diameter, h=g3_8_magnet_wall_thickness+global_clearance, $fn=draft?50:100);
    
    union(){ // union pro kulove lozisko
         // zapusteni kuloveho loziska
        translate([-(bearing_efsm_08_h+bearing_efsm_space)/2, -(bearing_efsm_08_h+bearing_efsm_space)/2, g3_8_cylinder_h-bearing_efsm_08_a1])
            cube([bearing_efsm_08_h+bearing_efsm_space, bearing_efsm_08_h+bearing_efsm_space, g3_7_height]);
        
        // dira skrz pro lozisko
        translate([0,0, g3_8_magnet_wall_thickness])
            cylinder(d = bearing_efsm_08_db, h = g3_8_cylinder_h+global_clearance, $fn =  draft ? 50 :100);
        
        // diry pro pridelani loziska
        for (i=[0:3]) rotate([0, 0, 90*i]){
            translate([bearing_efsm_08_m/2, bearing_efsm_08_m/2, -global_clearance/2])
                cylinder(h=g3_8_cylinder_h+global_clearance, d=M5_screw_diameter, $fn=draft? 50:100);
            
            rotate([0,0,45])
                translate([-M5_nut_pocket/2, bearing_efsm_08_m/2, -M5_nut_height-0.5+g3_8_pocket_wall])
                    cube([M5_nut_pocket, 100, M5_nut_height+0.5]);
        }
    }
}
}

difference(){
888_3008(draft);
//translate([0,0,-1]) rotate([0,0,45]) cube(200);
}