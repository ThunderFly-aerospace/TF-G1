
include <../parameters.scad>

pipe_holder_distance = 20;


module 888_2023(){
    difference(){
        translate([-(8), -10, -20])
            cube([25, 20, 50]);

        cylinder(d = tube_for_undercarriage_outer_diameter, h = 80, center = true, $fn = 60);

        for (i=[-1,1]) {
            translate([0, 0, i*pipe_holder_distance/2])
                rotate([0, 90, 0]){
                    cylinder(d = M4_screw_diameter, h = 100, center = true, $fn = 60);
                    translate([0, 0, 17-M4_screw_head_height]) cylinder(d = M4_nut_diameter, h = 100, $fn = 60);
            }
        }
    }
}

888_2023();
