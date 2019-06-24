
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

//poloha sroubu, drzici tyc, od nabezne hrany
screw_for_pipe_pos = 50;

draft = true;


module 666_1028(draft){

	beta = 90 - trailing_edge_angle(naca = 0005); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    wall_thickness = 0.65;

    //BASIC DROP
    //render(convexity = 2)
    difference (){
        union (){

        //VERTICAL

    intersection(){
     //zkosení o 10 stupňů
        union(){
            translate([0,-47,0])
                rotate([0,0,-10])
                    cube([400,100,300]);

            translate([0,-100+45,0])
                rotate([0,0,10])
                    cube([400,100,300]);
        }

            union(){
                difference(){
                    union(){

											hull() {
													rotate([0,-87,0])
															translate([screw_for_pipe_pos, 0, -132])
																cylinder (h=M3_ISO7380_head_height, d=M3_ISO7380_nut_diameter+1, $fn=50);

													translate ([140, 75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
			                          rotate([90,-87,0])
																		translate([0, 0, 75])
																				rotate([0, 90, 0])
																					cylinder(h=62, d=tube_for_undercarriage_outer_diameter+2, $fn=50);

													rotate([0,-87,0])
																translate([screw_for_pipe_pos, 0, -152])
																			cylinder (h=M3_ISO7380_head_height, d=M3_ISO7380_nut_diameter+1, $fn=6);
											}

                        translate ([140, 75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
                            rotate([90,-87,0])
                            {

                                hollow_airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil

																//vyztuha pro tyc d=10,6 mm
																translate([0, 0, 75])
																		rotate([0, 90, 0])
																				difference() {
																						cylinder(h=62, d=tube_for_undercarriage_outer_diameter+2, $fn=50);
																						cylinder(h=60, d=tube_for_undercarriage_outer_diameter, $fn=50);
																				}

                                //výztuhy
                              	intersection(){
                                    airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false);
                                    union(){
                                        translate([70,-15,-55])
                                       		rotate([45,0,90])
                                        		for (i = [0:8]) { // opakovani cyklu
                                                		translate([0, i * 25,-15])  //sude prorezy
                                                    		cube([30, wall_thickness, 220]);
                    		       	            }

                    		       	    translate([-60,-15,85])
                                       		rotate([135,0,90])
                                        		for (i = [0:8]) { // opakovani cyklu
                                                		translate([0, i * 25,-15])  //sude prorezy
                                                    		cube([30, wall_thickness, 230]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    		       	            }

        			                	// vyztužení pro čepy
        			                	rotate([-90,0,-90])
        				                	translate([0, -75, 150 - Rudder_height + gap_width/2])
        				                        difference(){
        				                        	union(){
        				                				translate([0, 75, 0])
        					                            	rotate([45,0,0])
        						                            	cube([15, 40, 40], center = true);

        				                				translate([0, -75, 0])
        					                            	rotate([45,0,0])
        						                            	cube([15, 40, 40], center = true);
        					                        }

        				            				translate([0, 0, 25])
        				                            	cube([25, 200, 40], center = true);

        				                            rotate([90,0,0])
        				                                cylinder(h = 150 + 6, d = ruder_shaft_diameter, $fn = draft ? 10 : 50, center = true);

        				                        }
                                    }
            	            }
                        }

                    }

										//otvor pro tyc d=10,6mm
												translate ([140,75,-1])
												rotate([90,-87,0])
												translate([0, 0, 75])
												rotate([0, 90, 0])
														cylinder(h=60, d=tube_for_undercarriage_outer_diameter, $fn=50);

										//dira na sroub M3 ISO7380 pro tyc
										rotate([0,-87,0])
										translate([screw_for_pipe_pos, 0, -170])
												cylinder (h=60, d=M3_screw_diameter, $fn=50);

										//dira na hlavu sroubu M3
										rotate([0,-87,0])
										translate([screw_for_pipe_pos, 0, -132])
												cylinder (h=M3_ISO7380_head_height+1, d=M3_ISO7380_nut_diameter, $fn=50);

										//dira na matku sroubu M3
										rotate([0,-87,0])
										translate([screw_for_pipe_pos, 0, -153])
												cylinder (h=M3_ISO7380_head_height+1, d=M3_ISO7380_nut_diameter, $fn=6);

                    //vyříznutí otvoru pro směrovku
                    translate([145 - Rudder_depth/2,- Rudder_length/2, 150 - Rudder_height - gap_width - 4.85*0.75])
                        cube([Rudder_depth, Rudder_length, Rudder_height + global_clearance + gap_width + 4.85*0.75 ]);

                    translate([150 - 4.87 + 0.14,75,150 - Rudder_height + gap_width/2])
                        rotate([90,0,0])
                           translate([0,0,-3])
                           cylinder(h = 150 + 6, d = ruder_shaft_diameter, $fn = draft ? 10 : 50);


                    // otvor pro servo
                    translate([143,19.8,30])
                        rotate([0,3,0])
                            union(){
                                translate([-6 , -(22.8 - 19.3) - 1.25, -4.95 - 1 - 0.25])
                                    cube([13.5,22.8 + 4.5, 32.5 + 2 + 0.5]);

                                translate([-20, -5, 0])
                                    cube([20,8,30]);
                           	}
                }
                //integrovaný rámeček pro servo
                // TODO - Je potřeba, aby rámeček byl součástí stěny směrovky aby nezvětšoval potřebnou tloušťku směrovky, nutnou pro vložení serva
                /*    translate([143,19.8,30])
                        rotate([0,3,0])
                            888_1012_C();
                */

            }
    }


	    } // end of union
        // Start of substraction objects



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
                cylinder (h = M3_nut_height+10, r = M3_nut_diameter/2, $fn = 6);


        translate([17.5,0,150*0.4/2])
            rotate([0,90,0])
                cylinder (h = M3_nut_height+10, r = M3_nut_diameter/2, $fn = 6);

        // provizorní prostupy pro kabely serva
        translate([135,50,45])
                cube([5,5,15]);

        translate([0,0,80])
            rotate([0,45,0])
                cube([15,5,50], center = true);

        //cleanup for printing
        translate ([-149.9,-75,-1])
        	cube([150,150,170]);

        translate ([-50,-100,-200])
            cube([200,200,200]);

        /*translate ([-75,-75,-10])
        	cube ([150,150,150]);*/



    }
}

module 666_1028_flightgear(draft){

    beta = 90 - trailing_edge_angle(naca = 0005); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    wall_thickness = 0.65;

    //BASIC DROP
    //render(convexity = 2)
    difference (){
        union (){
            translate([0,0,-8.5])
                rotate_extrude($fn = 50)
                    rotate([0,0,90])
                        difference()
                        {
                            polygon(points = airfoil_data(naca=0030, L = 140));
                            square(200, 200);
                        }


        //TRIANGLE PROFILE


        //VERTICAL
        difference(){
            translate ([140,75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
                rotate([90,-87,0])
                    airfoil(naca = 0009, L = 150, N = 50, h = 150, open = false); //dutý profil

            //vyříznutí otvoru pro směrovku
            translate([145 - Rudder_depth/2,- Rudder_length/2, 150 - Rudder_height - gap_width - 4.85*0.75])
                cube([Rudder_depth, Rudder_length, Rudder_height + global_clearance + gap_width + 4.85*0.75 ]);

        }

        } // end of union
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
    	translate([-(3*global_clearance)/2,-main_tube_outer_diameter/2 + global_clearance ,0])
    			cube([global_clearance*3, main_tube_outer_diameter*2, depth*2]);
	//šrouby
        translate([0, main_tube_outer_diameter/2 + main_tube_outer_diameter/4, height/2])
            rotate([0,90,0])
                union(){
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*M4_nut_height])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                }



    }
}

module 666_1028_drillhelper_doc(){


    color("Black")
        union(){
	        //screw
	        translate ([-150*0.4,0,150*0.4/2 - 20])
	            rotate ([0,90,0])
	                circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

	        translate ([-150*0.4,0,150*0.4- 20])
	            rotate ([0,90,0])
	                circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);
	    }
}

//rotate([270,-90,0])
//666_1028_drillhelper();



module 666_1028_rudder(draft){

    difference(){
        union(){
            intersection(){
               	hollow_airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false); //dutý profil
                translate([150 - Rudder_height + gap_width/2,- Rudder_depth/2, + gap_width/2 + (150 - Rudder_length)/2])
                    rotate([90,0,90])
                          cube([Rudder_depth + gap_width, Rudder_length - gap_width,Rudder_height + global_clearance]);
            }
            translate([150 - Rudder_height + gap_width*1.5 - 1,0, gap_width/2 + (150 - Rudder_length)/2])
                cylinder(h = Rudder_length - gap_width, r = 150*surface_distance(x = (150 - Rudder_height + gap_width*1.5 - 1)/150, naca=0009, open = false), $fn = draft ? 10:50);

		    translate([112,0, 30 + 34 - height/2])
		        cube([11,2*150*surface_distance(x = 107/150, naca=0009, open = false),10], center = true);


        }
        translate([150 - Rudder_height + gap_width*1.5 - 1,0, + gap_width/2 + (150 - Rudder_length)/2 - gap_width])
            cylinder(h = Rudder_length + gap_width, d = ruder_shaft_diameter, $fn = 10);

	    //páka pro táhlo
	    height = 10;
	    lenght = 11;

	    // vypocet pozice sroubu
	    // roztec sroubu pres uhlopricku
	    screws_distance = (11+7.5)/2;

	    // výpočet úhlopříčky základny páky
	    diagonal = sqrt(height*height+lenght*lenght);


	    // šrouby leží na úhlopříčce základny a je známá vzdálenost mezi šrouby
	    // pozice šroubů se proto spočítají z podobnosti trojúhelníků
	    screw_xposition = (lenght/diagonal)*(screws_distance/2);
	    screw_yposition = (height/diagonal)*(screws_distance/2);

		translate([112,0,30 + 34 - height/2]){

		    translate([screw_xposition, 0, screw_yposition])
		        rotate([90,0,0])
		            cylinder(h = 100, d = 2.3, $fn = 10, center = true);

		    translate([-screw_xposition, 0, -screw_yposition])
		        rotate([90,0,0])
		            cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([screw_xposition, 0, -screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([-screw_xposition, 0, screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);


		}
    }
}


module 666_1028_rudder_flightgear(draft){

            intersection(){
                airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 150, open = false);
                translate([150 - Rudder_height + gap_width/2,- Rudder_depth/2, + gap_width/2 + (150 - Rudder_length)/2])
                    rotate([90,0,90])
                          cube([Rudder_depth + gap_width, Rudder_length - gap_width,Rudder_height + global_clearance]);
            }
            translate([150 - Rudder_height + gap_width*1.5 - 1,0, gap_width/2 + (150 - Rudder_length)/2])
                cylinder(h = Rudder_length - gap_width, r = 150*surface_distance(x = (150 - Rudder_height + gap_width*1.5 - 1)/150, naca=0009, open = false), $fn = draft ? 10:50);
}




/*translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
    rotate([90,-87 ,0])
        666_1028_rudder(draft);
*/


translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
    rotate([90,-87 ,0])
        666_1028_rudder_flightgear(draft);


//666_1028_flightgear();


/*
translate([131,20,30.5])
    rotate([0,3,0])
    888_1012_D();
*/
//666_1028_drillhelper_doc();

//For printing size limits check.
//translate([0,-75,0])
//  cube([150,150,150]);


//servo

/*
translate([142.1,20,30])
    rotate([0,3,0])
        union(){
                888_1012_A();
                888_1012_B();
                888_1012_C();
        }

*/

666_1028();


use <888_1012.scad>

use <./lib/naca4.scad>
include <../parameters.scad>
