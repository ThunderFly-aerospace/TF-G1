//666_1025();
//666_1027();


module hollowing_skeleton_B(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

		intersection () {
                    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness], auto=true)
                 		rotate ([0,90,0])           
                            rotate_extrude($fn = draft ? 50 : 100)
                                rotate([0,0,90])
                                    difference(){
                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 100)); 
                                      square(hull_drop_length); 
                                    }
         			minkowski(){                   
            	 		translate ([0,- hull_y_size - main_tube_outer_diameter/2, -hull_z_size/2 + hull_wall_thickness + hull_corner_radius ])
             		    	//cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);	
                            cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius ]);    
                    		rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
    				}                   
            	}
}

module drop_B(){
    
    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 


    	intersection() {
     		rotate ([0,90,0])           
                rotate_extrude($fn = draft ? 50 : 100)
                    rotate([0,0,90])
                        difference(){
                          polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length , N=draft ? 50 : 100)); 
                          square(hull_drop_length); 
                        }

            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-hull_y_size - main_tube_outer_diameter/2, -hull_z_size/2])
	             		cube ([hull_x_size, hull_y_size,hull_z_size - 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
	        	}
        }
}


module whole_drop_B(){
	
	difference(){
		drop_B();
		    translate ([hull_wall_thickness,0,0])
		hollowing_skeleton_B();
	}
}


module 666_1029(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

    union(){
        difference(){
        	drop_B();

        //hollowing skeleton
        		translate ([hull_wall_thickness,0,0])
                	hollowing_skeleton_B();
            			
            //for printing
        		translate([0,-main_tube_outer_diameter/2,-170/2])
        			cube ([600,15,170]);

            //holes for undercarriage
        		translate ([main_tube_outer_diameter*2 + (main_tube_outer_diameter + 2*main_tube_outer_diameter/5)/2, -main_tube_outer_diameter, -hull_z_size/2-20])         
                    cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 -20])         
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);

                translate([398+main_tube_outer_diameter/2 + (main_tube_outer_diameter/5),-main_tube_outer_diameter,-hull_z_size/2-20])
                    cylinder (h = hull_z_size+40, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
        		translate([398+main_tube_outer_diameter/2 + (main_tube_outer_diameter/5) -main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 -20])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);
        	//hollow front
        		translate([-10,-main_tube_outer_diameter/2-3.5,-56/2])
        			cube ([47.50+2,10,56]);	
        //šrouby
        //část A
        translate([40,-30,hull_z_size/2 - 10])
        	rotate([-110,0,0])
        		cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([40,-50,-hull_z_size/2])
        	rotate([-70,0,0])
        		cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        //final difference
        }
        //lem
           	intersection(){

           		//dno
    				difference(){
    					translate([0,-main_tube_outer_diameter/2,-hull_z_size/2])		
    						cube([hull_x_size, hull_wall_thickness, hull_z_size]);

        	//hollow front
        		translate([-10,-main_tube_outer_diameter/2-3.5,-56/2])
        			cube ([47.50+2,10,56]);	

        	
            //for tube in back
        				translate ([hull_x_size-70,-6,0])
        					rotate ([0,90,0])
        						cylinder (h = 80, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

    					translate ([hull_x_size-65,-16,16.5])
    						rotate([0,100,0])
    							cube([hull_wall_thickness*5,30,30]);
    					translate ([hull_x_size-65,-15,-12.5])
    						rotate([0,80,0])
    						cube([hull_wall_thickness*5,30,30]);

    		
    				//kapka pro kapkovitý tvar
    					translate ([hull_wall_thickness+2.5,0,0])
                	intersection () {
                        resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness-5, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5], auto=true)
                     		rotate ([0,90,0])           
                                rotate_extrude($fn = draft ? 50 : 100)
                                    rotate([0,0,90])
                                        difference()
                                        {

                                          polygon(points = airfoil_data(naca = hull_airfoil_thickness, L = hull_drop_length, N = draft ? 50 : 100)); 
                                          square(hull_drop_length); 
                                        }
                        translate([0,0,hull_corner_radius])
                     	minkowski(){                   
                         	translate ([2.5,-(main_tube_outer_diameter/2)-2.5,-hull_z_size/2 + hull_wall_thickness+2.5])
                         		cube ([hull_x_size-5,hull_y_size - hull_wall_thickness-5, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius - 5]);
                         		rotate ([0,90,0])
                             		cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
                		}                   
                	}
    				//holes for undercarriage            
    	            translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2,-main_tube_outer_diameter, -hull_z_size/2 - 20])         
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size + 40]);
        			translate([398 + main_tube_outer_diameter / 2 + (main_tube_outer_diameter / 5) - main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 - 20])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size + 40]);
    				//difference
    				}		
    			//odstranění dna z vnější strany
    				translate([0,0,0])
    					drop_B();
    		//intersection
    		}
    //final union
    }
//final module
}

//část 1
module 666_1029A(){

    union(){
    	
    	difference(){
    	//základní dělení pro tisk
    				intersection(){
            			666_1029();
            			translate([0,-140,-100]) 
               				cube([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,150,300]);
    		    	}
    	//díry pro šrouby
    	}

    	//rantl pro slepení vpravo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2 - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    		//	translate([75,-25,0])
    		//		rotate([0,90,0])		
    		//			cylinder(h = 40,r1 = 60, r2 = 60, $fn = draft ? 50 : 100);
    		}
    		//odstranění čtverce z vnější strany
    		drop_B();
    	}
    //konec union
    }
//final module
}

//část 2
module 666_1029B(){
    union(){
    	difference(){
    	//základní dělení pro tisk
    			translate([20,0,0])	
    				intersection(){
            			666_1029();
            			translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-140,-100])                        
               				cube([ (398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - ( + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2) - main_tube_outer_diameter - 150 ,150,300]);
    		    	}
    	}
    	//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2 +20 + ((398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - ( + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2) - main_tube_outer_diameter - 150 ) - hull_wall_thickness,-4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([250,-25,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r1 = 60, r2 = 60, $fn = draft ? 50 : 100);
    		}

    		//odstranění čtverce z vnější strany
    		translate([20,0,0])
    			drop_B();
    	}
    //konec union
    }
//final module
}

//část 3
module 666_1029C(){
    union(){	
    	translate([30,0,0])
    		intersection(){
    			666_1029();
            	translate([150 + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-140,-75])                        
            	   cube([150,150,150]);

    		}
    			//rantl pro slepení vpravo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([150 + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2 + 10 + 20,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([250,-25,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r1 = 60, r2 = 60, $fn = draft ? 50 : 100);
    		}

    		//odstranění čtverce z vnější strany
    		translate([30,0,0])
    			drop_B();
    	}		

    //final union
    }
//final module 
}

//část 4
module 666_1029D(){
    union(){    	
    	difference(){
    	//základní dělení pro tisk
    			translate([40,0,0])	
    				intersection(){
            			666_1029();
            			translate([ (398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - main_tube_outer_diameter,-140,-100])                        
               				cube([150,150,300]);
    		    	}
    	}

    	//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([(398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - main_tube_outer_diameter + 20 + 20,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    		//	translate([410,-10,0])
    		//		rotate([0,90,0])		
    		//			cylinder(h = 40,r1 = 45, r2 = 45, $fn = draft ? 20 : 60);
    		}
    		//odstranění čtverce z vnější strany
    			translate([40,0,0])
    				drop_B();
    	}
    //konec union
    }
//final module
}


666_1029A();

666_1029B();

666_1029C();

666_1029D();

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <666_1027.scad>