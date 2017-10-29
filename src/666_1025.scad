 use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1025() {

    length_of_drop = 580;
    thickness = 1;
    y_size = 75;
    z_size = 150;
    x_size = 580;
    airfoil_thickness= 45;

    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

    ratio_x = (length_of_drop - thickness - trailing_wall * thickness)/length_of_drop;
    ratio_y = (y_size + 4 - (2*thickness))/ (y_size+4);
    ratio_z = (z_size + 4 - (2*thickness))/ (z_size+4); 

    difference (){
    	
    	intersection () {
     		translate([0,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 200)
                        rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=airfoil_thickness, L = length_of_drop , N=200)); 
                              square(length_of_drop, length_of_drop); 
                            }
         	minkowski(){                   
         	translate ([0,0,-z_size/2])
         		cube ([x_size,y_size,z_size]);
         	
         		rotate ([0,90,0])
             		cylinder (h = 1, r = 4, $fn = 200);                   

    		}
    	}

    //hollowing skeleton
		translate ([thickness,0,0])
			scale ([ratio_x,ratio_y,ratio_z])
            	intersection () {
             		rotate ([0,90,0])           
                        rotate_extrude($fn = 100)
                            rotate([0,0,90])
                                difference()
                                {

                                  polygon(points = airfoil_data(naca=airfoil_thickness, L = length_of_drop, N=200)); 
                                  square(length_of_drop, length_of_drop); 
                                }
                 	minkowski(){                   
                 	translate ([0,0,-z_size/2])
                 		cube ([x_size,y_size,z_size]);
                 		rotate ([0,90,0])
                     		cylinder (h = 1, r = 4, $fn = 100);                   
            		}                   
            	}

    //for front part
		translate ([-2,-1,-25])
				cube ([52,y_size+10,50]);

    //for tube in back
		translate ([x_size-10,0,0])
			rotate ([0,90,0])
				cylinder (h = 30, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

    //for tube - propeller
		translate ([237.5 - (main_tube_outer_diameter/2),90,-main_tube_outer_diameter/2])
			rotate ([90,0,0])
				cube ([main_tube_outer_diameter, main_tube_outer_diameter,main_tube_outer_diameter]);
    			
    //for printing
		translate([0,-4.9,-170/2])
				cube ([600,5,170]);

    }

}

666_1025();
