DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>
use <./lib/stdlib/naca4.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;


Rudder_shaft_outside_diameter = tail_length * surface_distance(x = Rudder_shaft_x_position / tail_length, naca = 0009, open = false) * 2;

draft = $preview;

// side_choose -tvar A levá (- 1) nebo pravá (1) strana (ve směru letu)

module 666_1028_body_bottom(side_choose = 1, draft) {
    difference(){
        union(){
            //Main Wall-------------------------------------------------
            hollow_airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = tail_bottom_height, open = false, wall_thickness = Rudder_wall_thickness);


            //Adding material inside rudder-----------------------------
            intersection(){
                airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = tail_bottom_height, open = false);

                union(){
                    //Ribs------------------------------------------------------
                    //TODO: check if they are dynamic

                    translate([0, 0, tail_length * 2])
                        rotate([0, 45, 0])
                            for (i = [0:30]) {
                                translate([i * 32.5, 0, 0])
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }

                    translate([0, 0, 0])
                        rotate([0, - 45, 0])
                            for (i = [0:30]) {
                                translate([i * 32.5, 0, 0])
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }

                    //Material for rudder shaft------------------------------------
                    translate([Rudder_shaft_x_position, 0, tail_bottom_height / 2 + 1])
                        cube([Rudder_shaft_diameter + 10, tail_depth, tail_bottom_height + 2], center = true);

                 }
            }
            // change to the same code which generates the hull drop skin in future
            //translate ([-airfoil_depth/2, length/2, 0])
                intersection(){
                    translate ([tail_length/2, 0, -25])
                        cube([tail_length, 50, 50], center = true);

                    rotate([0,90,0])
                        rotate_extrude($fn = draft ? 50 : 200)
                            rotate([0,0,90])
                                difference()
                                {
                                  polygon(points = airfoil_data(naca = 0009, L = tail_length, N = draft ? 50 : 100, open = false));
                                  square(tail_length);
                                }
                }
        }

    //Removing material-----------------------------------------

    //Holes for rudder shaft------------------------------------
    translate([Rudder_shaft_x_position, 0, 1])
        cylinder(d = Rudder_shaft_diameter, h = tail_bottom_height + 2, $fn = draft ? 10 : 50);


    }
}

module 666_1028_body_middle(side_choose = 1, draft) {
    union() {
        difference(){
            union(){
                //Main Wall-------------------------------------------------
                hollow_airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = Rudder_height, open = false, wall_thickness = Rudder_wall_thickness);


                //Adding material inside rudder-----------------------------
                intersection(){
                    airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = Rudder_height, open = false);

                    union(){
                        //Ribs------------------------------------------------------
                        //TODO: check if they are dynamic

                        translate([0, 0, tail_length * 2])
                            rotate([0, 45, 0])
                                for (i = [0:30]) {
                                    translate([i * 32.5, 0, 0])
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }

                        translate([0, 0, 0])
                            rotate([0, - 45, 0])
                                for (i = [0:30]) {
                                    translate([i * 32.5, 0, 0])
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }

                        translate([(tail_tube_mount_length + Rudder_infill_wall_thickness) / 2, 0, tail_pipe_z_position - tail_bottom_height])
                            //Mount and servo material----------------------------------
                            union(){
                                cube([tail_tube_mount_length + Rudder_infill_wall_thickness, Rudder_depth * 2, tail_tube_mount_height + (Rudder_infill_wall_thickness + global_clearance) * 2], center = true);
                                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, 0, - tail_servo_height / 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
                                    cube([tail_servo_length + Rudder_infill_wall_thickness * 2, Rudder_depth * 2, tail_servo_height + Rudder_infill_wall_thickness * 2], center = true);
                            }
                     }
                }
            }

        //Removing material-----------------------------------------

        //Hole for rudder-------------------------------------------
        translate([Rudder_shaft_x_position, - tail_depth / 2, - 1])
            cube([Rudder_length + Rudder_gap_width + 5, tail_depth, Rudder_height + 2]);

        translate([Rudder_shaft_x_position, 0, Rudder_height/ 2])
            cylinder(d = Rudder_shaft_outside_diameter + Rudder_gap_width + global_clearance, h = Rudder_height + 2, $fn = draft ? 10 : 50, center = true);

        //Removing material for mount and servo---------------------
        translate([(tail_tube_mount_length) / 2, 0, tail_pipe_z_position - tail_bottom_height])
            union() {
                //hole for servo
                //TODO: Y axis not dynamic
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2 + Rudder_infill_wall_thickness, side_choose *  tail_servo_wall_and_screws_y_position, - tail_servo_height / 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
                    cube([tail_servo_length_inside, Rudder_depth * 2, tail_servo_height], center = true);

                //servo mount walls
                translate([(tail_tube_mount_length + tail_servo_length) / 2 + Rudder_infill_wall_thickness, - side_choose * (- Rudder_depth + tail_servo_wall_y_offset), - tail_servo_height / 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
                    cube([tail_servo_length, Rudder_depth * 2, tail_servo_height], center = true);

                //servo screw holes
                //TODO: Y axis not dynamic
                translate([(tail_tube_mount_length + tail_servo_length + tail_servo_screws_gap) / 2 + Rudder_infill_wall_thickness, side_choose * tail_servo_wall_and_screws_y_position, - Rudder_infill_wall_thickness - tail_servo_z_offset - tail_servo_screws_z_position])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth * 2, d = tail_servo_screws_diameter, $fn = draft ? 10 : 50, center = true);

                translate([(tail_tube_mount_length + tail_servo_length - tail_servo_screws_gap) / 2 + Rudder_infill_wall_thickness, side_choose *  tail_servo_wall_and_screws_y_position, - Rudder_infill_wall_thickness - tail_servo_z_offset - tail_servo_screws_z_position])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth * 2, d = tail_servo_screws_diameter, $fn = draft ? 10 : 50, center = true);

                //wire hole
                difference() {
                    cube([tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_wire_hole_length * 2, tail_servo_wire_hole_width, tail_servo_wire_hole_width], center = true);

                    //TODO: cutter is not dynamic
                    translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, 0, tail_servo_height / 2 + tail_servo_z_offset + 10])
                        cube([tail_servo_length + Rudder_infill_wall_thickness * 2, Rudder_depth * 2, tail_servo_height + Rudder_infill_wall_thickness * 2], center = true);
                }

                //tube
                translate([- 1 - Rudder_infill_wall_thickness / 2, 0, 0])
                    cube([tail_tube_mount_length + 2, Rudder_depth * 4, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);

                //wings
                translate([- 1 - Rudder_infill_wall_thickness / 2, 0, 0])
                    cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + global_clearance * 2, tail_tube_mount_height + global_clearance * 2], center = true);

                //front side cut
                translate([- tail_tube_mount_length + tail_front_mount_edge_cut_x_position, 0, 0])
                    cube([tail_tube_mount_length, Rudder_depth * 2, tail_tube_mount_height + global_clearance * 2], center = true);

                //tube mount screws
                translate([tail_tube_mount_screws_x_position, - side_choose * (Rudder_depth + 1) , tail_tube_mount_screws_z_position])
                    rotate([- side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = draft ? 10 : 50);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([- tail_tube_mount_screws_x_position, - side_choose * (Rudder_depth + 1) , tail_tube_mount_screws_z_position])
                    rotate([- side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = draft ? 10 : 50);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([tail_tube_mount_screws_x_position, - side_choose * (Rudder_depth + 1) , - tail_tube_mount_screws_z_position])
                    rotate([- side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = draft ? 10 : 50);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([- tail_tube_mount_screws_x_position, - side_choose * (Rudder_depth + 1) , - tail_tube_mount_screws_z_position])
                    rotate([- side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = draft ? 10 : 50);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                }
        }

    //Printing support--------------------------------------------

        // front mount support
        // (not dynamic at all)
    translate([tail_tube_mount_length / 2 + 2, 0, tail_pipe_z_position - tail_bottom_height])
        difference() {
            cube([tail_tube_mount_length - 7, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2,tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);

            cube([tail_tube_mount_length - 8, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2 - 2, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2 + 2], center = true);
        }

    //------------------------------------------------------------
    }
}

module 666_1028_body_top(side_choose = 1, draft) {
    difference(){
        union() {
            //Main Wall-------------------------------------------------
            hollow_airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = tail_height - tail_bottom_height - Rudder_height, open = false, wall_thickness = Rudder_wall_thickness);

            //Adding material inside rudder-----------------------------
            intersection(){
                airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = tail_height - tail_bottom_height - Rudder_height, open = false);

                    union(){
                        //Ribs------------------------------------------------------
                        //TODO: check if they are dynamic

                        translate([0, 0, tail_length * 2])
                            rotate([0, 45, 0])
                                for (i = [0:30]) {
                                    translate([i * 32.5, 0, 0])
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }

                        translate([0, 0, 0])
                            rotate([0, - 45, 0])
                                for (i = [0:30]) {
                                    translate([i * 32.5, 0, 0])
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }


                        //Material for rudder shaft------------------------------------
                        translate([Rudder_shaft_x_position, 0, (tail_height - tail_bottom_height - Rudder_height) / 2 + 1])
                            cube([Rudder_shaft_diameter + 10, tail_depth, tail_height - tail_bottom_height - Rudder_height + 2], center = true);

                        //Material for A shape screws----------------------------------
                        translate([tail_A_shape_screw_x_position_1, 0, (tail_height - tail_bottom_height - Rudder_height) / 2 + 1])
                            cube([M3_screw_diameter + 10, tail_depth, tail_height - tail_bottom_height - Rudder_height + 2], center = true);

                        translate([tail_A_shape_screw_x_position_2, 0, (tail_height - tail_bottom_height - Rudder_height) / 2 + 1])
                            cube([M3_screw_diameter + 10, tail_depth, tail_height - tail_bottom_height - Rudder_height + 2], center = true);

                    }
            }
        }
        //Removing material-----------------------------------------

        //Holes for rudder shaft------------------------------------
        translate([Rudder_shaft_x_position, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = tail_height - tail_bottom_height - Rudder_height + 2, $fn = draft ? 10 : 50);

        //Cut to make shape A angle---------------------------------
        translate([tail_length / 2, side_choose * (sqrt(pow(tail_depth, 2) * 2) / 2 - tail_shape_A_cutter_y_position), tail_height - tail_bottom_height - Rudder_height])
            rotate([tail_angle / 2, 0, 0])
                cube([tail_length, tail_depth, tail_depth], center = true);

        //Holes for shape A holding screws--------------------------
        //TODO: check if they are dynamic

        translate([tail_A_shape_screw_x_position_1, 0, tail_A_shape_screw_y_pisition])
            rotate([- side_choose * tail_angle / 2, 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
                    translate([0, 0, - Rudder_depth])
                        if(side_choose == 1) {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = 6, center = true);
                        } else {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = 6, center = true);
                        }
                }

        translate([tail_A_shape_screw_x_position_2, 0, tail_A_shape_screw_y_pisition])
            rotate([- side_choose * tail_angle / 2, 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
                    translate([0, 0, - Rudder_depth])
                        if(side_choose == 1) {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = 6, center = true);
                        } else {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = 6, center = true);
                        }
                }
         //----------------------------------------------------------
    }
}

module 666_1028_tube_mount(draft) {
    difference() {
       union() {
            intersection() {
                //main body
                translate([- tail_tube_mount_length / 2, 0, - tail_tube_mount_height / 2])
                    airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 200, h = tail_tube_mount_height, open = false);
                cube([tail_tube_mount_length - global_clearance, Rudder_depth * 2, tail_tube_mount_height], center = true);
            }
            //tube wall
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter + Rudder_wall_thickness * 2, h = tail_tube_mount_length, center = true, $fn = draft ? 10 : 50);
        }

        //tube hole
        rotate([0, 90, 0])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = tail_tube_mount_length + 2, center = true, $fn = draft ? 10 : 50);

        //tube mount screws
        translate([tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([- tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([- tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);

        //wings cut
        difference() {
            union() {
                translate([0, (Rudder_depth + tail_tube_mount_wings_thickness) / 2, (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 + Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, (Rudder_depth + tail_tube_mount_wings_thickness) / 2, - (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 - Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, - (Rudder_depth + tail_tube_mount_wings_thickness) / 2, (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 + Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, - (Rudder_depth + tail_tube_mount_wings_thickness) / 2, - (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 - Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
            }
        
            //front side cut
            translate([- tail_tube_mount_length + tail_front_mount_edge_cut_x_position, 0, 0])
                cube([tail_tube_mount_length, Rudder_depth * 2, tail_tube_mount_height + global_clearance * 2], center = true);
        }
    }
}

module 666_1028_rudder(side_choose = 1, draft) {
    difference() {
        union() {
            intersection() {
                union() {
                    airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = Rudder_height - global_clearance * 2, open = false);
                    
                    translate([Rudder_shaft_x_position, 0, Rudder_height / 2])
                        cylinder(d = Rudder_shaft_outside_diameter, h = Rudder_height, $fn = draft ? 10 : 50, center = true);
                }
                union() {
                    // material around shaft
                    translate([Rudder_shaft_x_position, 0, Rudder_height / 2 - 1])
                        cylinder(d = Rudder_shaft_diameter + 2, h = Rudder_height, $fn = draft ? 10 : 50, center = true);
                    
                    // washer like material on top
                    translate([Rudder_shaft_x_position, 0, Rudder_height - global_clearance * 2])
                        cylinder(d = M3_nut_diameter, h = 1, $fn = draft ? 10 : 50, center = true);
                    
                    // material at front half cylinder
                    translate([Rudder_shaft_x_position, 0, Rudder_height / 2 - 1])
                        difference() {
                            cylinder(d = Rudder_shaft_outside_diameter, h = Rudder_height, $fn = draft ? 10 : 50, center = true);
                            translate([0, 0, global_clearance])
                                cylinder(d = Rudder_shaft_outside_diameter - 2, h = Rudder_height - 2, $fn = draft ? 10 : 50, center = true);
                            translate([Rudder_shaft_outside_diameter / 2, 0, 0])
                                cube([Rudder_shaft_outside_diameter, Rudder_depth, Rudder_height + 2], center = true);
                        }
                    
                    // material for holes for servo arm
                    translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, 0, Rudder_height / 2 + tail_servo_rudder_arm_z_offset])
                        cube([tail_servo_rudder_arm_side_size + 2, Rudder_depth, tail_servo_rudder_arm_side_size + 2], center = true);
                    
                    //Ribs------------------------------------------------------
                    //TODO: check if they are dynamic

                    translate([0, 0, tail_length * 2])
                        rotate([0, 45, 0])
                            for (i = [0:30]) {
                                translate([i * 32.5, 0, 0])
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }

                    translate([0, 0, 0])
                        rotate([0, - 45, 0])
                            for (i = [0:30]) {
                                translate([i * 32.5, 0, 0])
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }
                }
            }
            
            //main rudder wall
            difference() {
                hollow_airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = Rudder_height - global_clearance * 2, open = false);
                translate([0, - Rudder_depth, - 1])
                    cube([Rudder_shaft_x_position, Rudder_depth * 2, tail_height + 2]);
            }
        }
        
        //shaft hole
        translate([Rudder_shaft_x_position, 0, Rudder_height / 2])
            cylinder(d = Rudder_shaft_diameter, h = Rudder_height * 2, $fn = draft ? 10 : 50, center = true);
        
        // cutting back side of servo arm holder to make it square
        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, side_choose * (- Rudder_depth / 2 - tail_length * surface_distance(x = (Rudder_shaft_x_position + 4.35 + tail_servo_rudder_arm_side_size / 2 + Rudder_arm_x_offset) / tail_length, naca = 0009, open = false)), Rudder_height / 2 + tail_servo_rudder_arm_z_offset])
            cube([tail_servo_rudder_arm_side_size, Rudder_depth, tail_servo_rudder_arm_side_size], center = true);
        
        // cutting front side of servo arm holder to make it square and same position as servo
        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, side_choose * (tail_servo_rudder_arm_depth / 2 + tail_servo_rudder_arm_y_offset), Rudder_height / 2 + tail_servo_rudder_arm_z_offset])
            union() {
                cube([tail_servo_rudder_arm_side_size, tail_servo_rudder_arm_depth, tail_servo_rudder_arm_side_size], center = true);
                translate([- 2.35 / 2, 0, 0])
                    cube([tail_servo_rudder_arm_side_size + 2.35, tail_servo_rudder_arm_depth, 5], center = true);
            }

        //páka pro táhlo
        height = 10;
        lenght = 11;

        // vypocet pozice sroubu
        // roztec sroubu pres uhlopricku
        screws_distance = (11+7.5)/2;

        // výpočet úhlopříčky základny páky
        diagonal = sqrt(height*height+lenght*lenght);


        // šrouby leží na úhlopříčce základny a je známá vzdálenost mezi šrouby
        // pozice šroubů se proto spočítají z podobnosti trojúhelníků
        screw_xposition = (lenght/diagonal)*(screws_distance/2);
        screw_yposition = (height/diagonal)*(screws_distance/2);

        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, 0, Rudder_height / 2 + tail_servo_rudder_arm_z_offset]){
            translate([screw_xposition, 0, screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([-screw_xposition, 0, -screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([screw_xposition, 0, -screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([-screw_xposition, 0, screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);
        }
    }
}

// tyc ke smerovce
module 666_1028_pipe(){
    translate([0, 0, tail_pipe_z_position])
        rotate([0, -90, 0])
            translate([0, 0, -tail_tube_mount_length])
                difference(){
                    cylinder(d = tube_for_undercarriage_outer_diameter, h = 1000, $fn = 40);
                    cylinder(d = tube_for_undercarriage_outer_diameter-3, h = 1000, $fn = 40);
                }

}

module 666_1028(side_choose = 1, rudder = true, rudder_angle = 15, pipe = false){

//    666_1028_body_bottom(side_choose);
//
////    translate([0, 0, tail_bottom_height])
////        666_1028_body_middle(side_choose);
//
    if(rudder)
        translate([Rudder_shaft_x_position, 0, tail_bottom_height + global_clearance])
            rotate([0, 0, rudder_angle])
                translate([-Rudder_shaft_x_position, 0, 0])
                666_1028_rudder(side_choose);
//
//    translate([tail_tube_mount_length / 2 - global_clearance / 2, 0, tail_pipe_z_position])
//        666_1028_tube_mount(side_choose);
//
//    translate([0, 0, tail_bottom_height + Rudder_height])
//        666_1028_body_top(side_choose);
//
//    if(pipe)
//        666_1028_pipe(side_choose);
}


666_1028(side_choose = -1);
echo("vzdálenost tyci:", tail_pipe_distance);
