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
            cylinder(d = main_tube_outer_diameter + 2*wall, h = l, center = true);
            translate([-main_tube_outer_diameter/2 - wall, -main_tube_outer_diameter/2 - wall_below, -l/2])
                cube([main_tube_outer_diameter + 2*wall, 0.1,l]);
        }
        cylinder(d = main_tube_outer_diameter, h = l + global_clearance, center = true);
        translate([0, -250 - main_tube_outer_diameter/2 -wall_below, 0]) cube(500, center = true);

        translate([-space/2, 0, -l/2])
            cube([space, 20, l]);

        rotate([0, 90, 0])
            translate([0, main_tube_outer_diameter/2 + 2, 0]){

                cylinder(d = M3_screw_diameter, h = 100, center = true);
                translate([0, 0, screw_l/2]) cylinder(d = M3_nut_diameter, h = 100);
                translate([0, 0, -screw_l/2-100]) cylinder(d = M3_nut_diameter, h = 100, $fn = 6);
        }
    }
}

module 888_2018(){

    2018_thickness_above_pipe = 2;
    thickness_above = 2018_thickness_above_pipe; // tloustka materialu mezi tyci a podlozkou

    width = chassis_suspension_basewidth + kstm_flange_length(10) + 5;
    length = main_tube_outer_diameter + 10;
    height = main_tube_outer_diameter + 2018_thickness_above_pipe + 5;

    translate([0, -chassis_top_bearing_position_y, 0])
        tube_part(l = 20, wall = 6, wall_below = M3_screw_head_height + 2 + global_clearance);

    translate([0, chassis_top_bearing_position_y, 0])
        tube_part(l = 20, wall = 6, wall_below = M3_screw_head_height + 2 + global_clearance);

    difference(){
        union(){
            translate([-main_tube_outer_diameter/2-6, -chassis_top_bearing_position_y - 20/2 - M3_nut_diameter*2, 0])
                cube([main_tube_outer_diameter+12, chassis_top_bearing_position_y*2 + 20 + M3_nut_diameter*4, 2018_thickness_above_pipe + M3_nut_height]);
        }

        for (j=[1, -1])
            translate([j*main_tube_outer_diameter/2, 0, 0])
            for (i=[-1, 0, 1]) {
                translate([0, i*(chassis_top_bearing_position_y+10 + M3_nut_diameter), 0]){
                    cylinder(d = M3_screw_diameter, h = 10);
                    translate([0, 0, 2])
                        cylinder(d = M3_nut_diameter, h = 10);
                }
            }

    }



}


888_2018();

//tube_part();
