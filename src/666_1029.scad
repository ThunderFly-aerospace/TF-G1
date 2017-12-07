	use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1029(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 


    difference(){
    	intersection() {
     		rotate ([0,90,0])           
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference(){
                          polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                          square(hull_drop_length); 
                        }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size - main_tube_outer_diameter/2, -hull_z_size/2])
	             		cube ([hull_x_size, hull_y_size,hull_z_size - 2*hull_corner_radius]);
	             	
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
                                    difference(){
                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=200)); 
                                      square(hull_drop_length); 
                                    }
         			minkowski(){                   
            	 		translate ([0,- hull_y_size - main_tube_outer_diameter/2, -hull_z_size/2 + hull_wall_thickness + hull_corner_radius ])
             		    	//cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);	
                            cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius ]);    
                    		rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
    				}                   
            	}
        			
        //for printing
    		translate([0,-main_tube_outer_diameter/2,-170/2])
    			cube ([600,15,170]);

        //holes for undercarriage
    		translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-main_tube_outer_diameter,-hull_z_size/2-20])         
                cylinder (h = hull_z_size+40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
            translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2,-main_tube_outer_diameter,-hull_z_size/2-20])         
                cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);

            translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5),-main_tube_outer_diameter,-hull_z_size/2-20])
                cylinder (h = hull_z_size+40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
    		translate([398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)-main_tube_outer_diameter/2,-main_tube_outer_diameter,-hull_z_size/2-20])
                cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);

    	//hollow front
    		translate([-10,-main_tube_outer_diameter/2-3.5,-56/2])
    			cube ([47.50+2,10,56]);	
    //final part
    }
}
/*
//část 1
union(){
	
	difference(){
	//základní dělení pro tisk
				intersection(){
        					666_1029();
        			translate([0,-140,-100])                        
           					cube([150,150,300]);
		    	}
	//díry pro šrouby
	}

	//rantl pro slepení vpravo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([150 - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([130,-25,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 70, r2 = 60, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([0,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   

	        	}
	}

	}

//konec union
}


//část 2
union(){
	
	difference(){
	//základní dělení pro tisk
			translate([20,0,0])	
				intersection(){
        					666_1029();
        			translate([150,-140,-100])                        
           					cube([150,150,300]);
		    	}
	}
	//rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([170,-4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([150,-25,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 70, r2 = 60, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([20,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
	        	}
	}
	}

	//rantl pro slepení vpravo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([320 - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([300,-10,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 70, r2 = 60, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([20,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
	        	}
	}
	}


//konec union
}

//část 3
union(){
	
	difference(){
	//základní dělení pro tisk
			translate([40,0,0])	
				intersection(){
        					666_1029();
        			translate([300,-140,-100])                        
           					cube([150,150,300]);
		    	}
	}


	//rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([340,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([320,-10,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 70, r2 = 60, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([40,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
	        	}
	}
	}

		//rantl pro slepení vpravo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([490 - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([470,-5,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 40, r2 = 30, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([40,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
	        	}
	}
	}

//konec union
}


//část 4
union(){
	
	difference(){
	//základní dělení pro tisk
			translate([60,0,0])	
				intersection(){
        					666_1029();
        			translate([450,-140,-100])                        
           					cube([150,150,300]);
		    	}
	}

		//rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([510,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([490,-5,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 40, r2 = 30, $fn = 100);
		}

		//odstranění čtverce z vnější strany
	intersection () {
    	translate([60,0,0])
         		rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference(){
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=100)); 
                              square(hull_drop_length); 
                            }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size- main_tube_outer_diameter/2,-hull_z_size/2 - hull_corner_radius])
	             		cube ([hull_x_size, hull_y_size,hull_z_size + 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
	        	}
	}
	}



//konec union
}

*/

666_1029();