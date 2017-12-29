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
   



module 888_1003(){

//umístění OpticalFlow senzoru
union(){
   
   translate([-width_optical_flow_senzor/2,0,height_optical_flow_senzor/2])    
   		rotate([180,0,0])
        	
        	//difference placka
        	difference(){    
            	translate([-5,0,-5])
            			cube([width_optical_flow_senzor+10,depth_optical_flow_senzor,10+height_optical_flow_senzor]);
        		
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
        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X, 10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        		translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
       
        		translate([width_optical_flow_senzor - M3_optical_flow_senzor_X_alone,10, height_optical_flow_senzor - M3_optical_flow_senzor_Z_alone])
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
		
			//difference
        	}

			//difference pro připevnění k dílu 666_1004
			difference(){
				translate([-width_optical_flow_senzor/2 - 5,0,-12.5])
						cube([width_optical_flow_senzor+10,main_tube_outer_diameter + main_tube_outer_diameter/5,25]);

				translate([0,main_tube_outer_diameter/2 + main_tube_outer_diameter/5,(main_tube_outer_diameter + 2*(main_tube_outer_diameter/5))/2])
					rotate([180,0,0])
						666_1004_mod();

				//otvor pro matku pro připevnění senzoru			
		    	translate([-width_optical_flow_senzor/2 + (width_optical_flow_senzor - M3_optical_flow_senzor_X_alone),30,-(height_optical_flow_senzor/2) + M3_optical_flow_senzor_Z_alone])   
            		rotate([90,0,0])
                		cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

				//otvor pro šroub pro připevnění placky
				translate([-width_optical_flow_senzor/2 - 15,main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])
						cylinder(h = width_optical_flow_senzor + 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
				
				//matka pro připevnění placky
				translate([-width_optical_flow_senzor/2 - 5 - 2.5 - Nut_height_M3,main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])	
						cylinder(h = Nut_height_M3 + 5, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

				translate([width_optical_flow_senzor/2 + 2.5,main_tube_outer_diameter/5 + main_tube_outer_diameter/2,0])	
					rotate([0,90,0])	
						cylinder(h = Nut_height_M3 + 5, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

			//difference
			}
//union
}
//final module
}


888_1003();


use <./lib/naca4.scad>
include <../Parameters.scad>