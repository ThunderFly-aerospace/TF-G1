

draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 666_1032(draft){

    airfoil_thickness = 0030;
    depth = main_tube_outer_diameter*2;
    width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
    height = depth;

    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 

    difference (){
        union(){

            difference(){
            	airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes, open = false);
            	translate ([hull_wall_thickness,0,45])
                    resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*airfoil_thickness/100)- 2*hull_wall_thickness,height_of_vertical_tube + main_tube_outer_diameter/2 + 4*global_clearance + thickness_between_tubes], auto=true) 
                           color([1,0,0])

                        airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = 10, open = false);
            }
            //lem spodní a horní díl
            intersection(){
                difference(){
                    translate([0,-75,cover_pilon_division[1] - hull_wall_thickness])
                            cube([190,150,2*hull_wall_thickness]);

                    translate ([ribbon_width,0,45])
                        resize([170 - ribbon_width - trailing_wall*ribbon_width,(170*airfoil_thickness/100)- 2*ribbon_width,210], auto=true) 
                            airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance, open = false);
                }
                airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + coupling_wall_thickness, open = false);
            }


        //pro připevnění Pitotovo trubice
            intersection(){
                difference(){
                    translate([0,-main_tube_outer_diameter*0.75,cover_pilon_division[1] + main_tube_outer_diameter*3])
                        intersection(){
                                cylinder(h = main_tube_outer_diameter*1.5, r1 = 1, r2 = main_tube_outer_diameter, $fn = draft ? 100 : 200);
                            translate([-main_tube_outer_diameter,-14,-main_tube_outer_diameter])
                                cube([main_tube_outer_diameter*2,20,main_tube_outer_diameter*3]);
                        }

                    translate([main_tube_outer_diameter*0.5,0,cover_pilon_division[1] + main_tube_outer_diameter*4.2])
                        rotate([90,0,0])
                            union(){
                                cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 :20);
                            translate([0,0,18 - M3_nut_height])
                                cylinder(h = M3_nut_height * 3, r = M3_nut_diameter/2, $fn = draft ? 10:20);
                            }
                }      

            airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes, open = false);
            }

        // pro připevnění k vertikální trubce
            intersection(){
            union(){
                //spodní kužele
                difference(){
                    union(){
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2, - main_tube_outer_diameter - hull_wall_thickness, cover_pilon_division[1] - cover_pilon_division[1]/4 - 0.6*main_tube_outer_diameter/3])
                            cylinder (h = main_tube_outer_diameter, r1 = main_tube_outer_diameter, r2 = 1, $fn = draft ? 100 : 200);
                    
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,  main_tube_outer_diameter + hull_wall_thickness, cover_pilon_division[1] - cover_pilon_division[1]/4 - 0.6*main_tube_outer_diameter/3])
                            cylinder (h = main_tube_outer_diameter, r1 = main_tube_outer_diameter, r2 = 1, $fn = draft ? 100 : 200);
                   
                    }
                    
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,hull_y_size/2, cover_pilon_division[1] - cover_pilon_division[1]/4])
                        rotate([90,0,0])
                            union(){               
                                cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
                            translate([0,0,hull_y_size/4 + M4_nut_height])
                                cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                            translate([0,0,hull_y_size*0.75 - 3* M4_nut_height])
                                cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                            }
                //odečtení trubky
                translate ([main_pilon_position - cover_pilon_position + 2*hull_wall_thickness,0,0])
                    color([1,0,0])
                        cylinder (h = height_of_vertical_tube, r = main_tube_outer_diameter/2, $fn = 200);
                //odstranění špičatých konců    
                translate([main_pilon_position - cover_pilon_position - main_tube_outer_diameter + hull_wall_thickness*2, - main_tube_outer_diameter/4,0])
                        cube([main_tube_outer_diameter*2, main_tube_outer_diameter/2,340]);



                }
                
                //horní kužele
                difference(){
                    union(){
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2, - main_tube_outer_diameter - hull_wall_thickness,cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75 - 2.3*main_tube_outer_diameter/3])
                            cylinder (h = main_tube_outer_diameter, r1 = 1, r2 = main_tube_outer_diameter, $fn = draft ? 100 : 200);
                    
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,  main_tube_outer_diameter + hull_wall_thickness, cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75 - 2.3*main_tube_outer_diameter/3])
                            cylinder (h = main_tube_outer_diameter, r1 = 1, r2 = main_tube_outer_diameter, $fn = draft ? 100 : 200);
                   
                    }
                    
                    translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,hull_y_size/2,cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75])
                        rotate([90,0,0])
                            union(){
                                    cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
                            translate([0,0,hull_y_size/4 + M4_nut_height])
                                    cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                            translate([0,0,hull_y_size*0.75 - 3* M4_nut_height])
                                    cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                            }
                //odečtení trubky
                translate ([main_pilon_position - cover_pilon_position + 2*hull_wall_thickness,0,0])
                    color([1,0,0])
                        cylinder (h = height_of_vertical_tube, r = main_tube_outer_diameter/2, $fn = 200);
                //odstranění špičatých konců    
                translate([main_pilon_position - cover_pilon_position - main_tube_outer_diameter + hull_wall_thickness*2, - main_tube_outer_diameter/4,0])
                        cube([main_tube_outer_diameter*2, main_tube_outer_diameter/2,340]);

                //difference
                }

            //union    
            }
                
                airfoil(naca = airfoil_thickness, L = 170, N = draft ? 50 : 100, h = height_of_vertical_tube + main_tube_outer_diameter/2 + 2*global_clearance + thickness_between_tubes, open = false);
            //intersection
            }

                    //translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2, - main_tube_outer_diameter - hull_wall_thickness,cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75 - 2*main_tube_outer_diameter/3])
                      //     % cylinder (h = main_tube_outer_diameter, r1 = 1, r2 = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);
                   /// cube ([])
        //final union
        }
    	//pro otevření
    	translate ([120,- hull_wall_thickness/2,- 2*global_clearance])
    	   cube ([60,hull_wall_thickness,height_of_vertical_tube + 4*global_clearance]);

      // výřez pro rotorovou hlavu
    	translate ([main_tube_outer_diameter + coupling_wall_thickness*2, -depth/2 - global_clearance, height_of_vertical_tube - main_tube_outer_diameter*2 - 2*global_clearance + main_tube_outer_diameter/2 + thickness_between_tubes])
            cube ([width*5,depth + 2*global_clearance, height + global_clearance + main_tube_outer_diameter]);


        // hull shell from 666_1025.scad
        translate ([ - cover_pilon_position,0,0])
            rotate ([90,0,0])
                drop(draft);

        //otvory pro připevnění Pitotovo trubice
                    translate([main_tube_outer_diameter*0.5,0,cover_pilon_division[1] + main_tube_outer_diameter*4.2])
            rotate([90,0,0])
                union(){
                            cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 :20);
                    translate([0,0,18 - M3_nut_height])
                            cylinder(h = M3_nut_height*3, r = M3_nut_diameter/2, $fn = draft ? 10:20);
                    //otvor pro trubici
                    translate([-30, - Distance_hole_from_tube + Pitot_tube_diameter/2,8])
                        rotate([0,90,0])
                            cylinder(h = 60, r = Pitot_tube_diameter/2, $fn = draft ? 10 : 20);
                }

       //otvory pro připevnění k vertikální trubce
        translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,hull_y_size/2, cover_pilon_division[1] - cover_pilon_division[1]/4])
            rotate([90,0,0])
                union(){               
                        cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([0,0,hull_y_size/4 + M4_nut_height])
                        cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                    translate([0,0,hull_y_size*0.75 - 3* M4_nut_height])
                        cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                }

        translate([main_pilon_position - cover_pilon_position + hull_wall_thickness*2,hull_y_size/2, cover_pilon_division[2] - (cover_pilon_division[2] - cover_pilon_division[1])*0.75])
            rotate([90,0,0])
                union(){
                        cylinder(h = hull_y_size, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([0,0,hull_y_size/4 + M4_nut_height])
                        cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                    translate([0,0,hull_y_size*0.75 - 3* M4_nut_height])
                        cylinder(h = M4_nut_height*2, r = M4_nut_diameter/2, $fn = 6);
                }

    //final difference
    }

/*
//jen pro kontrolu, zda se vejde v pohodě vertikální trubka
            difference(){
        translate ([main_pilon_position - cover_pilon_position,0,0])
                color([1,0,0])
                cylinder (h = height_of_vertical_tube, r = Help_main_tube_outer/2, $fn = 200);

        translate ([main_pilon_position - cover_pilon_position,0,0])
                color([1,0,0])
               % cylinder (h = height_of_vertical_tube + global_clearance, r = Help_main_tube_inner/2, $fn = 200);

        }
*/
//final module
}


//pro tisk

module 666_1032_A(draft){
        intersection(){
                666_1032(draft);
            translate([0,- 75,0])
                cube([180,150,cover_pilon_division[1]]);
        }
}

module 666_1032_B(draft){
    translate([0,0,20])
        intersection(){
                666_1032(draft);
            translate([0,- 75,cover_pilon_division[1]])
                cube([180,150,cover_pilon_division[2] - cover_pilon_division[1]]);
        }
}

666_1032(draft);
//666_1032_A(draft);
//666_1032_B(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>
use <888_1000.scad>