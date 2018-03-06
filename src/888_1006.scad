
module 888_1006(){
    
    //čtverec pro zámek Z+
	translate([ribbon_width,0,ribbon_width*3+global_clearance])
		rotate([0,90,0])
			union(){
    			translate([ribbon_width + global_clearance,- coupling_wall_thickness - thickness_between_tubes, hull_z_size/4 ])
            			cube([ribbon_width*2, lock_width*1.5, ribbon_width/2]);
    			translate([ribbon_width + global_clearance, 0, hull_z_size/4 - lock_width ])
            			cube([ribbon_width*2, ribbon_width/2, 2* lock_width]);
    		} 
    
    //čtverec pro zámek Z-
    translate([-2*lock_width,0,-ribbon_width - global_clearance])
   		rotate([0,-90,0])
    		union(){  
    			translate([ribbon_width + global_clearance, - coupling_wall_thickness - thickness_between_tubes, - hull_z_size/4])
            			cube([ribbon_width*2, lock_width*1.5, ribbon_width/2]);
    			translate([ribbon_width + global_clearance,0, - hull_z_size/4 - lock_width])
            			cube([ribbon_width*2, ribbon_width/2, 2*lock_width]);
    		}
}

888_1006();

use<666_1027.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>