
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;

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
            translate ([0,- main_tube_outer_diameter/2,-hull_z_size/2 + hull_wall_thickness])
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
                                resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance - global_clearance ,(170*0030/100) - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                                    airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = draft ? 50 : 100, open = false);

                }
                
                translate([0,0,hull_corner_radius])
    	            minkowski(){                   
    	             	translate ([0,-(main_tube_outer_diameter/2)-hull_wall_thickness, -hull_z_size/2])
    	             		cube ([hull_x_size, hull_y_size,hull_z_size - 2*hull_corner_radius]);
    	             	
    	             		rotate ([0,90,0])
    	                 		cylinder (h = 1, r = hull_corner_radius);                   

    	        	}

            }   

            //hollowing skeleton
        		translate ([hull_wall_thickness,,0])
                	hollowing_skeleton();
            

                //for front part
        		translate ([-2,-1 - main_tube_outer_diameter/2 - hull_wall_thickness,-25])
        				cube ([52,hull_y_size+10,50]);

            //for tube in back
        		translate ([hull_x_size-70,0,0])
        			rotate ([0,90,0])
        				cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 20 : 50);
        					    
            //for rotor pilon
    	       	translate ([180+2*hull_wall_thickness,-10,0])       
    				rotate ([-90,0,0])
                        resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                            airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
            			
            //for printing
        		translate([0,-main_tube_outer_diameter/2-4.90,-170/2])
        			cube ([600,5,170]);

        		translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])		
        			cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);	
        

        	//šrouby
        		//část A
        		translate([top_cover_division[0]-20,-main_tube_outer_diameter/4,hull_z_size/2-30])
        			rotate([0,-45,0])
        				cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        		translate([top_cover_division[0]-45,-main_tube_outer_diameter/4,-hull_z_size/2])
        			rotate([0,45,0])
        				cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		//část B
        		translate([(top_cover_division[1] - top_cover_division[0])/2 + top_cover_division[0],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		//část C
        		translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		
        		//část D	
        		translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);


        		//část E
        		translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,+50])
        			rotate([0,90-beta,0])	
        				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        		translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,-50])
        			rotate([0,90+beta,0])	
        				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		//část F		
        		translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
        			rotate([0,90-beta,0])
        				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
        			rotate([0,90+beta,0])
        				cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        	    //nápis
        		translate([hull_x_size/4 + 35, hull_y_size/5, hull_z_size/2 - 0.3])
            		linear_extrude(hull_wall_thickness) 
                		text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");
			
                //nápis

                translate([hull_x_size/4 + 35, hull_y_size/5, -hull_z_size/2 + 0.3])
                    rotate([0,180,0])
                        linear_extrude(hull_wall_thickness) 
                            text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");

        //konec difference
        }

            //lem
           	union(){
           	intersection(){

           		//dno
    				difference(){
    					translate([0,-main_tube_outer_diameter/2+0.1,-hull_z_size/2])		
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
    					translate ([2.5 + hull_wall_thickness,0,0])
                	intersection () {
                        resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness-5-2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-2*hull_wall_thickness], auto=true)
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
    					hollowing_skeleton();
    					//drop();
    		}
    	}
           	
       	intersection(){
            union(){

                //přední stěna Z+
       		    //čtverec
				translate([0,-main_tube_outer_diameter/2+0.1,25])		
					cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

                //přední stěna Z-
       		    //čtverec
				translate([0,- main_tube_outer_diameter/2+0.1,-25 - hull_wall_thickness])		
					cube([50 - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

                //pro rovnou horní hranu předního lemu
                translate([top_cover_division[1] - hull_wall_thickness,54, -25 - 2*hull_wall_thickness])
                    cube ([hull_wall_thickness,hull_y_size,25 + 25 + 3*hull_wall_thickness]);

                // lem pro výztuhu a slepení dílu A    
                difference(){
                    translate([top_cover_division[1] - hull_wall_thickness, 0, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
            
                    translate([top_cover_division[1]-10,0,0])  // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])
                            cylinder(h = 20, r = 60, $fn = draft ? 50 : 100);
                
                    //trojúhelník Z+
                    translate([top_cover_division[1] - hull_wall_thickness-0.5,4.5,42])
                        rotate([45,0,0])        
                            cube([2*hull_wall_thickness,20,30]);
                        
                    //trojúhelník Z+
                    translate([top_cover_division[1] - hull_wall_thickness-0.5,-1,-75])
                        rotate([45,0,0])        
                            cube([2*hull_wall_thickness,30,30]);
                        

                }       
                
                // lem pro výztuhu a lepení části B    
                difference(){
                    //pro lepení - čtverec 
                    translate([top_cover_division[2] - hull_wall_thickness,0,-hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                    //pro lepení - odstranění čtverce válcem
                    translate([top_cover_division[2]-30,20,0])  // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])        
                            cylinder(h = 40, r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
                
                }

                // lem pro výztuhu a lepení části C    
                difference(){
                    //pro lepení - čtverec 
                    translate([top_cover_division[3] - hull_wall_thickness,0,-hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                    //pro lepení - odstranění čtverce válcem
                    translate([top_cover_division[3]-20,20,0])   // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])        
                            cylinder(h = 40,r = 60, $fn = draft ? 50 : 100);
                    //pro lepení - odstranění kusu z díry pro horní držák
                    translate ([180+2*hull_wall_thickness,-10,0])       
                        rotate ([-90,0,0])
                            resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                                airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
                }

                // lem pro výztuhu a lepení části D    
                difference(){
                    //pro lepení - čtverec 
                    translate([top_cover_division[3], 0, -hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                    //pro lepení - odstranění čtverce válcem
                    translate([top_cover_division[3] - 20,20,0])  // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])        
                            cylinder(h = 40,r = 60, $fn = draft ? 50 : 100);
                    //pro lepení - odstranění kusu z díry pro horní držák
                    translate ([180+2*hull_wall_thickness,-10,0])       
                        rotate ([-90,0,0])
                            resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                                airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
                    //final difference
                }

                // lem pro výztuhu a lepení části E    
                difference(){
                //pro lepení - čtverec 
                    translate([top_cover_division[4], 0, -hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                //pro lepení - odstranění čtverce válcem
                    translate([top_cover_division[4]-20,8,0])  // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])        
                            cylinder(h = 30, r = 40, $fn = draft ? 50 : 100);
                }
            }     
	        //odstranění přesahů z vnější strany
			translate([hull_wall_thickness,0,0])
				drop();
		}
    //konec union
    }
//konec model celek
}


//část A

module 666_1025A(){

	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    


translate([-20,0,0])				
    difference(){
    
    		union(){
    			//základní dělení pro tisk
    				intersection(){
        				666_1025();
        					translate([0,-20,-75])                        
           						cube([top_cover_division[0],150,150]);
           			}

           	    //rantl pro slepení vpravo
        		intersection(){
        		//pro lepení - čtverec 
        			union(){
        			
        				difference(){
        					translate([top_cover_division[0]- hull_wall_thickness,0,-hull_z_size])
	       							cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
        			
        					translate([top_cover_division[0]-10,0,0])
        						rotate([0,90,0])
        							cylinder(h = 20, r1 = 60, r2 = 60, $fn = draft ? 50 : 100);
        				
        					//trojúhelník Z+
        					translate([top_cover_division[0] - hull_wall_thickness-0.5,4.5,42])
        						rotate([45,0,0])		
        							cube([2*hull_wall_thickness,20,30]);
        						
        					//trojúhelník Z+
        					translate([top_cover_division[0] - hull_wall_thickness-0.5,-1,-75])
        						rotate([45,0,0])		
        							cube([2*hull_wall_thickness,30,30]);
        						

        				}		
        			
        			}
        		
        		//odstranění čtverce z vnější strany
        		translate([0,-hull_wall_thickness,0])
        				drop();
        		
        		}
    		}
    	
    	//díry pro zámky
    		//zámky
        		union(){
        			intersection(){
        				whole_drop();	
            			union(){
                			//čtverec pro zámek horní
            				translate([top_cover_division[0],hull_y_size/2+7,0])
            					rotate([0,0,90-beta])
            						cube([hull_wall_thickness*4 + global_clearance, 15 + global_clearance, 10 + global_clearance]);
            			    //čtverec pro zámek Z+
            				translate([top_cover_division[0] - 2*hull_wall_thickness,2,hull_z_size/2-hull_corner_radius])
            					rotate([0,0,0])
            						cube([hull_wall_thickness*4 + global_clearance, 15 + global_clearance, 10 + global_clearance]);
            				//čtverec pro zámek Z-
            				translate([top_cover_division[0] - 2*hull_wall_thickness,2,- hull_z_size/2 - hull_corner_radius])
                 					cube([hull_wall_thickness*4 + global_clearance, 15 + global_clearance, 40 + global_clearance]);
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

//část B

module 666_1025B(){	
	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

	
    difference(){
        union(){	
        		//základní dělení pro tisk
        			intersection(){
            			666_1025();
            			translate([top_cover_division[0],-20,-75])                        
               				cube([top_cover_division[1] - top_cover_division[0],150,150]);
        		    }
        	   //rantl pro slepení vpravo
        		intersection(){
            		difference(){
            		//pro lepení - čtverec 
            			translate([top_cover_division[1] - hull_wall_thickness,0,-hull_z_size])
            					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
            		//pro lepení - odstranění čtverce válcem
            			translate([top_cover_division[1]-30,20,0])
            				rotate([0,90,0])		
            					cylinder(h = 40, r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
            		
            		}
        		//odstranění čtverce z vnější strany
        			translate([0,-hull_wall_thickness,0])
        				drop();
        		}
        		
        		//zámky
        		union(){
        			intersection(){
        				whole_drop();	
            			union(){
                			//čtverec pro zámek horní
            				translate([top_cover_division[0],hull_y_size/2+7,0])
            					rotate([0,0,90-beta])
            						cube([hull_wall_thickness*4, 15, 10]);
            			    //čtverec pro zámek Z+
            				translate([top_cover_division[0] - 2*hull_wall_thickness,2,hull_z_size/2-hull_corner_radius])
            					rotate([0,0,0])
            						cube([hull_wall_thickness*4, 15, 10]);
            				//čtverec pro zámek Z-
            				translate([top_cover_division[0] - 2*hull_wall_thickness,2,- hull_z_size/2 - hull_corner_radius])
                 					cube([hull_wall_thickness*4, 15, 40]);
            			//union
            			}	
        			//intersection
        			}
        		//union zámky
        		}	

        //final union
        }

    	//zámky odečtení
    		union(){
    			intersection(){
    					whole_drop();	
        			union(){
            			//čtverec pro zámek horní
        				translate([top_cover_division[1] + 2*hull_wall_thickness,hull_y_size/2+30,0])
        					rotate([0,0,90-beta])
        						cube([hull_wall_thickness*4 + global_clearance,15 + global_clearance,10 + global_clearance]);
        			    //čtverec pro zámek Z+
        				translate([top_cover_division[1] - 2*hull_wall_thickness,2,hull_z_size/2-hull_corner_radius])
        						cube([hull_wall_thickness*4 + global_clearance,15 + global_clearance,10 + global_clearance]);
        				//čtverec pro zámek Z-
        				translate([top_cover_division[1] - 2*hull_wall_thickness,2,-hull_z_size/2])
        						cube([hull_wall_thickness*4 + global_clearance,15 + global_clearance,10 + global_clearance]);
        			//union
        			}	
    			//intersection
    			}
    		//union zámky vlevo
    		}
    	
    //final difference
    }

//final module
}	

//část 2

module 666_1025C(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

translate([20,0,0])
    
    union(){	
    	
    	//základní dělení pro tisk
    	    
        		intersection(){
            				666_1025();
            		translate([top_cover_division[1],-20,-150])
               				cube([top_cover_division[2] - top_cover_division[1],150,300]);
        		}
        
        //rantl pro slepení vpravo
    	intersection(){
    		difference(){
    	//pro lepení - čtverec 
    			translate([top_cover_division[2] - hull_wall_thickness,0,-hull_z_size])
    					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
    	//pro lepení - odstranění čtverce válcem
    			translate([top_cover_division[2]-20,20,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
    	//pro lepení - odstranění kusu z díry pro horní držák
    	       	translate ([180+2*hull_wall_thickness,-10,0])       
    				rotate ([-90,0,0])
                        resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                            airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
    	//final difference
    		}

        //odstranění čtverce z vnější strany
    			drop();
    	
    	//final intersection	
    	}

    	//zámky vlevo
    		union(){
    			intersection(){
    					whole_drop();	
        			union(){
            			//čtverec pro zámek horní
        				translate([top_cover_division[1] + 2*hull_wall_thickness,hull_y_size/2+30,0])
        					rotate([0,0,90-beta])
        						cube([hull_wall_thickness*4,15,10]);
        			    //čtverec pro zámek Z+
        				translate([top_cover_division[1] - 2*hull_wall_thickness,2,hull_z_size/2-hull_corner_radius])
        						cube([hull_wall_thickness*4,15,10]);
        				//čtverec pro zámek Z-
        				translate([top_cover_division[1] - 2*hull_wall_thickness,2,-hull_z_size/2])
        						cube([hull_wall_thickness*4,15,10]);
        			//union
        			}	
    			//intersection
    			}
    		//union zámky vlevo
    		}

    //final union
    }
//final module
}


//část 2B

module 666_1025D(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    clearance = 0.5;

translate([30,0,0])

    union(){	
    	//základní dělení pro tisk
        		intersection(){
            		666_1025();
            		translate([top_cover_division[2],-20,-150])
               			cube([top_cover_division[3] - top_cover_division[2],150,300]);
        		}
        
        //rantl pro slepení vlevo
    	intersection(){
    		difference(){
    	//pro lepení - čtverec 
    			translate([top_cover_division[2],0,-hull_z_size])
    					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
    	//pro lepení - odstranění čtverce válcem
    			translate([top_cover_division[2] - 20,20,0])
    				rotate([0,90,0])		
    					cylinder(h = 40,r1 = 60, r2 = 70, $fn = draft ? 50 : 100);
    	//pro lepení - odstranění kusu z díry pro horní držák
    	       	translate ([180+2*hull_wall_thickness,-10,0])       
    				rotate ([-90,0,0])
                        resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true) 
                            airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);
    	//final difference
    		}

        //odstranění čtverce z vnější strany
    			drop();
    	//final intersection	
    	}

    	//zámky vpravo
    		union(){
    			intersection(){
    				//translate([30,0,0])
    					whole_drop();	
        			union(){
            			//čtverec pro zámek horní
        				translate([top_cover_division[3] - 2*hull_wall_thickness,hull_y_size/2,0])
        						cube([hull_wall_thickness*4,15,10]);
        			    //čtverec pro zámek Z+
        				translate([top_cover_division[3] - 2*hull_wall_thickness,2,hull_z_size/2 - 20])
        						cube([hull_wall_thickness*4,15,40]);
        				//čtverec pro zámek Z-
        				translate([top_cover_division[3] - 2*hull_wall_thickness,2,-hull_z_size/2])
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



module 666_1025E(){	

	beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness


translate([40,0,0])

    difference(){	
    	union(){
    	//základní dělení pro tisk
            		intersection(){
                		666_1025();
                		translate([top_cover_division[3],-20,-150])
                   			cube([top_cover_division[4] - top_cover_division[3],150,300]);
            		}
    	

    	//rantl pro slepení vlevo
    	intersection(){
    		difference(){
    		//pro lepení - čtverec 
    			translate([top_cover_division[3],0,-hull_z_size])
    					cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
    		//pro lepení - odstranění čtverce válcem
    			translate([top_cover_division[3]-20,8,0])
    				rotate([0,90,0])		
    					cylinder(h = 30,r1 = 45, r2 = 45, $fn = draft ? 50 : 100);
    		}
    		//odstranění čtverce z vnější strany
    				drop();
    	}

    	//zámky vlevo
    	union(){
    			intersection(){
    					whole_drop();	
    			union(){
        			//čtverec pro zámek horní
    				translate([top_cover_division[4] - 2*hull_wall_thickness,hull_y_size/2-35,-10])
    					rotate([0,0,0])
    						cube([hull_wall_thickness*4,20,20]);
    		
    			    //čtverec pro zámek Z+
    				translate([top_cover_division[4] - 2*hull_wall_thickness,2,hull_z_size/2-40])
    						cube([hull_wall_thickness*4,15,40]);
    				//čtverec pro zámek Z-
    				translate([top_cover_division[4] - 2*hull_wall_thickness,2,-hull_z_size/2])
    						cube([hull_wall_thickness*4,15,40]);
    			//union
    			}	
    			//intersection
    			}
    		//union zámky vlevo
    		}

    //final union
    }
	

//zámky vpravo odečtení
	
//zámky vpravo

    	//zámky vpravo
    		union(){
    			intersection(){
    				//translate([30,0,0])
    					whole_drop();	
        			union(){
            			//čtverec pro zámek horní
        				translate([top_cover_division[3] - 2*hull_wall_thickness,hull_y_size/2,0])
        						cube([hull_wall_thickness*4 + global_clearance,15 +global_clearance,10 + global_clearance]);
        			    //čtverec pro zámek Z+
        				translate([top_cover_division[3] - 2*hull_wall_thickness,2,hull_z_size/2 - 20])
        						cube([hull_wall_thickness*4 + global_clearance,15 + global_clearance,40 + global_clearance]);
        				//čtverec pro zámek Z-
        				translate([top_cover_division[3] - 2*hull_wall_thickness,2,-hull_z_size/2])
        						cube([hull_wall_thickness*4 + global_clearance,15 + global_clearance,40 + global_clearance]);
        			//union
        			}	
    			//intersection
    			}
    		//union zámky vpravo

    }
	}
//final module
}

//666_1025A();
/*666_1025B();
666_1025C();
666_1025D();
666_1025E();
*/




module 666_1025_part(part_number){ 

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    division_position = top_cover_division[part_number];
    previous_division = top_cover_division[part_number - 1];

    part_lenght = division_position - previous_division;
    lock_width = 10;
    part_flip = 4;  // část od které se otáčí pořadí zámků.

    if (part_number < part_flip) {
        difference(){
            union(){    
                //základní dělení pro tisk
                intersection(){
                    666_1025();
                    translate([previous_division + global_clearance/2,-20,-75])                        
                        cube([part_lenght - global_clearance/2, 150, 150]);
                }
                
                //zámky přidané 
                union(){
                    intersection(){
                        whole_drop();   
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - 2*hull_wall_thickness, main_tube_outer_diameter, -lock_width/2])
                                    cube([hull_wall_thickness*3, hull_y_size, lock_width]);
                            //čtverec pro zámek Z+
                            translate([previous_division - 2*hull_wall_thickness, 0, main_tube_outer_diameter ])
                                    cube([hull_wall_thickness*3, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([previous_division - 2*hull_wall_thickness, 0, - hull_z_size - main_tube_outer_diameter])
                                    cube([hull_wall_thickness*3, lock_width, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky
                }   

            //final union
            }

            //zámky odečtení
            if (part_number != (part_flip-1)){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.                
                union(){
                    intersection(){
                        whole_drop();   
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - 2*hull_wall_thickness, main_tube_outer_diameter, -lock_width/2])
                                cube([hull_wall_thickness*4 + global_clearance, hull_y_size, lock_width + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([division_position - 2*hull_wall_thickness, 0,hull_z_size/2])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([division_position - 2*hull_wall_thickness, 0,- hull_z_size - main_tube_outer_diameter ])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky vlevo
                }
            }
            
        //final difference
        }
    }
    else{       // pokud jde o díl až za prostředním dělením.

        difference(){
            union(){    
                //základní dělení pro tisk
                intersection(){
                    666_1025();
                    translate([previous_division,-20,-75])                        
                        cube([part_lenght - global_clearance/2, 150, 150]);
                }
                
                //zámky přidané 
                union(){
                    intersection(){
                        whole_drop();   
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - 2*hull_wall_thickness, main_tube_outer_diameter, - lock_width/2])
                                    cube([hull_wall_thickness*4, hull_y_size, lock_width]);
                            //čtverec pro zámek Z+
                            translate([division_position - 2*hull_wall_thickness, 0, main_tube_outer_diameter])
                                    cube([hull_wall_thickness*4, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([division_position - 2*hull_wall_thickness, 0, -main_tube_outer_diameter - hull_z_size ])
                                    cube([hull_wall_thickness*4, lock_width, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky
                }   
            //final union
            }

            if (part_number != part_flip){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.                
                //zámky odečtení
                union(){
                    intersection(){
                        whole_drop();   
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - 2*hull_wall_thickness, main_tube_outer_diameter/2, -lock_width/2])
                                cube([hull_wall_thickness*4 + global_clearance, hull_y_size, lock_width + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([previous_division - 2*hull_wall_thickness, 0, main_tube_outer_diameter])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([previous_division - 2*hull_wall_thickness, 0, - main_tube_outer_diameter - hull_z_size])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky vlevo
                }
            }
        //final difference
        }

    }

//final module
}   

666_1025_part(1);

translate([10,0,0])
666_1025_part(2);

translate([20,0,0])
666_1025_part(3);

translate([30,0,0])
666_1025_part(4);

translate([40,0,0])
666_1025_part(5);



//666_1025();

use <./lib/naca4.scad>
include <../Parameters.scad>
