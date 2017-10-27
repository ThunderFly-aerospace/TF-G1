 use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1025() {

length_of_drop = 580;
thickness = 2;
depth = 75;
height = 150;
width = 550;
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
		translate ([thickness/2,0,0])
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



//for front part
		translate ([-2,-1,-25])
				cube ([52,depth+10,50]);
			

//for tube in back
		translate ([width-10,0,0])
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
