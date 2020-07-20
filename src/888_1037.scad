

// part to connect magnetic plate to autogyro


include <../parameters.scad>

module 888_1037(draft = true) {
    difference() {
        // main body
        union() {
            // offset platform
            //translate([-888_1037_length/2+888_1037_offset/2,-888_1037_width/2,0])
            //cube([888_1037_length,888_1037_width,888_1037_height]);
            
            
            // rotation locking mechanism
            translate([0,0,-5])
            difference() {
                union() {
                    cylinder(d = 888_1037_width+global_clearance+10, h = 888_1037_height+5, $fn = draft?8:120);
                    
                    translate([0,0,-5])
                    intersection() {
                        cylinder(d = 888_1037_width+global_clearance+10, h = 888_1037_height+10, $fn = draft?8:120);
                        
                        for (i=[0:7]) rotate([0, 0, 22.5*i]){
                            translate([0,0,0])
                            cube([888_1037_width+30,7.5,10],true);
                        }
                    }
                }
                
                translate([0,0,-15.01])
                cylinder(d = 888_1037_width+global_clearance, h = 20, $fn = draft?8:120);
            }
        }
        
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