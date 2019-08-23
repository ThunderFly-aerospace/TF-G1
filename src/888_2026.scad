//========== SPOJENÍ PODVOZKU A MOTOROVÉHO DÍLU ==========//

include <../parameters.scad>

joint_diameter = 40;
screw_length = 10.8;
height = 25;
washer_diameter = 20;
screw_distance = 42.5;
stops_overhang = 3;
layer_height = 0.2;

module 888_2026() {
    difference() {
        union() {
            translate([0, 0, -5])
            cylinder(d=joint_diameter, h=height+5, $fn=100);

            hull() {
                translate([0, 0, height/2])
                    cylinder(d=joint_diameter, h=height/2, $fn=100);

                translate([0, 0, height-5])
                    cylinder(d=screw_distance+10, h=5, $fn=100);
            }

            //zarážka
            hull() {
                translate([stop_width/2, 0, -stops_overhang])
                    rotate([0, 0, max_angle_of_ratation/-2])
                        translate([0, joint_diameter/2-10, 0])
                            cube([8, stop_size+10, 10]);

                translate([stop_width/2, 0, -stops_overhang+10])
                    rotate([0, 0, max_angle_of_ratation/-2])
                        translate([0, joint_diameter/2-10, 0])
                            cube([8, stop_size, 10]);
            }
            //zarážka
            hull() {
                translate([stop_width/-2, 0, -stops_overhang])
                    rotate([0, 0, max_angle_of_ratation/2])
                        translate([-8, joint_diameter/2-10, 0])
                            cube([8, stop_size+10, 10]);

                translate([stop_width/-2, 0, -stops_overhang+10])
                    rotate([0, 0, max_angle_of_ratation/2])
                        translate([-8, joint_diameter/2-10, 0])
                            cube([8, stop_size, 10]);
            }
        }
        rotate([5, 0, 0])
        translate([0, 0, -10])
            cylinder(d=joint_diameter+1, h=10, $fn=50);

        //šroub uchycení podvozku
        rotate([5, 0, 0]) {
            translate([0, 0, -0.1])
                cylinder(d=M8_screw_diameter, h=screw_length-layer_height, $fn=20);
            translate([0, 0, screw_length])
                cylinder(d=washer_diameter, h=100, $fn=40);
        }

        //šrouby pro připevnění k motorovému dílu
        translate([screw_distance/2, 0, 0])
            cylinder(d=M4_screw_diameter, h=100, $fn=20);

        translate([screw_distance/-2, 0, 0])
            cylinder(d=M4_screw_diameter, h=100, $fn=20);

        translate([screw_distance/2, 0, -10])
            cylinder(d=M4_screw_diameter+5, h=height+5, $fn=20);

        translate([screw_distance/-2, 0, -10])
            cylinder(d=M4_screw_diameter+5, h=height+5, $fn=20);
    }
}

888_2026();