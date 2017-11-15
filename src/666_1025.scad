use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>


//Jen pro názornost
	//translate([180,0,0])
		//rotate ([-90,0,0])
			//666_1032();





module 666_1025(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

    difference(){
        intersection () {
            union(){
        		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

                // 666_1032 part holder
                translate([180,0,0]) 
                    rotate ([-90,0,0]) 
                        difference(){
                            
                            translate ([hull_wall_thickness,0,0])
                                resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                                    airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
                            translate ([2*hull_wall_thickness,0,0])       
                                resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                                    airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
                            
                        }

            }
            translate([0,0,hull_corner_radius])
            	minkowski(){                   
             		translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             				cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	
             			rotate ([0,90,0])
                 			cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   

		        }

        }   

        //hollowing skeleton
    		translate ([hull_wall_thickness,0,0])
            	intersection () {
                    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness], auto=true)
                 		rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=200)); 
                                      square(hull_drop_length); 
                                    }
                 	translate([0,0,hull_corner_radius])
                 		minkowski(){                   
                     		translate ([0,-(main_tube_outer_diameter/2),-hull_z_size/2 + hull_wall_thickness])
                     				cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness-2*hull_corner_radius]);
                     			rotate ([0,90,0])
                         			cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
            			}                   
            	}
            //for front part
    		translate ([-2,-1 - main_tube_outer_diameter/2,-25])
    				cube ([52,hull_y_size+10,50]);

        //for tube in back
    		translate ([hull_x_size-70,0,0])
    			rotate ([0,90,0])
    				cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
    					    
        //for tube - propeller

			translate ([180+2*hull_wall_thickness,-10,0])       
				rotate ([-90,0,0])
                    resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                        airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
        			
        //for printing
    		translate([0,-main_tube_outer_diameter/2-4.90,-170/2])
    			cube ([600,5,170]);

    		translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
    			cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);	

//díry pro šrouby
translate([50,-5,-200/2])
rotate([0,0,0])
%cylinder (h = 200, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2);



    }




}


    intersection(){
        666_1025();
        translate([0,-20,-150])                        
           cube([150,150,300]);
    }

    translate([20,0,0])
        intersection(){
            666_1025();
            translate([150,-20,-150])
               cube([150,150,300]);
        }

    translate([40,0,0])
        intersection(){
            666_1025();
            translate([300,-20,-150])
               cube([150,150,300]);
        }


    translate([60,0,0])
        intersection(){
            666_1025();
            translate([450,-20,-150])
              cube([150,150,300]);
        }




