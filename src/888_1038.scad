

// part to connect magnetic plate to autogyro


include <../parameters.scad>

module 888_1037(draft = true) {

    plate_thickness = 5;

    difference() {
        // main body
        union() {
            // offset platform
            //translate([-888_1037_length/2+888_1037_offset/2,-888_1037_width/2,0])
            //cube([888_1037_length,888_1037_width,888_1037_height]);
            
            
            // rotation locking mechanism
            difference() {
                union() {
                    cylinder(d = 888_1037_width+global_clearance+10, h = plate_thickness, $fn = draft?8:120);
                }
            }
        }
        
        // magnetic plate screw holes
        translate([0,888_1037_mag_holes_width/2,-11])
        union() {
            cylinder(d=M4_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            
        }
        
        translate([0,-888_1037_mag_holes_width/2,-11])
        union() {
            cylinder(d=M4_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            
        }
        
        
        // autogyro screw holes
        translate([888_1037_offset,0,-10])
        union() {
            
            translate([beam_patern/2,beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            }
            
            translate([beam_patern/2,-beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            }
            
            translate([-beam_patern/2,beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            }
            
            translate([-beam_patern/2,-beam_main_pipe_distance/2,-1])
            union() {
                cylinder(d=M3_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
            }
            
            for (i=[0:4]) translate([-beam_patern/2+(beam_patern/4)*i,0,-1]){
                union() {
                    cylinder(d=M3_screw_diameter, h=888_1037_height+12, $fn = draft?8:80);
                }
            }
        }
    }
}

888_1037(false);