use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1025(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

    difference(){
    union (){
    difference(){
    intersection () {
        translate([0,0,0])
                 		rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
                                      square(hull_drop_length); 
                                    }

        scale ([hull_scale_x,hull_scale_y,hull_scale_z]) 
        				rotate ([0,90,0])           
                           	rotate_extrude($fn = 100)
                               	rotate([0,0,90])
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
                                      square(hull_drop_length); 
                                    }
            minkowski(){                   
             	translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             		cube ([hull_x_size,hull_y_size*hull_scale_y,hull_z_size]);
             	
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
                     	minkowski(){                   
                         	translate ([0,-(main_tube_outer_diameter/2),-hull_z_size/2 + hull_wall_thickness])
                         		cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness]);
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
    		//translate ([237.5 - (main_tube_outer_diameter/2),90,-main_tube_outer_diameter/2])
    		translate ([170+68- main_tube_outer_diameter/2,main_tube_outer_diameter+40,-main_tube_outer_diameter/2])

    			rotate ([0,0,0])
    				cube ([main_tube_outer_diameter, main_tube_outer_diameter*2,main_tube_outer_diameter]);
        			
        //for printing
    		translate([0,-main_tube_outer_diameter/2-4.90,-170/2])
    			cube ([600,5,170]);

    		translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
    			cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);	

    }

    difference(){
    //hodní držák

    scale ([1,1,1.2])     
        translate([180,0,0])             
        	rotate([-90,0,0])
                resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*hull_airfoil_thickness/100)- 2*hull_wall_thickness,315], auto=true) airfoil(naca = hull_airfoil_thickness, L = 170, N=101, h = 260, open = false);
        translate([185,0,0])
            rotate([-90,0,0])    
                resize([150 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(150*hull_airfoil_thickness/100)- 2*hull_wall_thickness,315], auto=true) airfoil(naca = hull_airfoil_thickness, L = 150, N=101, h = 240, open = false);

        translate([180,110,-100])        
    			cube([200,250,200]);
    }


    }

    translate([-30,-50,-0.5])
    cube ([600,250,1]);
    }
}


666_1025();