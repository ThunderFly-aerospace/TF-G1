
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;


draft = true;

module 666_1028(){

	beta = 90 - trailing_edge_angle(naca = 0005); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    wall_thickness = 0.6;

    //BASIC DROP
    //render(convexity = 2) 
    difference (){
        union (){
            translate([0,0,-8.5])
                rotate_extrude($fn = draft ? 50 : 200)
                    rotate([0,0,90])
                        difference()
                        {
                            polygon(points = airfoil_data(naca=0030, L = 140)); 
                            square(200, 200); 
                        }


        //TRIANGLE PROFILE

        //UPPER - od osy x do minus y
            difference (){
                union(){
    	            translate([0, -10, -0.5]) // elementary negative Z shift to improve adhesion on the printig surface
    	                rotate ([0,-90, 160])
                        {			//rotate([0,-90,152.5])
    	                    hollow_airfoil(naca = 0005, L = 95, N = draft ? 50 : 100, h = 152, open = true, wall_thickness);

    					//výztuhy
        					intersection(){
                                airfoil(naca = 0005, L = 95, N = draft ? 50 : 100, h = 152, open = false);
                                union(){
                					translate([-50,0,90])
                                		rotate([135,0,80])	
                                    		for (i = [0:13]){ // opakovani cyklu
                                        		translate([0, i * 25, -15])  //zebra
                                            		cube([30, wall_thickness, 180]); 
                       	            		}

                       	            translate([50,-15,-10])
                                		rotate([45,0,80])	
                                    		for (i = [0:13]){ 
                                            		translate([0, i * 25, -15])  
                                                		cube([30, wall_thickness, 180]); 
                       	            		}
                                }
                            }
                        }
    			


            //LOWER - od osy x do plus y
                	translate([0, 10, -0.5]) // elementary negative Z shift to improve adhesion on the printig surface
                    	rotate ([0,-90,-160])		//rotate([0,-90,-152.5])
                        {
                            hollow_airfoil(naca = 0005, L =95, N = draft ? 50 : 100, h = 152, open = true);
                    //výztuhy
                          	intersection(){
                                airfoil(naca = 0005, L = 95, N = draft ? 50 : 100, h = 152, open = false);
                                union(){
                                    translate([150,30,80])
                                   		rotate([135,0,-80])
                                    		for (i = [0:13]) { // opakovani cyklu
                                        		translate([0, i * 25,-15])  //sude prorezy
                                            		cube([30, wall_thickness, 180]); 
                		       	            }

                		       	    translate([50,20,-20])
                                   		rotate([45,0,-80])
                                    		for (i = [0:13]) { // opakovani cyklu
                                        		translate([0, i * 25,-15])  //sude prorezy
                                            		cube([30, wall_thickness, 180]); 
                		       	            }
                                }
        		            }
                    }
                }

			translate ([140,-75,0]) 
                rotate([0,3,0])
            	   cube ([15,150,150]);
	       }

        //VERTICAL
            translate ([140,75,-0.5]) // elementar Z shift to improve adhesion on the printig surface
                rotate([90,-87,0])
                {
                    hollow_airfoil(naca = 0005, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil

            //výztuhy
              	intersection(){
                    airfoil(naca = 0005, L = 150, N = draft ? 50 : 100, h = 150, open = false);
                    union(){
                        translate([70,-15,-55])
                       		rotate([45,0,90])
                        		for (i = [0:17]) { // opakovani cyklu
                                		translate([0, i * 25,-15])  //sude prorezy
                                    		cube([30, wall_thickness, 220]); 
    		       	            }

    		       	    translate([-60,-15,85])
                       		rotate([135,0,90])
                        		for (i = [0:17]) { // opakovani cyklu
                                		translate([0, i * 25,-15])  //sude prorezy
                                    		cube([30, wall_thickness, 230]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
    		       	            }
                    }

	            }
                }

	    } // end of union
        // Start of substraction objects


        //tube
        
        translate([0,0,-10])
            cylinder (h = 90, r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);
		
        translate ([0,0,80])
            cylinder (h = 15, r1 = main_tube_outer_diameter/2, r2 = 0, $fn = draft ? 50 : 200);
        
        //screw
        translate ([-150*0.4,0,150*0.4/2])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        //nut
        translate([17.5,0,150*0.4])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r = Nut_diameter_M3/2, $fn = 6);


        translate([17.5,0,150*0.4/2])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r = Nut_diameter_M3/2, $fn = 6);

        tensile_thickness = 1.8;

        //cleanup for printing
        translate ([-149.9,-75,-1])
        		 cube ([150,150,170]);

        translate ([-50,-100,-200])
            cube ([200,200,200]);
    
        /*translate ([-75,-75,-10])
        	cube ([150,150,150]);*/

    }	
 
}

module 666_1028_drillhelper(height = 60, height_of_cap_cylinder = 2, draft = true)
{
    width=main_tube_outer_diameter+4*thickness_between_tubes;    
    depth=main_tube_outer_diameter*2;
    //height=depth;



    difference (){

        translate([-(width/2),-(depth/2),height_of_cap_cylinder])
            color([0,0,0.5])
                cube ([width,depth,height]);
            
            //tube
        translate([0,0,-1])
                cylinder(h = height+1, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

        //screw
        translate ([-150*0.4,0,150*0.4/2 - 20])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4 - 20])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);
            
    	//prořezy pro zajištění
    	translate([-thickness_between_tubes/2,-main_tube_outer_diameter/2 + global_clearance ,0])
    			cube([global_clearance*3, main_tube_outer_diameter*2, depth*2]);
        translate([0, main_tube_outer_diameter/2 + main_tube_outer_diameter/4, height/2])   
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }

    }
}	

module 666_1028_drillhelper_doc(){


    color("Black")
        union(){
	        //screw
	        translate ([-150*0.4,0,150*0.4/2 - 20])
	            rotate ([0,90,0])
	                circle_center(radius=main_tube_outer_diameter, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

	        translate ([-150*0.4,0,150*0.4 - 20])
	            rotate ([0,90,0])
	                circle_center(radius=main_tube_outer_diameter, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);
	    }
}

666_1028_drillhelper();




//666_1028();
666_1028_drillhelper_doc();

//For printing size limits check.
//translate([0,-75,0])
  //cube ([150,150,150]);



use <./lib/naca4.scad>
include <../Parameters.scad>





