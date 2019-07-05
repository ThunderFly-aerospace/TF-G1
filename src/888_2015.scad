// Drzak kuloveho loziska KSTM na 10 mm trubku

include <../parameters.scad>
use <lib/igus.scad>


module 888_2015(){
    kstm_base_thickness = 8;
    kstm_base_length = 47;
    wall = 3;

    difference(){
        hull(){
            translate([-kstm_base_length/2, -kstm_base_thickness/2, -10])
                cube([kstm_base_length, kstm_base_thickness, 1]);

            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter + 2*wall, h = kstm_base_length, center = true, $fn = 80);
        }

        rotate([0, 90, 0])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = kstm_base_length + global_clearance, center = true, $fn = 80);

        translate([-50, -50, -global_clearance])
            cube(100);

        translate([kstm_flange_holes_distance(8)/2, 0, -10 + M4_nut_height + 0.2])
            cylinder(d = M4_screw_diameter, h = 100, center = false, $fn = 50);

        translate([-kstm_flange_holes_distance(8)/2, 0, -10 + M4_nut_height + 0.2])
            cylinder(d = M4_screw_diameter, h = 100, center = false, $fn = 50);


        translate([kstm_flange_holes_distance(8)/2, 0, -10])
            cylinder(d = M4_nut_diameter, h = M4_nut_height, center = false, $fn = 6);

        translate([-kstm_flange_holes_distance(8)/2, 0, -10])
            cylinder(d = M4_nut_diameter, h = M4_nut_height, center = false, $fn = 6);


    }
}

888_2015();
