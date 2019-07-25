// dil pro pripevneni podvozkove trubky k podlozce
include <../parameters.scad>
use <lib/igus.scad>



module tube_part(l = 20, wall = 6, wall_below = 5, screw_length = 15){
    screw_l = screw_length - M3_nut_height*2;
    space = 2;
    translate([0, 0, +main_tube_outer_diameter/2 + wall_below])
    rotate([90, 0, 0])
    difference(){
        hull(){
            cylinder(d = main_tube_outer_diameter + 2*wall, h = l, center = true, $fn = 80);
            translate([-main_tube_outer_diameter/2 - wall, -main_tube_outer_diameter/2 - wall_below, -l/2])
                cube([main_tube_outer_diameter + 2*wall, 0.1,l]);
        }
        cylinder(d = main_tube_outer_diameter, h = l + global_clearance, center = true, $fn = 80);
        translate([0, -250 - main_tube_outer_diameter/2 -wall_below, 0]) cube(500, center = true);

        translate([-space/2, 0, -l/2])
            cube([space, 20, l]);

        rotate([0, 90, 0])
            translate([0, main_tube_outer_diameter/2 + 2, 0]){

                cylinder(d = M3_screw_diameter, h = 100, center = true, $fn = 80);
                translate([0, 0, screw_l/2]) cylinder(d = M3_nut_diameter, h = 100);
                translate([0, 0, -screw_l/2-100]) cylinder(d = M3_nut_diameter, h = 100, $fn = 6);
        }
    }
}

module 888_2018(){


    thickness_above = 2018_thickness_above_pipe; // tloustka materialu mezi tyci a podlozkou

    width = chassis_suspension_basewidth + kstm_flange_length(10) + 5;
    length = main_tube_outer_diameter + 10;
    height = main_tube_outer_diameter + 2018_thickness_above_pipe + 5;

    //translate([0, -chassis_top_bearing_position_y, 0])

    difference(){
        union(){
            translate([-main_tube_outer_diameter/2-6, -10, 0])
                cube([main_tube_outer_diameter+12, 20, 2018_thickness_above_pipe + M3_nut_height]);

            tube_part(l = 20, wall = 6, wall_below = thickness_above);

        }
        translate([0, 0, thickness_above + main_tube_outer_diameter/2])
            rotate([90, 0, 0])
                cylinder(d = main_tube_outer_diameter, h = 300, center = true);

        for (j=[1, -1])
            translate([j*main_tube_outer_diameter/2, 0, 0]){
                    cylinder(d = M3_screw_diameter, h = 3+5.5);
                    //translate([0, 0, 2+M3_nut_height+0.2])
                    //    cylinder(d = M3_screw_diameter, h = 3.5);
                    translate([0, 0, 2])
                        rotate(30)
                            cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                    rotate(-90*j)
                        translate([-M3_nut_diameter/2, 0, 2])
                            cube([M3_nut_diameter, 100, M3_nut_height]);
                }
    }
}


888_2018();

//tube_part();
