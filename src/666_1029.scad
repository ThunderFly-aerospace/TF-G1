/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;


module 666_1029(draft){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge

    union(){
        difference(){
            union(){
                intersection(){
                    drop_skin(draft);
                translate([0,-hull_y_size,-hull_z_size/2])
                    cube([hull_drop_length, hull_y_size, hull_z_size]); 
                }
                //lem
                intersection(){
                    difference(){
                        translate([0,- hull_wall_thickness,-hull_z_size/2])       
                                cube([hull_x_size, hull_wall_thickness, hull_z_size]);
                        //odebrání dna
                        translate([ribbon_width,0,0])
                                hollowing_skeleton(ribbon_width, draft);

                    }
                        //odstranění z vnější strany krytu
                        drop(draft);
                }
            }
        
        //holes for undercarriage
            translate([main_tube_outer_diameter*2 + coupling_wall_thickness,- thickness_between_tubes - main_tube_outer_diameter,- hull_z_size/2 - 20])
                union(){    
                    translate([main_tube_outer_diameter/2,0,0])
                            cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
                    
                    //zkosení
                    translate([15,main_tube_outer_diameter + 2*hull_wall_thickness,15 + 15 + hull_wall_thickness])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
                    translate([- 15 + sqrt(15),main_tube_outer_diameter + 2*hull_wall_thickness,15 + 15 + hull_wall_thickness])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
            
                    translate([15,main_tube_outer_diameter + 2*hull_wall_thickness, + sqrt(15) + ribbon_width+ hull_z_size])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
                    translate([- 15 + sqrt(15),main_tube_outer_diameter + 2*hull_wall_thickness,sqrt(15) + hull_z_size + ribbon_width])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
                }
            
            union(){
            translate([second_undercarriage_hole,-thickness_between_tubes- main_tube_outer_diameter,-hull_z_size/2 - 20])
                    cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
            translate([second_undercarriage_hole - main_tube_outer_diameter/2,-thickness_between_tubes- main_tube_outer_diameter,-hull_z_size/2 - 20])
                    cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
            
                    //zkosení
                    translate([second_undercarriage_hole + sqrt(15) - hull_wall_thickness,- thickness_between_tubes + 2*hull_wall_thickness,15 + 15 + 15 + hull_wall_thickness*4])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
                    translate([-15 - 15 + 15/2 + second_undercarriage_hole,- thickness_between_tubes + 2*hull_wall_thickness,15 + 15 + sqrt(15) + ribbon_width + 15 + 3*hull_wall_thickness])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
            
                    translate([ + second_undercarriage_hole, - thickness_between_tubes + 2*hull_wall_thickness, - hull_z_size/2 + sqrt(15) + sqrt(15) + 15 +hull_wall_thickness*2])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
                    translate([-15 - sqrt(15) - 15/2 + second_undercarriage_hole + sqrt(15),- thickness_between_tubes + 2*hull_wall_thickness,sqrt(15) + ribbon_width - hull_z_size/2 + 15 - ribbon_width])
                        rotate([0,45,0])
                            cube([15,2*hull_wall_thickness,15]);
            }

            //hollow front
            translate ([- global_clearance,- main_tube_outer_diameter/2 - global_clearance -thickness_between_tubes,- width_of_engine_holder/2])
                    cube([top_cover_division[1] + global_clearance,hull_y_size+10,width_of_engine_holder]);

        //for tube in back
            translate ([hull_x_size-70,0,0])
                rotate ([0,90,0])
                    cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 50 : 100);


        //šrouby pro připevnění k 666_1027
        //A
            translate([bottom_screw_position[1],-main_tube_outer_diameter/4, -hull_z_size/2 - 13])
                rotate([0,45,0])
                   cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        mirror([0,0,1])
            translate([bottom_screw_position[1], -main_tube_outer_diameter/4, -hull_z_size/2 - 13])
                rotate([0,45,0])
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([bottom_screw_position[2], - main_tube_outer_diameter/4, - hull_z_size/2 - 35])       
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        mirror([0,0,1])
            translate([bottom_screw_position[2], - main_tube_outer_diameter/4, - hull_z_size/2 - 35])       
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        //D
            union(){
            translate([+ bottom_screw_position[3],-main_tube_outer_diameter/4,+49])
                rotate([0,-angle_base_bottom,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([bottom_screw_position[4],-main_tube_outer_diameter/4,+35])
                rotate([0,-angle_base_bottom,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        mirror([0,0,1])
            union(){
            translate([bottom_screw_position[3],-main_tube_outer_diameter/4,+49])
                rotate([0,-angle_base_bottom,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([bottom_screw_position[4],-main_tube_outer_diameter/4,+35])
                rotate([0,-angle_base_bottom,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        /*
        //E     
            union(){
            translate([bottom_screw_position[5],-main_tube_outer_diameter/4,20])
                rotate([0,90-beta,0])   
                    %cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
            translate([bottom_screw_position[6],-main_tube_outer_diameter/4,5])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }
        mirror([0,0,1]) 
            %union(){
            translate([bottom_screw_position[5],-main_tube_outer_diameter/4,20])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([bottom_screw_position[6],-main_tube_outer_diameter/4,5])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            
            }
            */

        //šrouby mezi 2 a 3
        translate([bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness - M3_screw_diameter])
          rotate([0,99,0])
                union(){
                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                translate([0,0,22 - Nut_height_M3 - 5])    
                        cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                translate([-20,- Nut_diameter_M3/2,22 - 5 - Nut_height_M3])
                        cube([20,Nut_diameter_M3, Nut_height_M3]);
                translate([0,0,-25])   
                        cylinder(h = 30, r = Nut_diameter_M3/2, $fn = 6);
                }


        mirror([0,0,1])
        translate([bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness - M3_screw_diameter ])
            rotate([0,99,0])
                union(){
                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                translate([0,0,22 - Nut_height_M3 - 5])    
                        cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                translate([-20,- Nut_diameter_M3/2,22 - 5 - Nut_height_M3])
                        cube([20,Nut_diameter_M3, Nut_height_M3]);
                translate([0,0,-25])   
                        cylinder(h = 30, r = Nut_diameter_M3/2, $fn = 6);
                }


//final difference
        }

        //výztuhy
        intersection(){
            union(){
                difference(){
                    union(){

                        //odečtení díry pro šrouby mezi díly 2 a 3
                        difference(){
                                union(){
                                translate([bottom_cover_division[2] - hull_wall_thickness, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                                        cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                                translate([bottom_cover_division[2], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                                        cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                                }
                                
                                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness - M3_screw_diameter])
                                    rotate([0,99,0])
                                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20); 
                                mirror([0,0,1])  
                                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness - M3_screw_diameter])
                                    rotate([0,99,0])
                                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20); 

                        }   

                        //čtverce pro slepení dílů - rantly
                        translate([bottom_cover_division[1] - hull_wall_thickness, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        translate([bottom_cover_division[3], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        translate([bottom_cover_division[4], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        //podélná výztuha
                        translate([bottom_cover_division[1],-hull_y_size/3, -hull_z_size/2])
                            cube([bottom_cover_division[3] - bottom_cover_division[1], hull_wall_thickness,hull_z_size]);
                        
                    }
                //dutý tvar
                translate([ribbon_width,0,0])
                    hollowing_skeleton(ribbon_width, draft);
        
                    }
                
                //pro uzavření dílu 2 a 3
                   
                   //přepážka díl B   
                    union(){          
                        translate([bottom_cover_division[1], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                        
                        /*translate([bottom_cover_division[1],- hull_y_size/1.5,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);
                        translate([bottom_cover_division[1],- hull_y_size/6,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);
                        translate([bottom_cover_division[1],- hull_y_size/3,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);
                        translate([bottom_cover_division[1],- hull_y_size/2,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);*/
                   

                        translate([bottom_cover_division[1], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness, hull_z_size/9])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[1], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness, hull_z_size/3])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[1], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness,- hull_z_size/9])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[1], - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness,- hull_z_size/3])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                    }

                    //přepážka díl C
                    union(){
                        translate([bottom_cover_division[3] - hull_wall_thickness, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                        
                        /*translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width,- hull_y_size/6,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);
                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width,- hull_y_size/3,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);
                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width,- hull_y_size/2,- hull_z_size/2])
                            cube([ribbon_width, hull_wall_thickness, hull_z_size]);*/

                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness, hull_z_size/9])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness, hull_z_size/3])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness,- hull_z_size/9])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                        translate([bottom_cover_division[3] - hull_wall_thickness - ribbon_width, - hull_y_size - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness,- hull_z_size/3])
                            cube([ribbon_width, hull_y_size, hull_wall_thickness]);
                    }  

                    //uzavření seshora + výztuhy
                    /*
                    union(){

                        translate([bottom_cover_division[1],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2,-hull_z_size/2])  
                            cube([bottom_cover_division[3] - bottom_cover_division[1], hull_wall_thickness, hull_z_size]);

                        translate([bottom_cover_division[1],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width,-hull_z_size/3])  
                            cube([bottom_cover_division[3] - bottom_cover_division[1], ribbon_width, hull_wall_thickness]);

                        translate([bottom_cover_division[1],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width,-hull_z_size/9])  
                            cube([bottom_cover_division[3] - bottom_cover_division[1], ribbon_width, hull_wall_thickness]);
               
                        translate([bottom_cover_division[1],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width,hull_z_size/9])  
                            cube([bottom_cover_division[3] - bottom_cover_division[1], ribbon_width, hull_wall_thickness]);
                
                        translate([bottom_cover_division[1],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width, hull_z_size/3])  
                            cube([bottom_cover_division[3] - bottom_cover_division[1], ribbon_width, hull_wall_thickness]);

                        translate([bottom_cover_division[2] - hull_wall_thickness,- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width, - hull_z_size/2])
                            cube([hull_wall_thickness, ribbon_width, hull_z_size]);
                    
                        translate([bottom_cover_division[2],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width, - hull_z_size/2])
                            cube([hull_wall_thickness, ribbon_width, hull_z_size]);
                    }
                    */
            }
            //odstranění z vnější strany
            drop(draft);
        }
    //šrouby mezi díly 2 a 3

        intersection(){
            translate([bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness  - global_clearance])
                difference(){
                    translate([-20,0,0])
                    rotate([0,90,0])
                        union(){
                                    cylinder(h = main_tube_outer_diameter*1.5, r = 10, $fn = draft ? 100 : 200);
                            translate([0,0,-20])
                                    cylinder (h = 20, r1 = 0, r2 = 10, $fn = draft ? 100 : 200);
                            translate([0,0,main_tube_outer_diameter*1.5])
                                    cylinder (h = 20, r1 = 10, r2 = 0, $fn = draft ? 100 : 200);
                        }

                    translate([0,0,-M3_screw_diameter])
                    rotate([0,99,0])
                        union(){
                                    cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                            translate([0,0,22 - Nut_height_M3 - 5])    
                                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                            translate([-20,- Nut_diameter_M3/2,22 - 5 - Nut_height_M3 ])
                                    cube([20,Nut_diameter_M3, Nut_height_M3]);
                            translate([0,0,-25])   
                                    cylinder(h = 30, r = Nut_diameter_M3/2, $fn = 6);

                        }
                }
            
            drop(draft);

        //intersection
        }

    mirror([0,0,1])
        intersection(){
            translate([bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - hull_wall_thickness - global_clearance ])
                difference(){
                    translate([-20,0,0])
                    rotate([0,90,0])
                        union(){
                                    cylinder(h = main_tube_outer_diameter*1.5, r = 10, $fn = draft ? 100 : 200);
                            translate([0,0,-20])
                                    cylinder (h = 20, r1 = 0, r2 = 10, $fn = draft ? 100 : 200);
                            translate([0,0,main_tube_outer_diameter*1.5])
                                    cylinder (h = 20, r1 = 10, r2 = 0, $fn = draft ? 100 : 200);
                        }
                    translate([0,0,-M3_screw_diameter])
                    rotate([0,99,0])
                        union(){
                                    cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                            translate([0,0,22 - Nut_height_M3 - 5])    
                                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                            translate([-20,- Nut_diameter_M3/2,22 - 5 - Nut_height_M3])
                                    cube([20,Nut_diameter_M3, Nut_height_M3]);
                            translate([0,0,-25])   
                                    cylinder(h = 30, r = Nut_diameter_M3/2, $fn = 6);
                        }
                }
            
            drop(draft);

        //intersection
        }

        //vyztužení otvorů pro podvozkové nohy - určeno k odstranění
        //přední
        translate([0,0,0.3])
            intersection(){
                translate([main_tube_outer_diameter*2 + coupling_wall_thickness, - main_tube_outer_diameter * 0.9,- hull_z_size/2])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter * 0.9, 0.6]);
                drop(draft);
            }
        translate([0,0,-0.3])
            intersection(){       
                translate([main_tube_outer_diameter + coupling_wall_thickness, - main_tube_outer_diameter*0.9, hull_z_size/2 - hull_wall_thickness/2])
                        cube ([main_tube_outer_diameter*2, main_tube_outer_diameter * 0.9, 0.6]);
            drop_skin(hull_wall_thickness, draft);
            }

        //zadní
        translate([0,0,0.3])
            intersection(){      
                translate([second_undercarriage_hole - main_tube_outer_diameter/2, - main_tube_outer_diameter * 0.9, - hull_z_size/2 + 5])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter*0.9, 20]);
                drop_skin(hull_wall_thickness, draft);
            }

        translate([0,0,-0.3])
            intersection(){
                translate([second_undercarriage_hole - main_tube_outer_diameter/2, - main_tube_outer_diameter * 0.9,  hull_z_size/2 - 20])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter*0.9 ,20]);
                drop_skin(hull_wall_thickness, draft);
            }

//final union
    }
//final module
}


//tisk

module 666_1029_A(draft){
    union(){
        intersection(){
                666_1029(draft);
            translate([0, - hull_y_size, -hull_z_size/2])
                cube([bottom_cover_division[1] - bottom_cover_division[0], hull_y_size, hull_z_size]);
        }
    }
}

module 666_1029_B(draft){
    translate([20,0,0])
    union(){
        intersection(){
                666_1029(draft);
            translate([bottom_cover_division[1], - hull_y_size, - hull_z_size/2])
                cube([bottom_cover_division[2] - bottom_cover_division[1], hull_y_size, hull_z_size]);
        }
    }    
}

module 666_1029_C(draft){
    translate([40,0,0])
    union(){
        intersection(){
                666_1029(draft);
            translate([bottom_cover_division[2], - hull_y_size, - hull_z_size/2])
                cube([bottom_cover_division[3] - bottom_cover_division[2], hull_y_size, hull_z_size]);    
        }
    }
}

module 666_1029_D(draft){
    translate([60,0,0])
        union(){
            intersection(){
                    666_1029(draft);
                translate([bottom_cover_division[3] + global_clearance/100, -hull_y_size,- hull_z_size/2])   //přidána tolerance global_clearance/100 pro odstranění zbytku rantlu od protichůdného dílu pro tisk    
                    cube([bottom_cover_division[4] - bottom_cover_division[3] - 2*global_clearance/100, hull_y_size, hull_z_size]);    
            }

            //zámky přidané 
            union(){
                intersection(){
                    drop_skin(draft);   
            
                    union(){
                       //čtverec pro zámek horní
                        translate([bottom_cover_division[4] - hull_wall_thickness,  - main_tube_outer_diameter*5, -lock_width/2])
                                    cube([lock_length, hull_y_size, lock_width]);
                            //čtverec pro zámek Z+
                            translate([bottom_cover_division[4] - hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness, main_tube_outer_diameter ])
                                    cube([lock_length, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([bottom_cover_division[4] - hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness, - hull_z_size - main_tube_outer_diameter])
                                   cube([lock_length, lock_width, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky
                }   

        }
}            

module 666_1029_E(draft){
    translate([80,0,0])

    difference(){
        intersection(){
                666_1029(draft);
            translate([bottom_cover_division[4], - hull_y_size, - hull_z_size/2])
                cube([bottom_cover_division[5] - bottom_cover_division[4], hull_y_size, hull_z_size]);
        }
        //zámky odečtené
                union(){
                    intersection(){
                        drop_skin(draft);   
                    
                        union(){
                       //čtverec pro zámek horní
                        translate([bottom_cover_division[4] - hull_wall_thickness,  - main_tube_outer_diameter*5, -lock_width/2 - global_clearance/2])
                                    cube([lock_length + global_clearance/2, hull_y_size, lock_width + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([bottom_cover_division[4] - hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3* hull_wall_thickness - global_clearance/2, main_tube_outer_diameter ])
                                    cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([bottom_cover_division[4] - hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness - global_clearance/2, - hull_z_size - main_tube_outer_diameter])
                                   cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                        //union
                        }   
                    //intersection
                    }
                //union zámky
                }   
    }    
}





//666_1029_A(draft);

//666_1029_B(draft);

//666_1029_C(draft);

//666_1029_D(draft);

//666_1029_E(draft);


666_1029(draft);




use <888_1000.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>