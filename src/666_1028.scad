
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

//poloha sroubu, drzici tyc, od nabezne hrany
screw_for_pipe_pos = 50;

//tvar A levá (- 1) nebo pravá (1) strana (ve směru letu)
side_choose = - 1;

//tvar A vzájemný náklon
Rudder_angle = 90;

//výstuhy tloušťka stěny
infill_wall_thickness = 1;

//pusun serva
servo_x_offset = 50;

//servo rozmery otvoru
servo_height = 25;
servo_length = 32;
servo_inside_length = 23.2;
servo_screws_gap = 27;
servo_screws_height = 15;
servo_mount_wall_thickness = 2;

//upevnovaci trubka
mount_height = 32;
mount_length = 40;
mount_wing_thickness = 5;

//vyska vyztuhy do tvaru A
shape_A_mount_thickness = 30;

//celkove rozmery
rudder_full_height = 150;

draft = true;

module 666_1028(draft){

	beta = 90 - trailing_edge_angle(naca = 0005); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    wall_thickness = 0.65;
    
    rotate([0,0,90])  {
        difference(){//diff
            union(){        
                //
                //
                //
                //
                //
                //dutý profil
                hollow_airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = rudder_full_height, open = false);
                
                difference() {//diff   
                    
                        //výztuhy:
                    intersection(){
                        airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = rudder_full_height, open = false);
                        union(){
                                    //žebrování
                                    translate([60,-15,-40])
                                        rotate([45,0,90])
                                            for (i = [0:8]) { // opakovani cyklu
                                                translate([0, i * 25,-15])  //sude prorezy
                                                    cube([30, wall_thickness, 220]);
                                            }
    
                                    translate([-60,-15,60])
                                        rotate([135,0,90])
                                            for (i = [0:8]) { // opakovani cyklu
                                                translate([0, i * 25,-15])  //sude prorezy
                                                    cube([30, wall_thickness, 230]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                                            }
                                            
                                    //vyztužení pro upevnění do tvaru A
                                    translate([80, 0, 145])
                                        cube([200, 20, shape_A_mount_thickness], center = true);
                                            
                                    //vyztužní pro upevnění na trubku
                                    translate([20 + infill_wall_thickness, 0, tail_pipe_z_position])
                                            cube([mount_length + infill_wall_thickness * 2, Rudder_depth + 2, mount_height + infill_wall_thickness * 2], center = true); 
                                    
                                            
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
                                                    cylinder(h = 160 + 6, d = Rudder_shaft_diameter, $fn = draft ? 10 : 50, center = true);
                                            }
                                            
                                    //vystužení pro směrovku
                                    translate([150 - Rudder_height/ 2, 0, 75])
                                        cube([Rudder_height + 8, Rudder_depth + gap_width, Rudder_length + infill_wall_thickness * 2], center = true);
                                            
                                    //vyztužení pro upevnění serva
                                    translate([servo_x_offset, 0, tail_pipe_z_position - servo_height / 2 - mount_height / 2 - infill_wall_thickness])
                                        cube([servo_length + infill_wall_thickness * 2, Rudder_depth * 2, servo_height + infill_wall_thickness * 2], center = true);
                        }
                    }
                    
                    
                    //otvory pod airfoil:
                        
                //otvor pro směrovku
                translate([150 - Rudder_height/ 2, 0, 75])
                    cube([Rudder_height + 6, Rudder_depth + gap_width, Rudder_length], center = true);
                }
            }
                
                //otvory skrze celí model:
                
            //díra pro uchycení směrovky
            translate([rudder_full_height - Rudder_height + gap_width / 2, 0, - 3])
                cylinder(h = 160 + 6, d = Rudder_shaft_diameter, $fn = draft ? 10 : 50);
                
            //vyříznutí boku do tvaru A
            translate([75, - side_choose * 6, rudder_full_height])
                rotate([90, - side_choose * Rudder_angle / 2, 90])
        		    cube([40, 20, rudder_full_height + 10], center = true);
                            
            //vyříznutí děr pro upevnění do tvaru A
            translate([30, 0, rudder_full_height - 10])
                rotate([90 - side_choose * Rudder_angle / 2, 0, 0])
                    union() {
					    cylinder (h=30, d=M3_screw_diameter, $fn=100, center = true);
                        translate([0, 0, - side_choose * 10])
                            if(side_choose == - 1) {
							    cylinder (h=10, d=M3_nut_diameter, $fn=100, center = true);
                            } else {
                                cylinder (h=10, d=M3_nut_diameter, $fn=6, center = true);
                            }
                    }
            translate([80, 0, rudder_full_height - 10])
                rotate([90 - side_choose * Rudder_angle / 2, 0, 0])
                    union() {
					    cylinder (h=30, d=M3_screw_diameter, $fn=100, center = true);
                        translate([0, 0, - side_choose * 10])
                            if(side_choose == - 1) {
							    cylinder (h=10, d=M3_nut_diameter, $fn=100, center = true);
                            } else {
                                cylinder (h=10, d=M3_nut_diameter, $fn=6, center = true);
                            }
                    }
                    
            //otvory pro šrouby pro upevnění trubky
            translate([10, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position - 12])
                rotate([side_choose * 90, 0, 0])
                    union() {
                        cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
                        translate([0, 0, Rudder_depth + 2 - M3_nut_height])
                            cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 100);
                        cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 6);
                    }
            translate([30, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position - 12])
                rotate([side_choose * 90, 0, 0])
                    union() {
                        cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
                        translate([0, 0, Rudder_depth + 2 - M3_nut_height])
                            cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 100);
                        cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 6);
                    }
            translate([10, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position + 12])
                rotate([side_choose * 90, 0, 0])
                    union() {
                        cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
                        translate([0, 0, Rudder_depth + 2 - M3_nut_height])
                            cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 100);
                        cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 6);
                    }
            translate([30, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position + 12])
                rotate([side_choose * 90, 0, 0])
                    union() {
                        cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
                        translate([0, 0, Rudder_depth + 2 - M3_nut_height])
                            cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 100);
                        cylinder(h = M3_nut_height, d = M3_nut_diameter, $fn = 6);
                    }
                        
                //otvor pro upevnění na trubku
                translate([20, 0, tail_pipe_z_position])
                    union() {
                        cube([mount_length + infill_wall_thickness * 2, Rudder_depth * 2, tube_for_undercarriage_outer_diameter + global_clearance * 2 + 4], center = true);
                        cube([mount_length + infill_wall_thickness * 2, mount_wing_thickness, mount_height], center = true);
                        translate([20, 0, 0])
                            rotate([0, 90, 0])
                                cylinder(h = 10, d = 8, center = true);
                    }
                    
                 
                //otvor pro servo
                translate([servo_x_offset, 0, tail_pipe_z_position - servo_height / 2 - mount_height / 2 - infill_wall_thickness])
                    cube([servo_inside_length + global_clearance * 2, Rudder_depth * 2, servo_height], center = true);
                         
                translate([servo_x_offset - servo_screws_gap / 2, 0, tail_pipe_z_position - servo_screws_height - mount_height / 2 - infill_wall_thickness])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth + 2, d = M2_screw_diameter, $fn = 100, center = true);
                        
                translate([servo_x_offset + servo_screws_gap / 2, 0, tail_pipe_z_position - servo_screws_height- mount_height / 2 - infill_wall_thickness])
                    rotate([90, 0, 0])
                        cylinder(h = Rudder_depth + 2, d = M2_screw_diameter, $fn = 100, center = true);
                             
                translate([servo_x_offset, (Rudder_depth + servo_mount_wall_thickness / 2), tail_pipe_z_position - servo_height / 2 - mount_height / 2 - infill_wall_thickness])
                    cube([servo_length, Rudder_depth * 2, servo_height], center = true);   
                    
                translate([servo_x_offset, - (Rudder_depth + servo_mount_wall_thickness / 2), tail_pipe_z_position - servo_height / 2 - mount_height / 2 - infill_wall_thickness])
                    cube([servo_length, Rudder_depth * 2, servo_height], center = true);   
                    
                //otvor pro dráty
                translate([servo_x_offset + 13.5, 0, tail_pipe_z_position - 7.5])
                    cube([8, 8, 25], center = true);
        }
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
            translate ([140, 75,-0.1]) // elementar Z shift to improve adhesion on the printig surface
                rotate([90,-90,0])
                    airfoil(naca = 0009, L = 150, N = 50, h = 150, open = false); //dutý profil

            //vyříznutí otvoru pro směrovku
            translate([-Rudder_depth/2,- Rudder_length/2, 150 - Rudder_height - gap_width - 4.85*0.75])
                #cube([Rudder_depth, Rudder_length, Rudder_height + global_clearance + gap_width + 4.85*0.75 ]);

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
            cylinder(h = Rudder_length + gap_width, d = Rudder_shaft_diameter, $fn = 10);

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


//díl pro připevnění na trubku
module 666_1028_mount(draft){
    difference() {//diff
        union() {
            //tělo dílu:
            intersection(){
                airfoil(naca = 0009, L = 150, N = draft ? 50 : 100, h = 160, open = false);
                translate([mount_length / 2, 0, tail_pipe_z_position])
                    union() {                    
                        cube([mount_length, Rudder_depth + 2, tube_for_undercarriage_outer_diameter + 4], center = true);
                        cube([mount_length, mount_wing_thickness - global_clearance * 2, mount_height - global_clearance * 2], center = true);
                    }
                }
            translate([mount_length / 2, 0, tail_pipe_z_position])
                rotate([0, 90, 0])
                    cylinder(h = mount_length, d = tube_for_undercarriage_outer_diameter + global_clearance + 2, center = true, $fn = 100);
            }
        
        //otvor pro trubku
        translate([mount_length / 2, 0, tail_pipe_z_position])
            rotate([0, 90, 0])
                cylinder(h = mount_length + 2, d = tube_for_undercarriage_outer_diameter + global_clearance, center = true, $fn = 100);
        //otvory pro šrouby    
        translate([10, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position - 12])
            rotate([side_choose * 90, 0, 0])
                cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
        translate([30, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position - 12])
            rotate([side_choose * 90, 0, 0])
                cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
        translate([10, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position + 12])
            rotate([side_choose * 90, 0, 0])
                cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
        translate([30, side_choose * (Rudder_depth / 2 + 1), tail_pipe_z_position + 12])
            rotate([side_choose * 90, 0, 0])
                cylinder(h = Rudder_depth + 2, d = M3_screw_diameter, $fn = 100);
    }
}


/*translate([150 - Rudder_depth + gap_width*1.5 + 0.14,Rudder_length - gap_width - (150 - Rudder_length)/2 - gap_width/2,-gap_width*0.3])
    rotate([90,-90 ,0])
        666_1028_rudder(draft);
*/

rotate([0,0 ,90])
    666_1028_mount(draft);

rotate([0,0 ,90])
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
