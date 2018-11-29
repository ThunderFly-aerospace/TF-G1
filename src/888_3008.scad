use <./lib/naca4.scad>
include <../Parameters.scad>
draft = false;
 
magnet_d = 85;

cylinder_height = 45;

wall_thickness = 5;

module 888_3008(draft){    /////// 1. díl (AZ, YAW)

    difference(){

        union (){
            cylinder(d1 = magnet_d, d2 = magnet_d + 2 * wall_thickness, h = wall_thickness, $fn=draft?50:100);
            translate([0,0, wall_thickness])
                cylinder(d = magnet_d + 2 * wall_thickness, h = cylinder_height, $fn=draft?50:100);
        }

        translate([0,0, wall_thickness])
            cylinder(d = magnet_d, h = cylinder_height, $fn=draft?50:100);
    }
}

difference(){
888_3008(draft);
//translate([0,0,-1]) rotate([0,0,45]) cube(200);
}