include <../parameters.scad>
use <lib/igus.scad>


module 888_2016(){
    wall = 10;
    length = 45;
    space = 1.5;
    kstm = 8;
    bolt_length = 35;
    bolt_support_length = 20;

    difference(){
        cube([length, main_tube_outer_diameter+2*wall, main_tube_outer_diameter+2*wall], center = true);

        rotate([0, -90, 0])
            cylinder(d = main_tube_outer_diameter, h = length + global_clearance, $fn = 80, center = true);

        // zarez na stazeni trubky
        translate([-length/2 - global_clearance/2, -space/2, 0])
            cube([length + global_clearance, space, main_tube_outer_diameter+wall]);

        for (i=[1:2:8]) {
            rotate([i*45, 0, 0])
                translate([-length/2 - global_clearance/2, main_tube_outer_diameter/2+wall, -25])
                    cube([length+global_clearance, 50, 50]);
        }

        // diry pro pridelani loziska
        for (i=[1,-1]) {
            translate([kstm_flange_holes_distance(kstm)*i/2, 0, 0])
                cylinder(d = M4_screw_diameter, h = main_tube_outer_diameter+2*wall + global_clearance, $fn = 50, center = true);

            translate([kstm_flange_holes_distance(kstm)*i/2, 0, -main_tube_outer_diameter/2 - global_clearance - M4_screw_head_height])
                cylinder(d = M4_nut_diameter, h = M4_screw_head_height*2, $fn = 50);
        }

        for (i=[1,-1]) {
            translate([length/3*i, 0, 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = main_tube_outer_diameter+2*wall + global_clearance, $fn = 50, center = true);

            translate([length*i/3, -bolt_length/2 , 0])
                rotate([90, 30, 0])
                        cylinder(d = M3_nut_diameter, h = 20, $fn = 6);

            translate([length*i/3, bolt_length/2 + 20 , 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
        }


        translate([0, 0, main_tube_outer_diameter/2 + 4])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, $fn = 60, center = true);

        translate([0, -bolt_support_length/2, main_tube_outer_diameter/2 + 4])
            rotate([90, 0, 0])
                cylinder(d = M3_nut_diameter, h = 50, $fn = 60);

        translate([0, bolt_support_length/2 + 50, main_tube_outer_diameter/2 + 4])
            rotate([90, 30, 0])
                cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
    }
}

module 888_2016_drill(){
    wall = 10;
    length = 45;
    space = 1.5;
    kstm = 8;
    bolt_length = 35;
    bolt_support_length = 20;

    difference(){
        translate([-length/2, -main_tube_outer_diameter/2 - wall, -main_tube_outer_diameter/2 - wall])
            cube([length, main_tube_outer_diameter + 2*wall, main_tube_outer_diameter + 2*wall]);

        rotate([0, 90, 0])
            cylinder(d = main_tube_outer_diameter, h = length + global_clearance, center = true, $fn = 90);

        for (i=[1,-1]) {
            translate([length/3*i, 0, 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = main_tube_outer_diameter+2*wall + global_clearance, $fn = 50, center = true);
        }

        translate([0, 0, main_tube_outer_diameter/2 + wall - 0.2])
            linear_extrude(0.3)
                text("drill 888_2016", size = 4, valign = "center", halign = "center");
    }
}


888_2016();
