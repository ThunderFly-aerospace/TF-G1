
draft = true;

module 888_1007(){
    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness


    union(){
    	difference(){
			intersection(){
					drop_skin();
			translate([0,-hull_y_size,-hull_z_size/2])
					cube([hull_drop_length, hull_y_size, hull_z_size]);	
			}

		//holes for undercarriage
            translate([main_tube_outer_diameter*2 + coupling_wall_thickness,- thickness_between_tubes - main_tube_outer_diameter,- hull_z_size/2 - 20])
                union(){    
                    translate([main_tube_outer_diameter/2,0,0])
                    		cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                    		cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
                }
			
            translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness, - thickness_between_tubes - main_tube_outer_diameter, - hull_z_size/2 - 20])
				union(){
                    translate([main_tube_outer_diameter/2,0,0])
                    		cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                    		cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
        		}

        	//hollow front
                translate ([-2,- main_tube_outer_diameter/2 - global_clearance -thickness_between_tubes,- width_of_engine_holder/2])
                    cube([top_cover_division[1] + 2,hull_y_size+10,width_of_engine_holder]);

        //šrouby pro připevnění k 666_1027
		//A
        	translate([(bottom_cover_division[0] + bottom_cover_division[1])/15,-main_tube_outer_diameter*(3/4), -hull_z_size/2])
            	rotate([0,45,0])
               		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        mirror([0,0,1])
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15, -main_tube_outer_diameter*(3/4), -hull_z_size/2])
                rotate([0,45,0])
            		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter*(3/4), - hull_z_size/2 - 10])		
            		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        mirror([0,0,1])
            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter*(3/4), - hull_z_size/2 - 10])		
            		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
	 	//D
        	union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
        		rotate([0,90-beta,0])	
        			cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        mirror([0,0,1])
            union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        //E		
        	translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
        		rotate([0,90-beta,0])	
        			cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        mirror([0,0,1])	
            translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
 
		//šrouby mezi 2 a 3
    	translate([ bottom_cover_division[2] - 10,- 1.4*main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
    		union(){
    			translate([-1,0,0])	
    				rotate([0,90,0])
    					cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);	
    				rotate([0,-80,0])	
    					cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20);	
    		translate([20,0,0])
    			mirror([1,0,0])
    	   			rotate([0,-80,0])	
    					cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20);	
  			}

  		mirror([0,0,1])
    	translate([ bottom_cover_division[2] - 10,- 1.4*main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
    		union(){
    			translate([-1,0,0])	
    				rotate([0,90,0])
    					cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);	
    				rotate([0,-80,0])	
    					cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20);	
    		translate([20,0,0])
    			mirror([1,0,0])
    	   			rotate([0,-80,0])	
    					cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20);	
  			}



//final difference
		}
	}



}


888_1007();




use <888_1000.scad>
use <888_1004.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>