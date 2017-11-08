	use <./lib/naca4.scad>
include <../Parameters.scad>


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
                            difference()
                            {

                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }

scale ([scale_x,scale_y,scale_z]) 
				rotate ([0,90,0])           
                   	rotate_extrude($fn = 100)
                       	rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }
                    minkowski(){                   
         	translate ([0,-(main_tube_outer_diameter/2)+1,-z_size/2])
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
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=airfoil_thickness, L = length_of_drop, N=200)); 
                                      square(length_of_drop, length_of_drop); 
                                    }
                 	minkowski(){                   
                     	translate ([0,-(main_tube_outer_diameter/2),-z_size/2 + thickness])
                     		cube ([x_size,y_size - thickness, z_size - 2*thickness]);
                     		rotate ([0,90,0])
                         		cylinder (h = 1, r = corner_radius, $fn = 100);                   
            		}                   
            	}
            //for front part
		translate ([-2,-1 - main_tube_outer_diameter/2,-25])
				cube ([52,y_size+10,50]);

    //for tube in back
		translate ([x_size-70,0,0])
			rotate ([0,90,0])
				cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
					
					translate ([x_size-30,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
				cube ([80,main_tube_outer_diameter, main_tube_outer_diameter]);	
    
    //for tube - propeller
		translate ([237.5 - (main_tube_outer_diameter/2),90,-main_tube_outer_diameter/2])
			rotate ([90,0,0])
				cube ([main_tube_outer_diameter, main_tube_outer_diameter,main_tube_outer_diameter]);
    			
    //for printing
		translate([0,-15- main_tube_outer_diameter/4,-170/2])
				cube ([600,15,170]);






            }