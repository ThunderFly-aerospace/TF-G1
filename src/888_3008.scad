use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;

$fs = draft?50:100;
//$fa  = 10;
 

magnet_d = 80;

cylinder_height = magnet_d/2;

module 888_3008(draft){    /////// 1. díl (AZ, YAW)

    difference(){

        union (){
            cylinder(d = magnet_d, h = g3_8_magnet_wall_thickness, $fn=draft?50:100);
            translate([0,0,g3_8_magnet_wall_thickness])
                cylinder(d1 = magnet_d, d2 = g3_7_width, h=cylinder_height, $fn=draft?50:100);
        }

        // středový šroub pro uchycení k držáku
        translate([0,0,g3_8_magnet_wall_thickness])
            cylinder(d=M8_screw_diameter, h = cylinder_height, $fn=draft?50:100);
    
        translate([-g3_7_width, -(g3_7_height+ global_clearance)/2, cylinder_height + g3_8_magnet_wall_thickness - 10 - M8_nut_height])
            cube([2*g3_7_width, g3_7_height + global_clearance, g3_7_height]);

        // vybrání pro hlavu šroubu a podložku
        cylinder(d = bearing_efsm_08_db, h = cylinder_height + g3_8_magnet_wall_thickness - 10 - M8_nut_height - (30 - 10 - M8_nut_height - 2*global_clearance), $fn =  draft ? 50 :100);
        
        // diry pro pridelani loziska
        for (i=[0:3]) rotate([0, 0, 90*i]){
            translate([0, 70/2, -global_clearance/2])
                cylinder(h=cylinder_height+global_clearance, d = M4_screw_diameter, $fn=draft? 50:100);
            
            translate([0, 70/2, -M5_nut_height-0.5+g3_8_pocket_wall])
               cylinder(h=cylinder_height+global_clearance, d = M4_nut_diameter, $fn = 6);
        }

        rotate([0,0,45])
            translate([0, 57/2,-1])
               cylinder(h = 2*cylinder_height, d = 8, $fn = 20);


    }
}

difference(){
888_3008(draft);
//translate([0,0,-1]) rotate([0,0,45]) cube(200);
}