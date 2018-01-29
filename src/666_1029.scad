/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;


module hollowing_skeleton_B(shell_thickness = hull_wall_thickness, draft)
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

		intersection () {
                    resize([hull_drop_length - shell_thickness - trailing_wall* shell_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*shell_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*shell_thickness], auto=true)
                 		rotate ([0,90,0])           
                            rotate_extrude($fn = draft ? 50 : 100)
                                rotate([0,0,90])
                                    difference(){
                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N = draft ? 50 : 200)); 
                                      square(hull_drop_length); 
                                    }
         			minkowski(){                   
            	 		translate ([0,- hull_y_size - main_tube_outer_diameter/2, -hull_z_size/2 + shell_thickness + hull_corner_radius ])
             		    	//cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);	
                            cube ([hull_x_size,hull_y_size - shell_thickness, hull_z_size - 2*shell_thickness - 2*hull_corner_radius ]);    
                    		rotate ([0,90,0])
                 				cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
    				}                   
        }
}

module drop_B(draft = true){
    
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


module drop_skin_B(draft){
	
	difference(){
		drop_B(draft);
		    translate ([hull_wall_thickness,0,0])
		hollowing_skeleton_B(hull_wall_thickness, draft);
	}
}


module 666_1029(draft){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    union(){
        difference(){
        	drop_B(draft);

        //hollowing skeleton
        		translate ([hull_wall_thickness,0,0])
                	hollowing_skeleton_B(hull_wall_thickness, draft);
            			
            //for printing
        		translate([0,-main_tube_outer_diameter/2,-170/2])
        			cube ([600,15,170]);

            //holes for undercarriage
        		translate ([main_tube_outer_diameter*2 + (main_tube_outer_diameter + 2*main_tube_outer_diameter/5)/2, -main_tube_outer_diameter, -hull_z_size/2-20])         
                    cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 -20])         
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);

                translate([398+main_tube_outer_diameter/2 + (main_tube_outer_diameter/5),-main_tube_outer_diameter,-hull_z_size/2-20])
                    cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
        		translate([398+main_tube_outer_diameter/2 + (main_tube_outer_diameter/5) -main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 -20])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size+40]);
        	//hollow front
                translate ([-2,-1 - main_tube_outer_diameter/2,- width_of_engine_holder/2])
                    cube([52,hull_y_size+10,width_of_engine_holder]);

        //šrouby
		//A
        	translate([(bottom_cover_division[0] + bottom_cover_division[1])/15,-main_tube_outer_diameter*(3/4), -hull_z_size/2])
            	rotate([0,45,0])
               		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        mirror([0,0,1])
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15, -main_tube_outer_diameter*(3/4), -hull_z_size/2])
                rotate([0,45,0])
            		cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);


	 	//D
        	union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
        		rotate([0,90-beta,0])	
        			cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        mirror([0,0,1])
            union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        //E		
        	translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
        		rotate([0,90-beta,0])	
        			cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        mirror([0,0,1])	
            translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
 

        //final difference
        }
        //lem
           	intersection(){

           		//dno
    				difference(){
    					translate([0,-main_tube_outer_diameter/2,-hull_z_size])		
    						cube([hull_x_size, hull_wall_thickness, hull_z_size*2]);

        	//hollow front
                        translate ([-2,-1 - main_tube_outer_diameter/2,- width_of_engine_holder/2])
                            cube([52,hull_y_size+10,width_of_engine_holder]);

        	
            //for tube in back
        				translate ([hull_x_size-70,-6,0])
        					rotate ([0,90,0])
        						cylinder (h = 80, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

    					translate ([hull_x_size-35,-16,10])
    						rotate([0,190,0])
    							cube([40,30,hull_wall_thickness*5]);
    					translate ([hull_x_size-75,-16,-17])
    						rotate([0,-10,0])
                                cube([40,30, 5*hull_wall_thickness]);

    		
    				//kapka pro kapkovitý tvar
                        translate([ribbon_width,ribbon_width/2,0])
                                hollowing_skeleton_B(ribbon_width, draft);
    				//holes for undercarriage            
    	                translate ([main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2- main_tube_outer_diameter/2,-main_tube_outer_diameter, -hull_z_size/2 - 20])         
                                cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size + 40]);
                        translate([398 + main_tube_outer_diameter / 2 + (main_tube_outer_diameter / 5) - main_tube_outer_diameter/2, -main_tube_outer_diameter, -hull_z_size/2 - 20])
                                cube ([main_tube_outer_diameter, main_tube_outer_diameter, hull_z_size + 40]);
    				//difference
    				}		
    			//odstranění dna z vnější strany
    					drop_B(draft);
    		//intersection
    		}
    //final union
    }
//final module
}


/*
//
module 666_1029_part(part_number, draft){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    division_bottom_position = bottom_cover_division[part_number];
    prevision_bottom_position = bottom_cover_division[part_number - 1];

    part_lenght_bottom = division_bottom_position - prevision_bottom_position;
    lock_width_bottom = 10;
    part_flip_bottom = 4; //část od které se otáčí pořadí zámků.

    if (part_number < part_flip_bottom) {
        difference(){
            union(){
                //základní dělení pro tisk
                intersection(){
                    666_1029();
                    translate([previous_bottom_division + global_clearance/2, -140, -150])
                        cube([part_lenght_bottom - global_clearance/2, 150, 300]);
                }

                //zámky přidané
                union(){
                    intersection(){
                        drop_skin_B();
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_bottom_division - 2*hull_wall_thickness, - main_tube_outer_diameter, - lock_width_bottom/2])
                                    cube([hull_wall_thickness*3, hull_y_size, lock_width_bottom]);
                            //čtverec pro zámek Z+
                            translate([previous_bottom_division - 2*hull_wall_thickness, - 9*hull_wall_thickness, main_tube_outer_diameter ])
                                    cube([hull_wall_thickness*3, lock_width_bottom, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([previous_bottom_division - 2*hull_wall_thickness, - 9*hull_wall_thickness,- hull_z_size - main_tube_outer_diameter])
                                    cube([hull_wall_thickness*3, lock_width_bottom, hull_z_size]);
                        //union
                        }
                    //intersection        
                    }
                //union zámky    
                }
            //final union    
            }
        
        //zámky odečtení


        }
    }
} 
//
*/



module 666_1029A(draft){

    union(){
    	
    	//základní dělení pro tisk
    				intersection(){
            			666_1029();
            			translate([bottom_cover_division[0],-140,-150]) 
               				//cube([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,150,300]);
               				%cube([bottom_cover_division[1],150,300]);
    		    	}
    	

    	//rantl pro slepení vpravo
    	intersection(){
    		difference(){
    			//pro lepení - čtverec 
    			//translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2 - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    			translate([bottom_cover_division[1] - hull_wall_thickness,- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    			//pro lepení - odstranění čtverce válcem
    			translate([bottom_cover_division[1] - 35,-25,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r = 60, $fn = draft ? 50 : 100);
    		}
    		
    		//odstranění čtverce z vnější strany
    		drop_B();
    	}
    
    //konec union
    }
//final module
}


module 666_1029B(draft){

translate([20,0,0])	

   union(){
    	//základní dělení pro tisk
    				intersection(){
            			666_1029();
            			//translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-140,-100])                        
            			translate([bottom_cover_division[1],-140,-100])                        
               				//cube([ (398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - ( + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2) - main_tube_outer_diameter - 150 ,150,300]);
               					cube([bottom_cover_division[2] - bottom_cover_division[1],150,300]);
    		    	}
    	
    	//rantl pro slepení vpravo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			//translate([main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2 +20 + ((398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - ( + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2) - main_tube_outer_diameter - 150 ) - hull_wall_thickness,-4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    			translate([bottom_cover_division[2] - 4*hull_wall_thickness,-4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness*4, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([bottom_cover_division[2]-20,-25,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r = 60, $fn = draft ? 50 : 100);
    		//šroub + matka
    		translate([bottom_cover_division[2] - 20,-main_tube_outer_diameter,-hull_z_size/2 + 8])
    			rotate([0,90,0])	
    				union(){
    						cylinder (h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    				translate([0,0,14.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				translate([0,0,35])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				}
    		//šroub + matka
    		translate([bottom_cover_division[2] - 20,-main_tube_outer_diameter,hull_z_size/2-8])
    			rotate([0,90,0])	
    				union(){
    						cylinder (h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    				translate([0,0,14.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				translate([0,0,22.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
	    			}

	    	//difference
    		}

    		//odstranění čtverce z vnější strany
    		drop_B();
    	}
    
    //konec union
    }
//final module
}

module 666_1029C(draft){

translate([40,0,0])
	 
	    union(){	
	    	//základní dělení pro tisk
	    			intersection(){
    					666_1029();
            			//translate([150 + main_tube_outer_diameter + main_tube_outer_diameter*2+(main_tube_outer_diameter+2*main_tube_outer_diameter/5)/2,-140,-75])                        
            			translate([bottom_cover_division[2],-140,-75])                        
            	  				cube([bottom_cover_division[3] - bottom_cover_division[2],150,150]);
    				}
    	//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([bottom_cover_division[2],- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([4*hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([bottom_cover_division[2] - 20,-25,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r = 60, $fn = draft ? 50 : 100);
    		//šroub + matka
    		translate([bottom_cover_division[2] - 20,-main_tube_outer_diameter,-hull_z_size/2 + 8])
    			rotate([0,90,0])	
    				union(){
    						cylinder (h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    				translate([0,0,14.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				translate([0,0,22.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				}
    		//šroub + matka
    		translate([bottom_cover_division[2] - 20,-main_tube_outer_diameter,hull_z_size/2-8])
    			rotate([0,90,0])	
    				union(){
    						cylinder (h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    				translate([0,0,14.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				translate([0,0,22.5])	
    						cylinder (h = Nut_height_M3*2, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    				}

    		//difference
    		}

    		//odstranění čtverce z vnější strany
    		drop_B();
    	}		

    //final union
    }
//final module 
}

module 666_1029D(draft){

translate([60,0,0])	
    
    union(){    	
    	//základní dělení pro tisk
    				intersection(){
            			666_1029();
            			//translate([ (398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - main_tube_outer_diameter,-140,-100])                        
            			translate([bottom_cover_division[3],-140,-100])                        
               				cube([bottom_cover_division[4] - bottom_cover_division[3],150,300]);
    		    	}

    	//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([bottom_cover_division[3],- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([bottom_cover_division[3] - 20,-15,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r = 40, $fn = draft ? 20 : 60);
    		}
    		//odstranění čtverce z vnější strany
    				drop_B();
    	}
    //konec union
    }
//final module
}


module 666_1029E(draft){

translate([80,0,0])	
    
    union(){    	
    	//základní dělení pro tisk
    				intersection(){
            			666_1029();
            			//translate([ (398+main_tube_outer_diameter/2+(main_tube_outer_diameter/5)) - main_tube_outer_diameter,-140,-100])                        
            			translate([bottom_cover_division[4],-140,-100])                        
               				cube([bottom_cover_division[5] - bottom_cover_division[4],150,300]);
    		    	}
		//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([bottom_cover_division[4],- 4*hull_y_size - main_tube_outer_diameter + 5,-hull_z_size])
    				cube([hull_wall_thickness, hull_y_size*4, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([bottom_cover_division[4] - 20,-15,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r = 20, $fn = draft ? 20 : 60);
    		}
    		//odstranění čtverce z vnější strany
    				drop_B();
		}
	//final union
	}
//final module
}

//666_1029(draft);


666_1029A(draft);
/*
666_1029B(draft);
666_1029C(draft);
666_1029D(draft);
666_1029E(draft);
*/

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <666_1027.scad>