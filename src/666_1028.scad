DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>
use <./lib/naca4.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

draft = true;

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
                                translate([i * 25, 0, 0]) 
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }
                            
                    translate([0, 0, 0])
                        rotate([0, - 45, 0])
                            for (i = [0:30]) {
                                translate([i * 25, 0, 0]) 
                                    cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                            }
                            
                    //Material for support tubes-----------------------------------
                    translate([tail_support_x_position_1, 0, tail_bottom_height / 2 + 1])
                        cube([Rudder_shaft_diameter + 10, tail_depth, tail_bottom_height + 2], center = true);
                            
                    translate([tail_support_x_position_2, 0, tail_bottom_height / 2 + 1])
                        cube([Rudder_shaft_diameter + 10, tail_depth, tail_bottom_height + 2], center = true);
                            
                    //Material for rudder shaft------------------------------------
                    translate([tail_length - Rudder_length + Rudder_gap_width + 5, 0, tail_bottom_height / 2 + 1])
                        cube([Rudder_shaft_diameter + 10, tail_depth, tail_bottom_height + 2], center = true);
                            
                 }
            }
        }
        
    //Removing material-----------------------------------------
    
    //Holes for support tubes-----------------------------------
    translate([tail_support_x_position_1, 0, - 1])
        cylinder(d = Rudder_shaft_diameter, h = tail_bottom_height + 2, $fn = draft ? 10 : 50);
        
    translate([tail_support_x_position_2, 0, - 1])
        cylinder(d = Rudder_shaft_diameter, h = tail_bottom_height + 2, $fn = draft ? 10 : 50);
        
    //Holes for rudder shaft------------------------------------
    translate([tail_length - Rudder_length + Rudder_gap_width + 5, 0, - 1])
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
                                    translate([i * 25, 0, 0]) 
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }
                                
                        translate([0, 0, 0])
                            rotate([0, - 45, 0])
                                for (i = [0:30]) {
                                    translate([i * 25, 0, 0]) 
                                        cube([Rudder_wall_thickness, Rudder_depth * 4, tail_length * 4], center = true);
                                }
                                
                        //Material for support tubes-----------------------------------
                        translate([tail_support_x_position_1, 0, Rudder_height / 2 + 1])
                            cube([Rudder_shaft_diameter + 10, tail_depth, Rudder_height + 2], center = true);
                                
                        translate([tail_support_x_position_2, 0, Rudder_height / 2 + 1])
                            cube([Rudder_shaft_diameter + 10, tail_depth, Rudder_height + 2], center = true);
                        
                        translate([(tail_tube_mount_length + Rudder_infill_wall_thickness) / 2, 0, tail_pipe_z_position - tail_bottom_height])
                            //Mount and servo material----------------------------------
                            union(){
                                cube([tail_tube_mount_length + Rudder_infill_wall_thickness, Rudder_depth * 2, tail_tube_mount_height + (Rudder_infill_wall_thickness + global_clearance) * 2], center = true);
                                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, 0, tail_servo_height / 2 + Rudder_infill_wall_thickness + tail_servo_z_offset])
                                    cube([tail_servo_length + Rudder_infill_wall_thickness * 2, Rudder_depth * 2, tail_servo_height + Rudder_infill_wall_thickness * 2], center = true);
                            }
                     }
                }
            }
            
        //Removing material-----------------------------------------
        
        //Holes for support tubes-----------------------------------
        translate([tail_support_x_position_1, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = Rudder_height + 2, $fn = draft ? 10 : 50);
            
        translate([tail_support_x_position_2, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = Rudder_height + 2, $fn = draft ? 10 : 50);
            
        //Hole for rudder-------------------------------------------
        translate([tail_length - Rudder_length - Rudder_gap_width, - tail_depth / 2, - 1])
            cube([Rudder_length + Rudder_gap_width + 5, tail_depth, Rudder_height + 2]);
            
            
                    
       //Removing material for mount and servo-----------------------
       translate([(tail_tube_mount_length + Rudder_infill_wall_thickness) / 2, 0, tail_pipe_z_position - tail_bottom_height])        
            union() {
                //hole for servo
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, 0, tail_servo_height / 2 + Rudder_infill_wall_thickness + tail_servo_z_offset])
                    cube([tail_servo_length_inside, Rudder_depth * 4, tail_servo_height], center = true);
                
                //servo mount wall
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, side_choose * (Rudder_depth + Rudder_infill_wall_thickness + tail_servo_wall_y_offset), tail_servo_height / 2 + Rudder_infill_wall_thickness + tail_servo_z_offset])
                    cube([tail_servo_length, Rudder_depth * 2, tail_servo_height], center = true);
                
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length) / 2, side_choose * (- Rudder_depth + tail_servo_wall_y_offset), tail_servo_height / 2 + Rudder_infill_wall_thickness + tail_servo_z_offset])
                    cube([tail_servo_length, Rudder_depth * 2, tail_servo_height], center = true);
                
                //servo screw holes
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length + tail_servo_screws_gap) / 2, 0, Rudder_infill_wall_thickness + tail_servo_z_offset + tail_servo_screws_z_position])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth * 2, d = M2_screw_diameter, $fn = 100, center = true);
                
                translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length - tail_servo_screws_gap) / 2, 0, Rudder_infill_wall_thickness + tail_servo_z_offset + tail_servo_screws_z_position])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth * 2, d = M2_screw_diameter, $fn = 100, center = true);
                
                //wire hole
                cube([tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_wire_hole_length * 2, tail_servo_wire_hole_width, tail_servo_wire_hole_width], center = true);        
                    
                //tube
                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, 0])
                    cube([tail_tube_mount_length + 2, Rudder_depth * 4, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);
                    
                //wings
                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, 0])
                    cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + global_clearance * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                    
                //tube mount screws
                translate([tail_tube_mount_screws_x_position, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
                    rotate([side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = 100);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = 100);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([- tail_tube_mount_screws_x_position, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
                    rotate([side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = 100);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = 100);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([tail_tube_mount_screws_x_position, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
                    rotate([side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = 100);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = 100);
                                    cylinder(h = Rudder_depth * 2 + 2, d = M3_nut_diameter, $fn = 6);
                                }
                                translate([- 2 - Rudder_infill_wall_thickness / 2, 0, Rudder_depth + 1])
                                    rotate([90, 0, 0])
                                        cube([tail_tube_mount_length + 2, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2, tail_tube_mount_height + global_clearance * 2], center = true);
                            }
                        }
                translate([- tail_tube_mount_screws_x_position, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
                    rotate([side_choose * 90, 0, 0])
                        union() {
                            cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = 100);
                            difference() {
                                union() {
                                    cylinder(h = Rudder_depth + 1, d = M3_nut_diameter, $fn = 100);
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
    translate([tail_tube_mount_length / 2 + 3, 0, tail_pipe_z_position - tail_bottom_height])
        difference() {
            cube([tail_tube_mount_length - 10, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2,tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);
            
            cube([tail_tube_mount_length - 11, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2 - 2, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2 + 2], center = true);
        }
        
        // servo support
        // (not dynamic at all)
    translate([(tail_tube_mount_length) / 2 + Rudder_infill_wall_thickness + tail_servo_length + 5, 0, tail_servo_height / 2 + Rudder_infill_wall_thickness + tail_servo_z_offset + tail_pipe_z_position - tail_bottom_height])
        difference() {
            cube([tail_servo_length_inside / 2, Rudder_depth, tail_servo_height + Rudder_infill_wall_thickness * 2], center = true);
            cube([tail_servo_length_inside / 2 - 1, Rudder_depth - 1, tail_servo_height + Rudder_infill_wall_thickness * 2], center = true);
        }
    //------------------------------------------------------------
    }
}

module 666_1028_body_top(side_choose = 1, draft) {
    difference(){
        //Main Wall-------------------------------------------------
        airfoil(naca = 0009, L = tail_length, N = draft ? 50 : 100, h = tail_height - tail_bottom_height - Rudder_height, open = false, wall_thickness = Rudder_wall_thickness);
        
        //Removing material-----------------------------------------
        
        //Holes for support tubes-----------------------------------
        translate([tail_support_x_position_1, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = tail_height - tail_bottom_height - Rudder_height + 2, $fn = draft ? 10 : 50);
            
        translate([tail_support_x_position_2, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = tail_height - tail_bottom_height - Rudder_height + 2, $fn = draft ? 10 : 50);
            
        //Holes for rudder shaft------------------------------------
        translate([tail_length - Rudder_length + Rudder_gap_width + 5, 0, - 1])
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
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = draft ? 10 : 50, center = true);
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
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = draft ? 10 : 50, center = true);
                        }
                }
                
        translate([tail_A_shape_screw_x_position_3, 0, tail_A_shape_screw_y_pisition])
            rotate([- side_choose * tail_angle / 2, 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
                    translate([0, 0, - Rudder_depth])
                        if(side_choose == 1) {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = 6, center = true);
                        } else {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth, $fn = draft ? 10 : 50, center = true);
                        }
                }
         //----------------------------------------------------------    
    }
}

module 666_1028_tube_mount(draft) {
    difference() {
        union() {
            
        }
    }
}


666_1028_body_bottom();

translate([0, 0, tail_bottom_height])
    666_1028_body_middle();

translate([0, 0, tail_bottom_height + Rudder_height])
    666_1028_body_top();