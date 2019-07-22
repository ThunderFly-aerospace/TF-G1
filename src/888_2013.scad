// drzak podvozku za podelnou tyc virniku

include <../parameters.scad>
use <lib/igus.scad>
use <lib/vector.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.

module 888_2013_old(front = true){
    tube_wall = 4;
    height = 40;
    crop = 0;
    kstm_ball_thickness = 12;
    shoulder_screw_length = 20+2;

    screw_length = 25-4;
    rotation = front ? chassis_pipe_angle_f_z : chassis_pipe_angle_r_z;

    intersection(){
    difference(){
        union(){

            translate([20, 0, 0])
                scale([1, 1.3, 1])
                    cylinder(d=tube_for_undercarriage_outer_diameter+2*tube_wall, h = height + crop, $fn = 80);

            hull(){
                translate([2013_pipe_offset[2], 0, crop-15])
                    scale([1, 1.3, 1])
                        cylinder(d=tube_for_undercarriage_outer_diameter+2*tube_wall, h = height - crop + 15 - global_clearance, , $fn = 80);
                translate([0, 0, 0])
                    rotate([90 + rotation, 0, 0])
                        cylinder(d = 24, h = shoulder_screw_length+8, center = true, $fn = 60);
            }
        }

        translate([2013_pipe_offset[2], 0, 0])
            cylinder(d=tube_for_undercarriage_outer_diameter, h = 100, $fn = 60, center = true);

        %translate([2013_pipe_offset[2], 0, 0])
            cylinder(d=tube_for_undercarriage_outer_diameter, h = 500, $fn = 30);

        translate([2013_pipe_offset[2], 0, 10]){
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            rotate([90, 0, 0])
                translate([0, 0, screw_length/2]) cylinder(d = M3_nut_diameter, h = 50, $fn = 60);
            rotate([90, 0, 0])
                translate([0, 0, -screw_length/2-50]) cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
        }

        translate([2013_pipe_offset[2], 0, 10 + 20]){
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            rotate([90, 0, 0])
                translate([0, 0, screw_length/2]) cylinder(d = M3_nut_diameter, h = 50, $fn = 60);
            rotate([90, 0, 0])
                translate([0, 0, -screw_length/2-50]) cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
        }


        rotate([rotation, 0, 0]){
            rotate([90, 0, 0])
                cylinder(d = M8_screw_diameter, h = 50, center = true, $fn = 60);

            rotate([-90, 0, 0])
                translate([0, 0, shoulder_screw_length/2])
                    cylinder(d = 14, h = 50, center = false, $fn =60);

            rotate([90, 30, 0])
                translate([0, 0, shoulder_screw_length/2])
                    cylinder(d = M6_nut_diameter, h = 50, center = false, $fn =6);

            translate([-2, 0, 0]) cube([25, kstm_ball_thickness, 100], center = true);
        }
    }

    rotate([0, -30, 0])
    translate([0, 0, 250 + crop])
        rotate([rotation, 0, 0])
            cube(500, center = true);
    }
}



module 888_2013(front = true, left = 1, rotate = false){
    tube_wall = 5;
    height = 40;
    crop = 0;
    kstm_ball_thickness = 12;
    shoulder_screw_length = 20+2;

    length = 50;
    screw_length = 20-4;
    baselength = front ? chassis_pipe_baselength_f : -chassis_pipe_baselength_r;

    arm_r = front ? [chassis_pipe_baselength_f, chassis_pipe_wheelbase, -chassis_height] : [-chassis_pipe_baselength_r, chassis_pipe_wheelbase, -chassis_height];

    mirror([0,1,0]*left) rotate([0, 0, 180]*left)
    orientate([front ? -chassis_baselength_f : chassis_baselength_r, chassis_pipe_wheelbase, chassis_height]*rotate, [0,1,0])
    difference(){
        union(){

            translate([0, 0, -2013_pipe_offset[2]])
                orientate(arm_r, [0,1,0])
                    //translate([-tube_for_undercarriage_outer_diameter/2-tube_wall, 10, -tube_for_undercarriage_outer_diameter/2 -tube_wall - 2013_pipe_offset[2])
                    translate([0, 20, 0])
                        cube([tube_for_undercarriage_outer_diameter+2*tube_wall, length, tube_for_undercarriage_outer_diameter+2*tube_wall], center = true);

            hull(){
                rotate([90, 0, 90])
                    translate([0, 0, 1])
                        cylinder(d = 17, h = 30, center = true);


                translate([0, 0, -2013_pipe_offset[2]])
                    orientate(arm_r, [0,1,0])
                        translate([0, 0, 0])
                            cube(tube_for_undercarriage_outer_diameter+2*tube_wall, center = true);
            }

            %translate([0, 0, -2013_pipe_offset[2]])
                orientate(arm_r, [0, 1, 0])
                    rotate([0, 90, 90])
                        cylinder(d = 5, h = mod(arm_r));
        }

        rotate([90, 0, 90])
                cylinder(d = M8_screw_diameter, h = 100, center = true);

        rotate([90, 0, 90])
            translate([0, 0, shoulder_screw_length/2])
                cylinder(d = M6_nut_diameter, h = 100, $fn = 6);

        rotate([90, 0, 90])
            translate([0, 0, - shoulder_screw_length/2 - 100])
                cylinder(d = 14, h = 100, $fn = 60);

        rotate([90, 0, 90])
            hull(){
                translate([0, -2, 0]) cylinder(d = 22, h = 12.5, center = true);
                translate([10, 0, 0]) cylinder(d = 22, h = 12.5, center = true);
                translate([-10, 0, 0]) cylinder(d = 22, h = 12.5, center = true);
            }

        translate([0, 0, - 2013_pipe_offset[2]])
            orientate(arm_r, [0,1,0])
                rotate([0, 90, 90])
                    cylinder(d = tube_for_undercarriage_outer_diameter, h = 150, center = true);

        // diry na srouby skrz trubku
        for (i=[10, 30]) {
            translate([0, 0, - 2013_pipe_offset[2]])
                orientate(arm_r, [0,1,0])
                    translate([0, i, 0])
                        rotate([0, 90, 0]){
                            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);

                            translate([0, 0, screw_length/2])
                                cylinder(d = M3_nut_diameter, h = 10, $fn = 60);
                            translate([0, 0, -screw_length/2 - 10])
                                cylinder(d = M3_nut_diameter, h = 10, $fn = 6);
                        }
        }

        translate([0, 0, - 2013_pipe_offset[2]])
            orientate(arm_r, [0,1,0])
                rotate([180, 0, 90])
                    mirror([0, 1, 0]){
                        translate([15, 3, -tube_wall - tube_for_undercarriage_outer_diameter/2 - global_clearance ])
                            linear_extrude(0.8) text(front? "Front" : "Rear", size = 7);

                            translate([15, -8, -tube_wall - tube_for_undercarriage_outer_diameter/2 - global_clearance ])
                                linear_extrude(0.8) text(left? "Left" : "Right", size = 7);
                    }

    }


}



//rotate([-chassis_top_bearing_rotation[2], 0, 0])
    888_2013(false);

//888_2013_drillhelper();
