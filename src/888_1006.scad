//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;




module 888_1006(draft){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    hole_for_nut_x = 15;
    hole_for_nut_y = 50;
    hole_for_nut_z = 20;
    y_size = 100;
    z_size = 150;
    x_size = 580;
    
    //akumulátor
     width =width_of_accumulator + accumulator_holder_width;
    depth = accumulator_holder_width;
    height = height_of_accumulator - sink_of_accumulator + accumulator_holder_thickness;


    //kostka spojky pro akumulátor, ve které je umístěn otvor pro šroub
    width_cube = accumulator_holder_thickness;    //šířka kostky ve které je otvor na šroub
    depth_cube = accumulator_holder_width;
    height_cube = accumulator_holder_thickness; //výška kostky ve které je otvor na šroub
  

    //opticalFlow
    width_optical_flow_senzor = 45.5;
    depth_optical_flow_senzor = 10;
    height_optical_flow_senzor = 35;
    sink_of_optical_flow_senzor = depth_optical_flow_senzor - 5; 
    M3_optical_flow_senzor_Z = 30.4;
    M3_optical_flow_senzor_X = 24;
    M3_optical_flow_senzor_Z_alone = 9.1;
    M3_optical_flow_senzor_X_alone = 16.7;



	difference(){
		union(){
			intersection (){
					hollowing_skeleton();
				translate([0,-main_tube_outer_diameter/2 - thickness_between_tubes, - hull_z_size/2])
					cube ([hull_drop_length, main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness, hull_z_size]);
			}
	

			translate([hull_x_size - 115 - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness, -18])
            //sloupky pro GPS
         	union(){                
                translate([-((48.01 - 37.48)/2 + 37.48)/2,0,0])    
                	rotate([-90,0,0])
                        cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                translate([((48.01 - 37.48)/2 + 37.48)/2,0,0])        
                    rotate([-90,0,0])
                        cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                translate([0,0,((37.78+(48.01-37.48)/2)*sqrt(3))/2])        
                    rotate([-90,0,0])
                        cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
            }
		}

		//drážka pro lem od horního a spodního krytu
		difference(){
			translate ([-10,-hull_wall_thickness - global_clearance - thickness_between_tubes,- hull_z_size/2 - 10])
					cube([hull_drop_length + 20, 2*hull_wall_thickness + 2*global_clearance, hull_z_size + 20 ]);
			translate([ribbon_width*0.75,0])
					hollowing_skeleton_hem(1.5*ribbon_width,draft);
		}

	        //for front part
            translate ([-global_clearance,-5 - main_tube_outer_diameter/2 - hull_wall_thickness,- width_of_engine_holder/2 - hull_wall_thickness - global_clearance])
		            cube([top_cover_division[1] + 2, hull_y_size + 10, width_of_engine_holder + 2*hull_wall_thickness + 2*global_clearance]);

        //for tube in back
        translate ([hull_x_size-70,0,0])
            rotate ([0,90,0])
                cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                            

        //vyříznutí díry pro horizontální trubku
        translate([0,0,0])    
            rotate([0,90,0])
                cylinder(h = hull_drop_length, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
        translate([0,- main_tube_outer_diameter, -main_tube_outer_diameter/2])        
                cube([hull_drop_length, main_tube_outer_diameter, main_tube_outer_diameter]);

        //odečtení spojek trubek
        //666_1004 - přední
        translate([main_tube_outer_diameter*2,-hull_y_size/2,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, hull_y_size, 38 + global_clearance]);

        //666_1004 - zadní
        translate([398,-hull_y_size/2,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, hull_y_size, 38 + global_clearance]);

        //666_1017 - prostředek
        translate([170+68 - (3*main_tube_outer_diameter)/2, - hull_y_size/2, -36/2])        // rozměr v podélné ose zvětšen, aby byla možnost přesněji nastavit těžiště posouváním pilonu po hlavní trubce. 
                cube ([3 * main_tube_outer_diameter, hull_y_size, 36 + global_clearance]);



        //šrouby a matky horní kryt - vždy spojení šroubu a matky dohromady

        //část A
            translate([(top_cover_division[0] + top_cover_division[1])/4, main_tube_outer_diameter/4, -hull_z_size/2])
                rotate([0,45,0])

                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,30])        
                        cylinder(h = Nut_height_M3 + 1, r= Nut_diameter_M3/2, $fn=6);
                    }            
        
        mirror([0,0,1])
            translate([(top_cover_division[0] + top_cover_division[1])/4, main_tube_outer_diameter/4, -hull_z_size/2])
                rotate([0,45,0])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,30])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }            
        

        //část B
            translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){   
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,19])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,19])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2,$fn=6);
                    }
        
        mirror([0,0,1])
            translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){   
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,19])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,19])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);

            }    
        
        //část C    
            translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){    
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,19])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,19])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        mirror([0,0,1])
            translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){    
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,19])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,19])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
                
        //část D        
            translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],main_tube_outer_diameter/4,-50])
                rotate([0,90+beta,0])   
                    union(){
                       cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,14])        
                       cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,14])        
                       cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        mirror([0,0,1])
            translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],main_tube_outer_diameter/4,-50])
                rotate([0,90+beta,0])   
                    union(){
                       cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,14])        
                       cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,14])        
                       cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        //část E       
            translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,main_tube_outer_diameter/4,0])
                rotate([0,90+beta,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,24])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,24])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

        mirror([0,0,1])
            translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,main_tube_outer_diameter/4,0])
                rotate([0,90+beta,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,24])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,24])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        //akumulátory
        translate([move_of_accumulator,- sink_of_accumulator,-height_of_accumulator*1.5])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

        translate([move_of_accumulator,- sink_of_accumulator,height_of_accumulator/2])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);


        //šrouby pro připevnění akumulátorů
        translate([move_of_accumulator - accumulator_holder_thickness/2 - width_cube/2,-50,height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([move_of_accumulator + width_of_accumulator + accumulator_holder_thickness/2 + width_cube/2-1,-50,height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            
        translate([move_of_accumulator - accumulator_holder_thickness/2 - width_cube/2,-50,-height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([move_of_accumulator + width_of_accumulator + accumulator_holder_thickness/2 + width_cube/2-1,-50,-height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        //matka
        translate([move_of_accumulator - accumulator_holder_thickness/2 - width_cube/2,-main_tube_outer_diameter/4,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + accumulator_holder_thickness/2 + width_cube/2-1,-main_tube_outer_diameter/4,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);

        translate([move_of_accumulator - accumulator_holder_thickness/2 - width_cube/2,-main_tube_outer_diameter/4,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + accumulator_holder_thickness/2 + width_cube/2-1,-main_tube_outer_diameter/4,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);

        //připevnění horizontální trubky
        //A
        
        translate([base_division[1]*0.75,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        //B
        translate([base_division[2]*0.5,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        translate([base_division[2]*1.05,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        //C
        translate([base_division[2]*1.25,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        
        //D
        translate([base_division[4]*0.86,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        


        //sloupky pro GPS anténu - matky a otvory pro šrouby

        translate([ hull_x_size-115, - main_tube_outer_diameter, -18])
            union(){
                translate([-((48.01 - 37.48)/2 + 37.48)/2,0,0])    
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                translate([((48.01 - 37.48)/2 + 37.48)/2,0,0])        
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                translate([0,0,((37.78+(48.01-37.48)/2)*sqrt(3))/2])        
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                           
                translate([-((48.01 - 37.48)/2 + 37.48)/2,0,0])    
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);
                translate([((48.01 - 37.48)/2 + 37.48)/2,0,0])        
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);
                translate([0,0,((37.78+(48.01-37.48)/2)*sqrt(3))/2])        
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = Nut_diameter_M3/2, $fn = 6);
            }

//final difference
	}

//final module
}

module 888_1006_part(part_number, draft){ 

    division_position = base_division[part_number];
    previous_division = base_division[part_number - 1];

    part_lenght = division_position - previous_division;

    intersection(){
        888_1006(draft);
            translate([previous_division,-75,-75])                        
                    cube([part_lenght,150,150]);
    }
}



888_1006(draft);

/*
888_1006_part(1,draft);

translate([20,0,0])
888_1006_part(2,draft);

translate([40,0,0])
888_1006_part(3,draft);

translate([60,0,0])
888_1006_part(4,draft);
*/


/*
translate([-hull_wall_thickness,0,0])
888_1004();

translate([-hull_wall_thickness,0,0])
888_1007();
*/
use <888_1000.scad>
use <888_1004.scad>
use <888_1007.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>
