include <../parameters.scad>


module 888_2019(){
    piston_out_d = 21.5;

    piston_screw_d = 16 + 0.3;
    piston_screw_t = 12 + 0.5;

    bearing_distance = 15;
    shoulder_screw_length = 20;
    bearing_screw_length = 17;

    difference(){
        union() hull(){
            cylinder(d1 = piston_out_d, d2 = piston_out_d + 3, h = 15, $fn = 80);

            ///translate([0, 0, bearing_distance])
            //    rotate([0, 90, 0])
            //        translate([0, 0, -1])
            //            cylinder(d = 17, h = shoulder_screw_length + 8, center = true, $fn = 60);

            translate([-30+10, 0, 15-17/2])
                rotate([0, 90, 90])
                    translate([0, 0, 0])
                        cylinder(d = 17, h = shoulder_screw_length + 8, center = true, $fn = 60);

            translate([-35, 0, 15-17/2-bearing_distance])
                rotate([0, 90, 90])
                    translate([0, 0, 0])
                        cylinder(d = 15, h = shoulder_screw_length + 8, center = true, $fn = 60);
        }

        translate([0, 0, 10-3])
            rotate([0, 90, 0]){
                cylinder(d = M6_screw_diameter, h = bearing_screw_length + 15, center = true, $fn = 80);
                translate([0, 0, bearing_screw_length/2]) cylinder(d = M6_nut_diameter, h = 30);
                translate([0, 0, -bearing_screw_length/2-30]) cylinder(d = M6_nut_diameter, h = 30, $fn = 6);
            }

        translate([0, 0,-global_clearance])
        intersection(){
            cylinder(d = piston_screw_d, h = 13.5, $fn = 80);
            cube([piston_screw_t, 50, 50], center = true);
        }

        translate([0, 0, -20])
            cylinder(d = piston_out_d + 1, h = 20, $fn = 80);

        translate([-35, 0, 15-17/2- bearing_distance])
            rotate([90, 0, 0]){

                cylinder(d = M4_screw_diameter, h = 100, center = true, $fn = 60);
                translate([0, 0, shoulder_screw_length/2]) cylinder(d = M4_nut_diameter, h = 30, $fn = 60);
                translate([0, 0, -shoulder_screw_length/2-30]) cylinder(d = M4_nut_diameter, h = 30, $fn = 6);
                difference(){
                    cube([50, 50, 12.5], center = true);
                    translate([30, 0, 0]) rotate([-90,0,0]) cylinder(d = 35, h = 50, center = true);
                }

            }

    }
}

888_2019();
