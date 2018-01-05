// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;

// improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

/*
TODO: 

Přední díl obsahuje převis ve směru vybrání pro držák motoru. (U horního zámku)
Otvory pro šrouby v předním dílu jsou oválné, protože nejsou kolmo k rovině modelu.


*/


module hollowing_skeleton(draft)
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
                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 200)); 
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

module drop(draft)
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness 

	intersection () {
    	rotate ([0,90,0])           
        	rotate_extrude($fn = draft ? 50 : 100)
                    rotate([0,0,90])
                        difference()
                        {
	                        polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=draft ? 50 : 200)); 
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

module whole_drop(draft){
	difference(){
		drop(draft);
		translate ([hull_wall_thickness,0,0])
            hollowing_skeleton(draft);
	}
}


module 666_1025(draft){

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
            

            //engine holder 
        		translate ([-2,-1 - main_tube_outer_diameter/2 - hull_wall_thickness, - width_of_engine_holder/2])
        				cube ([ top_cover_division[1], hull_y_size+10, width_of_engine_holder]);

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
                translate([(top_cover_division[0] + top_cover_division[1])/4, -main_tube_outer_diameter/4, -hull_z_size/2])
                    rotate([0,45,0])
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                mirror([0,0,1])
            		translate([(top_cover_division[0] + top_cover_division[1])/4, -main_tube_outer_diameter/4, -hull_z_size/2])
                        rotate([0,45,0])
            				cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		//část B
        		/*%translate([(top_cover_division[1] - top_cover_division[0])/2 + top_cover_division[0],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                */

        		//část C
        		translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		
        		//část D	
        		translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],-main_tube_outer_diameter/4,-hull_z_size/2-15])
        				cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);


        		//část E
        		translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,+50])
        			rotate([0,90-beta,0])	
        				cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        		translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,-50])
        			rotate([0,90+beta,0])	
        				cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		//část F		
        		translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
        			rotate([0,90-beta,0])
        				cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        		translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
        			rotate([0,90+beta,0])
        				cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        	    //nápis
        		translate([hull_x_size/4 + 35, hull_y_size/5, hull_z_size/2 - hull_wall_thickness/5])
            		linear_extrude(hull_wall_thickness) 
                		text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");
			
                // boční text s identifikací

                translate([hull_x_size/4 + 35, hull_y_size/5, -hull_z_size/2 + hull_wall_thickness/5])
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
        				translate ([-2,-1 - main_tube_outer_diameter/2,- width_of_engine_holder/2])
        						cube([52,hull_y_size+10,width_of_engine_holder]);

            		//for tube in back
        				translate ([hull_x_size-70,-6,0])
        					rotate ([0,90,0])
        						cylinder(h = 80, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

    					translate ([hull_x_size-65,-16,16.5])
    						rotate([0,100,0])
    							cube([hull_wall_thickness*5,30,30]);
    					translate ([hull_x_size-65,-15,-12.5])
    						rotate([0,80,0])
    						cube([hull_wall_thickness*5,30,30]);


    				//kapka pro kapkovitý tvar
    					translate ([2.5 + hull_wall_thickness,0,0])
                	intersection () {
                        resize([hull_drop_length - hull_wall_thickness - trailing_wall * hull_wall_thickness-5-2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-2*hull_wall_thickness], auto=true)
                     		rotate ([0,90,0])           
                                rotate_extrude($fn = draft ? 50 : 100)
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
				translate([ 0, - main_tube_outer_diameter/2+0.1, width_of_engine_holder/2 ])		
					cube([top_cover_division[1] - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

                //přední stěna Z-
       		    //čtverec
				translate([ 0, - main_tube_outer_diameter/2+0.1, - width_of_engine_holder/2 - hull_wall_thickness])		
					cube([top_cover_division[1] - hull_wall_thickness, hull_y_size, hull_wall_thickness]);

                //pro rovnou horní hranu předního lemu
                translate([top_cover_division[1] - hull_wall_thickness, 1*main_tube_outer_diameter, -width_of_engine_holder/2 - hull_wall_thickness])
                    cube([hull_wall_thickness, hull_y_size, width_of_engine_holder + 2* hull_wall_thickness]);

                // lem pro výztuhu a slepení dílu A    
                difference(){
                    translate([top_cover_division[1] - hull_wall_thickness, 0, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
            
                    translate([top_cover_division[1]-10,0,0])  // bylo by vhodné zaměnit za odečtení kapkového tvaru trupu
                        rotate([0,90,0])
                            cylinder(h = 20, r = 60, $fn = draft ? 50 : 100);
                
                    //trojúhelník Z+
                    translate([top_cover_division[1] - hull_wall_thickness-0.5,-main_tube_outer_diameter/6,main_tube_outer_diameter/4]) //hodnoty posunuti v ose z a y od oka
                        rotate([45,0,0])        
                            cube([2*hull_wall_thickness,2*main_tube_outer_diameter,2*main_tube_outer_diameter]);
                        
                    //trojúhelník Z+
                    translate([top_cover_division[1] - hull_wall_thickness-0.5,-main_tube_outer_diameter/6,-main_tube_outer_diameter*3 - main_tube_outer_diameter/15]) //hodnoty posunuti v ose z a y od oka
                        rotate([45,0,0])        
                            cube([2*hull_wall_thickness,2*main_tube_outer_diameter,2*main_tube_outer_diameter]);
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

module 666_1025_part(part_number, draft){ 

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
                            translate([previous_division - 2*hull_wall_thickness, 2*hull_wall_thickness, main_tube_outer_diameter ])
                                    cube([hull_wall_thickness*3, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([previous_division - 2*hull_wall_thickness, 2*hull_wall_thickness, - hull_z_size - main_tube_outer_diameter])
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
                            translate([division_position - 2*hull_wall_thickness, 2*hull_wall_thickness,hull_z_size/2 - main_tube_outer_diameter])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([division_position - 2*hull_wall_thickness, 2*hull_wall_thickness,- hull_z_size - main_tube_outer_diameter ])
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
                            translate([division_position - 2*hull_wall_thickness, 2*hull_wall_thickness, main_tube_outer_diameter])
                                    cube([hull_wall_thickness*4, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([division_position - 2*hull_wall_thickness, 2*hull_wall_thickness, -main_tube_outer_diameter - hull_z_size ])
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
                            translate([previous_division - 2*hull_wall_thickness, 2*hull_wall_thickness, main_tube_outer_diameter])
                                cube([hull_wall_thickness*4 + global_clearance, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([previous_division - 2*hull_wall_thickness, 2*hull_wall_thickness, - main_tube_outer_diameter - hull_z_size])
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


666_1025_part(1, draft);

translate([10,0,0])
666_1025_part(2, draft);

translate([20,0,0])
666_1025_part(3, draft);

translate([30,0,0])
666_1025_part(4, draft);

translate([40,0,0])
666_1025_part(5, draft);


//666_1025();

use <./lib/naca4.scad>
include <../Parameters.scad>
