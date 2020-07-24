// Drzak VESC regulator na univerzalni drazky
include <../parameters.scad>

$fn = 80;
draft = $preview;

vesc6_mount_height = 9;
vesc6_mount_thickness = 10;
vesc6_mount_flange_thickness = 6;
vesc6_mount_holes_distance = 39;
vesc6_width = 70;

module 888_1035(offset = 0){

    difference(){
        union(){
            translate([-vesc6_mount_thickness/2, -vesc6_width/2+10, 0])
                cube([vesc6_mount_thickness+offset, vesc6_width-20, vesc6_mount_flange_thickness]);

            translate([-vesc6_mount_thickness/2, -vesc6_mount_thickness/2 - beam_socket_width/2, 0])
                cube([vesc6_mount_thickness+offset, vesc6_mount_thickness, vesc6_mount_height]);

            translate([-vesc6_mount_thickness/2, -vesc6_mount_thickness/2 + beam_socket_width/2, 0])
                cube([vesc6_mount_thickness + offset, vesc6_mount_thickness, vesc6_mount_height]);
        }

        for(i = [-1, 1]){
            translate([0, i*beam_socket_width/2, vesc6_mount_height-5-layer])
                cylinder(d = M3_screw_diameter, h = vesc6_mount_height);
            translate([0, i*beam_socket_width/2, 0])
                cylinder(h = vesc6_mount_height-5, d = M3_nut_diameter);
        }

        for(i = [-1, 1]){
            translate([offset, i*vesc6_mount_holes_distance/2, 0])
                cylinder(d = M3_screw_diameter, h = vesc6_mount_height);
            translate([offset, i*vesc6_mount_holes_distance/2, 2])
                rotate(30)
                    cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 6);
            translate([offset, i*vesc6_mount_holes_distance/2 - M3_nut_diameter/2, 2])
                cube([20, M3_nut_diameter, M3_nut_height]);

        }
    }
}

888_1035();
