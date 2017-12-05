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

   
union(){
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
                                resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness-2,(170*0030/100)- 2*hull_wall_thickness-2,210-2], auto=true) 
                                    airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
                            translate([2*hull_wall_thickness,0,0])       
                                resize([170 - hull_wall_thickness*2  - trailing_wall*hull_wall_thickness*2-2,(160*0030/100)- 2*hull_wall_thickness-2,210-2], auto=true) 
                                    airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
                            
                        }

            }
            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
	             		cube ([hull_x_size, hull_y_size,hull_z_size- 2*hull_corner_radius]);
	             	
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
                     		cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);
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
    					    
        //for rotor pilon

			translate ([180+2*hull_wall_thickness,-10,])       
				rotate ([-90,0,0])
                    resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                        airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
        			
        //for printing
    		translate([0,-main_tube_outer_diameter/2-4.90,-170/2])
    			cube ([600,5,170]);

    		translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
    			cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);	
    
    //konec difference
    }


//lem
       	
       	intersection(){

       		//dno
				difference(){
					translate([0,-main_tube_outer_diameter/2,-hull_z_size/2])		
							cube([hull_x_size, hull_wall_thickness, hull_z_size]);

				//for front part
    				translate ([-2,-1 - main_tube_outer_diameter/2,-25])
    						cube ([52,hull_y_size+10,50]);

        		//for tube in back
    				translate ([hull_x_size-70,-6,0])
    					rotate ([0,90,0])
    						cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

				//kapka pro kapkovitý tvar
					translate ([hull_wall_thickness+2.5,0,0])
            	intersection () {
                    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness-5, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5], auto=true)
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
                     	translate ([2.5,-(main_tube_outer_diameter/2)-2.5,-hull_z_size/2 + hull_wall_thickness+2.5])
                     		cube ([hull_x_size-5,hull_y_size - hull_wall_thickness-5, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius-5]);
                     		rotate ([0,90,0])
                         		cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
            		}                   
            	}

				}		

			//odstranění dna z vnější strany
				translate([0,0,0])
					intersection () {
        				rotate ([0,90,0])           
                    		rotate_extrude($fn = 100)
                        		rotate([0,0,90])
                            		difference()
                            		{
	                              	polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          	square(hull_drop_length); 
        	                    	}
            		}
            	translate([-20,0,hull_corner_radius])
            		minkowski(){                   
             			translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             					cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	
             				rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
		        	}
		}

    //nápis
    translate([hull_x_size/3,0,hull_z_size/2])
      text("TF-G1", size = 20,font = "Liberation Sans");

    translate([hull_x_size/3,0,-hull_z_size/2])
      text("TF-G1", size = 20,font = "Liberation Sans", direction = "rtl");
//konec union
}


//konec model
}


module 666_1025AA(){
//část 0
	//základní dělení pro tisk
			translate([-20,0,0])
				intersection(){
    				666_1025();
    					translate([0,-20,-75])                        
       						cube([50,150,150]);
       			}

		//rantl pro slepení Z+
       	
       	intersection(){

       		//čtverec
				translate([-20,-main_tube_outer_diameter/2,25])		
						cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

			//odstranění čtverce z vnější strany
				translate([-20,0,0])
					intersection () {
        				rotate ([0,90,0])           
                    		rotate_extrude($fn = 100)
                        		rotate([0,0,90])
                            		difference()
                            		{
	                              	polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          	square(hull_drop_length); 
        	                    	}
            		}
            	translate([-20,0,hull_corner_radius])
            		minkowski(){                   
             			translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             					cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	
             				rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
		        	}
		}

       	//rantl pro slepení Z-

		intersection(){
       		//čtverec
				translate([-20,- main_tube_outer_diameter/2,-25 - hull_wall_thickness])		
						cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

			//odstranění čtverce z vnější strany
				translate([-20,0,0])
					intersection () {
        				rotate ([0,90,0])           
                    		rotate_extrude($fn = 100)
                        		rotate([0,0,90])
                            		difference()
                            		{
	                              	polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          	square(hull_drop_length); 
        	                    	}
            		}
            	translate([-20,0,hull_corner_radius])
            		minkowski(){                   
             			translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             					cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	
             				rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
		        	}
		}

       	//rantl pro slepení vpravo
		
		intersection(){
		//pro lepení - čtverec 
			difference(){
			translate([30- hull_wall_thickness,0,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
			translate([20,0,0])
				rotate([0,90,0])
					cylinder(h = 20, r1 = 60, r2 = 60, $fn = 100);
			}
		//odstranění čtverce z vnější strany
			translate([-20,0,0])
				intersection () {
        			rotate ([0,90,0])           
                    	rotate_extrude($fn = 100)
                        	rotate([0,0,90])
                            	difference()
                            	{
	                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          square(hull_drop_length); 
        	                    }
            	}
            translate([-20,0,hull_corner_radius])
            	minkowski(){                   
             		translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             				cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	
             			rotate ([0,90,0])
                 			cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   

		        }
		}			
}
//část 1


module 666_1025A(){	
	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    
	
		//základní dělení pro tisk
			intersection(){
    			666_1025();
    			translate([50,-20,-75])                        
       				cube([150-50,150,150]);
		    }
	   //rantl pro slepení vpravo
		intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([150 - hull_wall_thickness,0,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([120,20,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 60, r2 = 70, $fn = 100);
		}
		//odstranění čtverce z vnější strany
			translate([0,0,0])
				intersection () {
        			rotate ([0,90,0])           
                    	rotate_extrude($fn = 100)
                        	rotate([0,0,90])
                            	difference()
                            	{
	                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          square(hull_drop_length); 
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
}	

//část 2

module 666_1025B(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

	//základní dělení pro tisk
	    translate([20,0,0])
    		intersection(){
        				666_1025();
        		translate([150,-20,-150])
           				cube([150,150,300]);
    		}
    
    //rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([170,0,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([140,20,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 60, r2 = 70, $fn = 100);
		//pro lepení - odstranění kusu z díry pro horní držák
			translate ([180+2*hull_wall_thickness+30,-10,0])       
				rotate ([-90,0,0])
            		resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                		airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
		}

        //odstranění čtverce z vnější strany
		translate([20,0,0])
			intersection () {
    			rotate ([0,90,0])           
                	rotate_extrude($fn = 100)
                    	rotate([0,0,90])
                        	difference()
                        	{
                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
	                          square(hull_drop_length); 
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
}


module 666_1025C(){	

	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

	//základní dělení pro tisk
			translate([40,0,0])
    		intersection(){
        				666_1025();
        		translate([300,-20,-150])
           				cube([150,150,300]);
    		}
	

	//rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([340,0,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([320,13,0])
				rotate([0,90,0])		
					cylinder(h = 30,r1 = 60, r2 = 70, $fn = 100);
		//pro lepení - odstranění kusu z díry pro horní držák
			translate ([180+40,-10,0])       
				rotate ([-90,0,0])
            		resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                		airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
		}
		//odstranění čtverce z vnější strany
			translate([40,0,0])
				intersection () {
        			rotate ([0,90,0])           
                    	rotate_extrude($fn = 100)
                        	rotate([0,0,90])
                            	difference()
                            	{
	                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          square(hull_drop_length); 
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
}
	

module 666_1025D(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge


	//základní dělení pro tisk
		translate([60,0,0])
    		intersection(){
        				666_1025();
        		translate([450,-20,-150])
          				cube([150,150,300]);
    		}

	//rantl pro slepení vlevo
	intersection(){
		difference(){
		//pro lepení - čtverec 
			translate([510,0,-hull_z_size])
					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
			translate([490,6,0])
				rotate([0,90,0])		
					cylinder(h = 40,r1 = 40, r2 = 30, $fn = 100);
		}
		//odstranění čtverce z vnější strany
			translate([60,0,0])
				intersection () {
        			rotate ([0,90,0])           
                    	rotate_extrude($fn = 100)
                        	rotate([0,0,90])
                            	difference()
                            	{
	                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                          square(hull_drop_length); 
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
}



//díl jen pro tisk nástavce, zda je správně
module 666_1025ZK1(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness   


    airfoil_thickness = 0030;
    depth = main_tube_outer_diameter*2;
    width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
    height = depth;
    clearance = 0.5; 

    difference (){
      airfoil(naca = airfoil_thickness, L = 170, N=101, h = 5, open = false);
      translate ([hull_wall_thickness,0,0])
            resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*airfoil_thickness/100)- 2*hull_wall_thickness,5], auto=true) 
                airfoil(naca = airfoil_thickness, L = 170, N=101, h = 5, open = false);
    }


    translate ([hull_wall_thickness + 0.5,0,0])
    difference(){
        
        resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*clearance - clearance ,(170*0030/100) - 2*hull_wall_thickness - 2*clearance ,5], auto=true) 
            airfoil(naca = 0030, L = 170, N=101, h = 5, open = false);
        translate([hull_wall_thickness,0,0])       
            resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*clearance  - clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*clearance ,5], auto=true) 
                airfoil(naca = 0030, L = 170, N=101, h = 5, open = false);
    }

}


666_1025();
