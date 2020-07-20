

// part to connect magnetic plate to autogyro


include <../parameters.scad>


module 888_1037(draft = true) {
    difference() {
        // main body
        translate([-888_1037_length/2+888_1037_offset/2,-888_1037_width/2,0])
        cube([888_1037_length,888_1037_width,888_1037_height]);
        
        // magnetic plate screw holes
        translate([0,888_1037_mag_holes_width/2,-1])
        union() {
            cylinder(d=M4_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
            
            // nut pocket
            translate([0,0,888_1037_mag_screw_depth])
            cylinder(d=M4_nut_diameter, h=888_1037_height+2, $fn=6);
        }
        
        translate([0,-888_1037_mag_holes_width/2,-1])
        union() {
            cylinder(d=M4_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
            
            // nut pocket
            translate([0,0,888_1037_mag_screw_depth])
            cylinder(d=M4_nut_diameter, h=888_1037_height+2, $fn=6);
        }
        
        
        // autogyro screw holes
        translate([888_1037_offset,0,0])
        union() {
            
            translate([beam_patern/2,beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
                cylinder(d=M3_nut_diameter, h=888_1037_height-888_1037_ag_screw_depth, $fn=6);
            }
            
            translate([beam_patern/2,-beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
                cylinder(d=M3_nut_diameter, h=888_1037_height-888_1037_ag_screw_depth, $fn=6);
            }
            
            translate([-beam_patern/2,beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
                cylinder(d=M3_nut_diameter, h=888_1037_height-888_1037_ag_screw_depth, $fn=6);
            }
            
            translate([-beam_patern/2,-beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
                cylinder(d=M3_nut_diameter, h=888_1037_height-888_1037_ag_screw_depth, $fn=6);
            }
            
            translate([0,0,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+2, $fn = draft?8:80);
                cylinder(d=M3_nut_diameter, h=888_1037_height-888_1037_ag_screw_depth, $fn=6);
            }
        }
    }
}

888_1037(false);