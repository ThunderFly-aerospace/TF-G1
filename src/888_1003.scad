module 666_1004_mod(){

width_mod = main_tube_outer_diameter + 2*(main_tube_outer_diameter/5) + global_clearance;
depth_mod = main_tube_outer_diameter*2 + 2*(main_tube_outer_diameter/5) + main_tube_outer_diameter/ + global_clearance;
height_mod = width_mod;

	difference(){
 
 	translate([-(width_mod/2),- (depth_mod - main_tube_outer_diameter/2 - main_tube_outer_diameter/5),0])
		cube([width_mod,depth_mod,height_mod]);

    //bevelled edge

    translate([width_mod/2+sqrt(2)*(main_tube_outer_diameter/5),0,-3])
    	rotate([0,0,45])
    		cube([width_mod, width_mod,height_mod+6]);
    
    translate([-(width_mod/2)-sqrt(2)*(main_tube_outer_diameter/5),0,-3])
    	rotate([0,0,45])
    		cube([width_mod, width_mod,height_mod+6]); 
    
    translate([-(width_mod/2)-3,- depth_mod + height_mod/2-sqrt(2)*(main_tube_outer_diameter/5),-height_mod+(sqrt(2)*(main_tube_outer_diameter/5))/2])
    	rotate([45,0,0])
    		cube([width_mod+6,height_mod,height_mod]);
   
    translate([-(width_mod/2)-3, -depth_mod + height_mod/2-sqrt(2)*(main_tube_outer_diameter/5),height_mod/2])  
    	rotate([45,0,0])
    		cube([width_mod+6,height_mod,height_mod]);    
	}
}
   

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module 888_1003(){

//umístění OpticalFlow senzoru
union(){
   
   translate([-width_optical_flow_senzor/2,0,height_optical_flow_senzor/2])    
   		rotate([180,0,0])
        	
        	//difference placka
        	difference(){    
            	translate([-2.5,0,-2.5])
            			cube([width_optical_flow_senzor+5,depth_optical_flow_senzor,5+height_optical_flow_senzor]);
        		
        		//otvory pro šrouby pro připevnění senzoru
        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
           			rotate([90,0,0])
                		cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            		rotate([90,0,0])
                		cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		translate([width_optical_flow_senzor - M3_optical_flow_senzor_X_alone,50, height_optical_flow_senzor - M3_optical_flow_senzor_Z_alone])
            		rotate([90,0,0])
                		cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        		//otvory pro matky
        		translate([0,depth_optical_flow_senzor/2,0])
        		union(){
        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,0,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,0,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X, 0,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,0,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);
       
        		translate([width_optical_flow_senzor - M3_optical_flow_senzor_X_alone,0, height_optical_flow_senzor - M3_optical_flow_senzor_Z_alone])
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);
				}
			//difference
        	}

			//difference pro připevnění k dílu 666_1004
            /*
			difference(){
				translate([-width_optical_flow_senzor/2,0,-25/4])
						cube([width_optical_flow_senzor,main_tube_outer_diameter/2,25/2]);

				translate([0,main_tube_outer_diameter/2 + main_tube_outer_diameter/5,(main_tube_outer_diameter + 2*(main_tube_outer_diameter/5))/2])
					rotate([180,0,0])
						666_1004_mod();

				//otvor pro matku pro připevnění senzoru			
		    	translate([-width_optical_flow_senzor/2 + (width_optical_flow_senzor - M3_optical_flow_senzor_X_alone),+40 - depth_optical_flow_senzor/2,-(height_optical_flow_senzor/2) + M3_optical_flow_senzor_Z_alone])   
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

				//otvor pro šroub pro připevnění placky
				translate([-width_optical_flow_senzor/2 - 15,main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])
						cylinder(h = width_optical_flow_senzor + 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
				
				//matka pro připevnění placky
				translate([width_optical_flow_senzor/2 - 2.5,main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])	
						%cylinder(h = M3_nut_height + 5, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

				translate([ - 5 - M3_nut_height - width_optical_flow_senzor/2 + 2.5, main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])	
						cylinder(h = M3_nut_height + 5, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

			//difference
			}*/
    union(){
    translate([width_optical_flow_senzor/2 + hull_wall_thickness*3,- main_tube_outer_diameter - 4.85,-25/4])
            cube([hull_wall_thickness*5, main_tube_outer_diameter + 4.85, 25/2]);
        
        difference(){
                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4 - hull_wall_thickness, -main_tube_outer_diameter*1.1 - hull_wall_thickness*3 + 0.1,-25/4])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, 25/2]);

                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4  + hull_wall_thickness*5 + M3_screw_diameter/2,main_tube_outer_diameter,0])    
                    rotate([90,0,0])
                        cylinder(h = width_optical_flow_senzor + 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                
                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4  + hull_wall_thickness*5 + M3_screw_diameter/2,- 15 + 5 + M3_nut_height*1.75 + hull_wall_thickness*7,0])    
                    rotate([90,0,0])
                        cylinder(h = M3_nut_height + 5, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

        }
}

mirror([1,0,0])
    union(){
    translate([width_optical_flow_senzor/2 + hull_wall_thickness*3,- main_tube_outer_diameter - 4.85,-25/4])
            cube([hull_wall_thickness*5, main_tube_outer_diameter + 4.85, 25/2]);
        
        difference(){
                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4 - hull_wall_thickness, -main_tube_outer_diameter*1.1 - hull_wall_thickness*3 + 0.1,-25/4])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, 25/2]);

                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4  + hull_wall_thickness*5 + M3_screw_diameter/2,main_tube_outer_diameter,0])    
                    rotate([90,0,0])
                        cylinder(h = width_optical_flow_senzor + 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                
                translate([width_optical_flow_senzor/2 + main_tube_outer_diameter/4  + hull_wall_thickness*5 + M3_screw_diameter/2,- 15 + 5 + M3_nut_height*1.75 + hull_wall_thickness*7,0])    
                    rotate([90,0,0])
                        cylinder(h = M3_nut_height + 5, r1 = M3_nut_diameter/2, r2 = M3_nut_diameter/2, $fn = 6);

        }
}
//union
}
//final module
}

module 888_1003_print(draft){
intersection(){
    translate([bottom_cover_division[3] + bottom_cover_division[1]*0.75,-main_tube_outer_diameter,0])
        rotate([0,90,0])
            888_1003();

drop ();

}
}



666_1029();

888_1003_print(draft);

use <666_1029.scad>
use <888_1000.scad>
use <./lib/naca4.scad>
include <../parameters.scad>

