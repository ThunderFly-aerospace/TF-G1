	use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1029(){

    length_of_drop = 580;
    thickness = 0.8;
    y_size = 100;
    z_size = 150;
    x_size = 580;
    corner_radius = 4;
    airfoil_thickness= 35;
    scale_x = 1;
    scale_y = 1.5;
    scale_z = 1.5;


    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 


difference(){

	intersection () {
    	translate([0,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }

	scale ([scale_x,scale_y,scale_z]) 
				rotate ([0,90,0])           
                   	rotate_extrude($fn = 100)
                       	rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }

                    		minkowski(){                   
         	              		translate ([0,-y_size*scale_y - main_tube_outer_diameter/2,-z_size/2])
         		           	    	  	cube ([x_size,y_size*scale_y,z_size]);
         	
         		            		rotate ([0,90,0])
             		             		cylinder (h = 1, r = corner_radius, $fn = 100);                   
    		         		}
	}

//hollowing skeleton
		translate ([thickness,0,0])
            	intersection () {
                    resize([length_of_drop - thickness - trailing_wall* thickness, (length_of_drop*airfoil_thickness/100) - 2*thickness, (length_of_drop*airfoil_thickness/100) - 2*thickness], auto=true)
                 		rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference(){
                                      polygon(points = airfoil_data(naca=airfoil_thickness, L = length_of_drop, N=200)); 
                                      square(length_of_drop, length_of_drop); 
                                    }
                 			minkowski(){                   
                    	 		translate ([0,-y_size- main_tube_outer_diameter/2,-z_size/2 + thickness])
                     		    		 cube ([x_size,y_size - thickness, z_size - 2*thickness]);
                     		
                            		rotate ([0,90,0])
                         				cylinder (h = 1, r = corner_radius, $fn = 100);                   
            				}                   
            	}
          

    
    			
    //for printing
		translate([0,-main_tube_outer_diameter/2,-170/2])
				cube ([600,15,170]);

    //holes for undercarriage
		translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-main_tube_outer_diameter,-z_size/2-20])         
                cylinder (h = z_size+40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
        translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2,-main_tube_outer_diameter,-z_size/2-20])         
                cube ([main_tube_outer_diameter, main_tube_outer_diameter, z_size+40]);

        translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),-main_tube_outer_diameter,-z_size/2-20])
                cylinder (h = z_size+40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)-main_tube_outer_diameter/2,-main_tube_outer_diameter,-z_size/2-20])
	            cube ([main_tube_outer_diameter, main_tube_outer_diameter, z_size+40]);

	//hollow front
		translate([-10,-main_tube_outer_diameter/2-3.5,-56/2])
				cube ([47.50+2,10,56]);	


	//divided part for printing
	
		//translate([0,-140,0])
				//cube([150,150,150]);
		//translate([0,-140,-150])
				//cube([150,150,150]);
		//translate([150,-140,0])
				//cube([150,150,150]);
		//translate([150,-140,-150])
				//cube([150,150,150]);
		//translate([300,-140,0])
				//cube([150,150,150]);			
		//translate([300,-140,-150])
				//cube([150,150,150]);
		//translate([450,-140,-150/2])
				//cube([150,150,150]);
}

//final part
}
666_1029();