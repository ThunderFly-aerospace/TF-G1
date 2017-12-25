module hollowing_skeleton()
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness 

    intersection () {
    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness], auto=true)
            rotate ([0,90,0])           
            rotate_extrude($fn = draft ? 50 : 100)
                rotate([0,0,90])
                    difference()
                    {
                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 100)); 
                      square(hull_drop_length); 
                    }

      translate([0,0,hull_corner_radius])
        minkowski(){                   
            translate ([0,-(main_tube_outer_diameter/2),-hull_z_size/2 + hull_wall_thickness])
                cube ([hull_x_size,hull_y_size - hull_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);
                rotate ([0,90,0])
                    cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
          }                   
    }
}

module drop()
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness 

	intersection () {
    	rotate ([0,90,0])           
        	rotate_extrude($fn = draft ? 50 : 100)
                    rotate([0,0,90])
                        difference()
                        {
	                        polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
    	                    square(hull_drop_length); 
        	            }
            		
        translate([0,0,hull_corner_radius])
          	minkowski(){                   
             	translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
             			cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
             	  	rotate ([0,90,0])
                 		cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
		    }
	}
}

module whole_drop(){
	difference(){
		drop();
		translate ([hull_wall_thickness,0,0])
		hollowing_skeleton();
	}
}


module 666_1025(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness   

clearance = 0.5;
   
union(){
    difference(){
        intersection () {
            union(){
        		rotate ([0,90,0])           
                    rotate_extrude($fn = draft ? 50 : 100)
                        rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N= draft ? 50 : 100)); 
                              square(hull_drop_length); 
                              
                            }

                // 666_1032 part holder 

                translate([180,0,0]) 
                    rotate ([-90,0,0])
                        translate ([hull_wall_thickness,0,0])
                            resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*clearance - clearance ,(170*0030/100) - 2*hull_wall_thickness - 2*clearance ,200], auto=true) 
                                airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = draft ? 50 : 100, open = false);

            }
            translate([0,0,hull_corner_radius])
	            minkowski(){                   
	             	translate ([0,-(main_tube_outer_diameter/2)+1, -hull_z_size/2])
	             		cube ([hull_x_size, hull_y_size,hull_z_size - 2*hull_corner_radius]);
	             	
	             		rotate ([0,90,0])
	                 		cylinder (h = 1, r = hull_corner_radius);                   

	        	}

        }   

        //hollowing skeleton
    		translate ([hull_wall_thickness,0,0])
            	hollowing_skeleton();

            //for front part
    		translate ([-2,-1 - main_tube_outer_diameter/2,-25])
    				cube ([52,hull_y_size+10,50]);

        //for tube in back
    		translate ([hull_x_size-70,0,0])
    			rotate ([0,90,0])
    				cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 20 : 50);
    					    
        //for rotor pilon
	       	translate ([180+2*hull_wall_thickness,-10,])       
				rotate ([-90,0,0])
                    resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*clearance  - clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*clearance ,200], auto=true) 
                        airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
        			
        //for printing
    		translate([0,-main_tube_outer_diameter/2-4.90,-170/2])
    			cube ([600,5,170]);

    		translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
    			cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);	
    

    	//šrouby
    		//část AA
    		translate([30,-main_tube_outer_diameter/4,hull_z_size/2-30])
    			rotate([0,-45,0])
    				cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    
    		translate([5,-main_tube_outer_diameter/4,-hull_z_size/2])
    			rotate([0,45,0])
    				cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    		//část A
    		translate([50+50,-main_tube_outer_diameter/4,-hull_z_size/2-15])
    				cylinder(h = hull_z_size+30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    		//část B
    		translate([50+100+75,-main_tube_outer_diameter/4,-hull_z_size/2-15])
    				cylinder(h = hull_z_size+30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    		//část C
    		translate([50+100+150+60,-main_tube_outer_diameter/4,+50])
    			rotate([0,90-beta,0])	
    				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
    		translate([50+100+150+60,-main_tube_outer_diameter/4,-50])
    			rotate([0,90+beta,0])	
    				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    		//část D		
    		translate([50+100+150+150+35,-main_tube_outer_diameter/4,0])
    			rotate([0,90-beta,0])
    				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    		translate([50+100+150+150+35,-main_tube_outer_diameter/4,0])
    			rotate([0,90+beta,0])
    				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);



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
    						cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

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
                         		cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
            		}                   
            	}

				}		

			//odstranění dna z vnější strany
				translate([0,0,0])
					drop();
		}

//stěna Z+
       	
       	intersection(){

       		//čtverec
				translate([0,-main_tube_outer_diameter/2,25])		
						cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

			//odstranění čtverce z vnější strany
				translate([0,0,0])
					drop();
		}

//stěna Z-

		intersection(){
       		//čtverec
				translate([0,- main_tube_outer_diameter/2,-25 - hull_wall_thickness])		
						cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

			//odstranění čtverce z vnější strany
				translate([0,0,0])
					drop();
		}






    //nápis
    translate([hull_x_size/3,0,hull_z_size/2])
      text("TF-G1", size = 20,font = "Liberation Sans");

    translate([hull_x_size/3,0,-hull_z_size/2])
      rotate([0,180,0]) text("TF-G1", size = 20,font = "PT Sans");
//konec union
}


//konec model
}


module 666_1025AA(){

		beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

//část 0
	//základní dělení pro tisk
			
difference(){
		union(){	
			translate([-20,0,0])
				intersection(){
    				666_1025();
    					translate([0,-20,-75])                        
       						cube([50,150,150]);
       			}

       	//rantl pro slepení vpravo
		
		intersection(){
		//pro lepení - čtverec 
			union(){
			
				difference(){
			
					translate([30- hull_wall_thickness,0,-hull_z_size])
							cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
			
					translate([20,0,0])
						rotate([0,90,0])
							cylinder(h = 20, r1 = 60, r2 = 60, $fn = draft ? 50 : 100);
				
					//trojúhelník Z+
					translate([30 - hull_wall_thickness-0.5,4.5,42])
						rotate([45,0,0])		
							cube([2*hull_wall_thickness,20,30]);
						
					//trojúhelník Z+
					translate([30 - hull_wall_thickness-0.5,-1,-75])
						rotate([45,0,0])		
							cube([2*hull_wall_thickness,30,30]);
						

				}		
			
			//pro rovnou hranu rantlu
			translate([30 - hull_wall_thickness,54,-25 - 2*hull_wall_thickness])
					cube ([hull_wall_thickness,8,25 + 25 + 3*hull_wall_thickness]);		
			}
		
		//odstranění čtverce z vnější strany
		translate([-20,0,0])
				drop();
		
		}
		}
	
	//díry pro zámky
	translate([-20,0,0])
		union(){
			intersection(){
				whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52,68,0])
					rotate([0,0,90-beta])
						cube([hull_wall_thickness,15,10]);
			    //čtverec pro zámek Z+
				translate([49,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*2,15,10]);
				//čtverec pro zámek Z-
				translate([49,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*2,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky
		}	

//final difference
}

//final module
}
//část 1


module 666_1025A(){	
	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    
	
difference(){
union(){	
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
					cylinder(h = 40,r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
		
		}
		//odstranění čtverce z vnější strany
			translate([0,0,0])
				drop();
		}
		
		//zámky
		union(){
			intersection(){
				whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52,68,0])
					rotate([0,0,90-beta])
						cube([hull_wall_thickness,15,10]);
			    //čtverec pro zámek Z+
				translate([49,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*2,15,10]);
				//čtverec pro zámek Z-
				translate([49,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*2,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky
		}	

//final union
}

	//zámky odečtení
	translate([-20,0,0])	
		union(){
			intersection(){
				translate([20,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52+100 + 22 - hull_wall_thickness*2,hull_z_size/2+15,-10])
					rotate([0,0,90-beta])
						cube([hull_wall_thickness*3,20,20]);
			    //čtverec pro zámek Z+
				translate([49 + 100 + 20 - hull_wall_thickness,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,10]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky
		}

//final difference
}

//final module
}	

//část 2

module 666_1025B(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

union(){	
	//základní dělení pro tisk
	    translate([20,0,0])
    		intersection(){
        				666_1025();
        		translate([150,-20,-150])
           				cube([150,150,300]);
    		}
    
    //rantl pro slepení vlevo
	//intersection(){
	//	difference(){
		//pro lepení - čtverec 
	//		translate([170,0,-hull_z_size])
	//				cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
		//pro lepení - odstranění čtverce válcem
	//		translate([140,20,0])
	//			rotate([0,90,0])		
	//				cylinder(h = 40,r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
		//pro lepení - odstranění kusu z díry pro horní držák
			//translate ([180+2*hull_wall_thickness+30,-10,0])       
			//	rotate ([-90,0,0])
            //		resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
              //  		airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
	//	}

        //odstranění čtverce z vnější strany
	//	translate([20,0,0])
	//		drop();
	//}



	//zámky vlevo
		union(){
			intersection(){
				translate([20,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52+100 + 22 - hull_wall_thickness*2,hull_z_size/2+15,-10])
					rotate([0,0,90-beta])
						cube([hull_wall_thickness*3,20,20]);
			    //čtverec pro zámek Z+
				translate([49 + 100 + 20 - hull_wall_thickness,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,10]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky vlevo
		}

	//zámky vpravo
		union(){
			intersection(){
				translate([20,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52+100 + 22 - hull_wall_thickness*2 + 150 - 3,hull_z_size/2,-50])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);
			    translate([52+100 + 22 - hull_wall_thickness*2 + 150 - 3,hull_z_size/2,25])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);


			    //čtverec pro zámek Z+
				translate([49 + 100 + 20 - hull_wall_thickness + 150 + hull_wall_thickness,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,10]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness + 150 + hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky vpravo
		}




//final union
}
//final module
}


module 666_1025C(){	

	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

difference(){	
	union(){
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
					cylinder(h = 30,r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
		//pro lepení - odstranění kusu z díry pro horní držák
			translate ([180+40,-10,0])       
				rotate ([-90,0,0])
            		resize([170 - hull_wall_thickness*2 - trailing_wall*hull_wall_thickness*2,(160*0030/100)- 2*hull_wall_thickness,210], auto=true) 
                		airfoil(naca = 0030, L = 170, N=101, h = 200, open = false);
		}
		//odstranění čtverce z vnější strany
			translate([40,0,0])
				drop();
	}

	//zámky vpravo
	union(){
			intersection(){
				translate([40,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness,hull_z_size/2-40,-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);
		
			    //čtverec pro zámek Z+
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness - hull_wall_thickness,2,hull_z_size/2-40])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness - hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky vpravo
		}

//final union
}
	

//zámky vpravo odečtení
	
//zámky vpravo
	translate([20,0,0])	
		union(){
			intersection(){
				translate([20,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([52+100 + 22 - hull_wall_thickness*2 + 150 - 3,hull_z_size/2,-50])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);
			    translate([52+100 + 22 - hull_wall_thickness*2 + 150 - 3,hull_z_size/2,25])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);


			    //čtverec pro zámek Z+
				translate([49 + 100 + 20 - hull_wall_thickness + 150 + hull_wall_thickness,2,hull_z_size/2-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,10]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness + 150 + hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky vpravo
		}


}
//final module
}
	

module 666_1025D(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge

difference(){
	union(){
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
					cylinder(h = 40,r1 = 40, r2 = 30, $fn = draft ? 50 : 100);
		}
		//odstranění čtverce z vnější strany
			translate([60,0,0])
				drop();
	}

	//final union
	}

//zámky vpravo odečtení
	translate([20,0,0])
	union(){
			intersection(){
				translate([40,0,0])
					whole_drop();	
			union(){
    			//čtverec pro zámek horní
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness,hull_z_size/2-40,-10])
					rotate([0,0,0])
						cube([hull_wall_thickness*3,20,20]);
		
			    //čtverec pro zámek Z+
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness - hull_wall_thickness,2,hull_z_size/2-40])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
				//čtverec pro zámek Z-
				translate([49+100+20 - hull_wall_thickness + 150 + 20 + 150 +  2 * hull_wall_thickness - hull_wall_thickness,2,-hull_z_size/2])
					rotate([0,0,0])
						cube([hull_wall_thickness*4,15,40]);
			//union
			}	
			//intersection
			}
		//union zámky vpravo
		}


//final difference
}	
//final module
}


//666_1025();

666_1025AA();

666_1025A();

666_1025B();

666_1025C();

666_1025D();


use <./lib/naca4.scad>
include <../Parameters.scad>
