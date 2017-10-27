 use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1029() {
	
length_of_drop = 580;
thickness = 2;
depth = 90;
height = 150;
width = 544;
ratio_x = (length_of_drop-thickness)/length_of_drop;
ratio_y = (depth - thickness)/depth;
ratio_z = (height - thickness)/height; 

difference (){
	
	intersection () {
 		translate([0,0,0])
     		rotate ([0,90,0])           
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0045, L = length_of_drop)); 
                          square(length_of_drop, length_of_drop); 
                        }
     	minkowski(){                   
     	translate ([0,0,-height/2])
     		cube ([width,depth,height]);
     	
     		translate ([0,0,0])
     		rotate ([0,90,0])
     		cylinder (h = 1, r1 = 4, r2 = 4, $fn = 100);                   

		}
	}

	//for hollow
		translate ([0,0,0])
			scale ([ratio_x,ratio_y,ratio_z])


	intersection () {
 		translate([0,0,0])
     		rotate ([0,90,0])           
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0045, L = length_of_drop)); 
                          square(length_of_drop, length_of_drop); 
                        }
     	minkowski(){                   
     	translate ([0,0,-height/2])
     		cube ([width,depth,height]);
     	
     		translate ([0,0,0])
     		rotate ([0,90,0])
     		cylinder (h = 1, r1 = 4, r2 = 4, $fn = 100);                   

		}                   

	}

	//for printing
		translate([0,-4.9,-170/2])
				cube ([600,5,170]);

	// hollow for tube for undercarriage
		
		//front
		translate ([60.50,12, -height/2-20])
				cylinder (h = height + 40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);			
		translate ([60.50 - main_tube_outer_diameter/2,-1, - height/2-20])
				cube ([main_tube_outer_diameter,13, height+40]);
		//back
		translate ([390.50,12, -height/2-20])
				cylinder (h = height + 40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);			
		translate ([390.50 - main_tube_outer_diameter/2,-1, - height/2-20])
				cube ([main_tube_outer_diameter,13, height+40]);


	//hollow front
		translate([-2,0,-56/2])
				cube ([47.50+2,2,56]);			

}

}

666_1029();