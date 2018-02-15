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
            intersection(){
                drop_skin(draft);
                translate([0,-hull_y_size,-hull_z_size/2])
                    cube([hull_drop_length, hull_y_size, hull_z_size]); 
            }

        //holes for undercarriage
            translate([main_tube_outer_diameter*2 + coupling_wall_thickness,- thickness_between_tubes - main_tube_outer_diameter,- hull_z_size/2 - 20])
                union(){    
                    translate([main_tube_outer_diameter/2,0,0])
                            cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
                }
            
            translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness, - thickness_between_tubes - main_tube_outer_diameter, - hull_z_size/2 - 20])
                union(){
                    translate([main_tube_outer_diameter/2,0,0])
                            cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
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
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15 + 5,-main_tube_outer_diameter/4, -hull_z_size/2 - 13])
                rotate([0,45,0])
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        mirror([0,0,1])
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15 + 5, -main_tube_outer_diameter/4, -hull_z_size/2 - 13])
                rotate([0,45,0])
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter/4, - hull_z_size/2 - 35])       
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        mirror([0,0,1])
            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter/4, - hull_z_size/2 - 35])       
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        //D
            union(){
            translate([+ bottom_cover_division[3],-main_tube_outer_diameter/4,+52])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([+ bottom_cover_division[3] + bottom_cover_division[1]/2,-main_tube_outer_diameter/4,+38])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        mirror([0,0,1])
            union(){
            translate([bottom_cover_division[3],-main_tube_outer_diameter/4,+52])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([ + bottom_cover_division[3] + bottom_cover_division[1]/2,-main_tube_outer_diameter/4,+38])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        //E     
            union(){
            translate([bottom_cover_division[4],-main_tube_outer_diameter/4,20])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
            translate([bottom_cover_division[4] + bottom_cover_division[1]/2,-main_tube_outer_diameter/4,5])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }
        mirror([0,0,1]) 
            union(){
            translate([+ bottom_cover_division[4],-main_tube_outer_diameter/4,20])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            translate([+ bottom_cover_division[4] + bottom_cover_division[1]/2,-main_tube_outer_diameter/4,5])
                rotate([0,90-beta,0])   
                    cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            
            }

        //šrouby mezi 2 a 3
        translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
            union(){
                translate([-1,0,0]) 
                    rotate([0,90,0])
                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                    rotate([0,-80,0])   
                        cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
            translate([20,0,0])
                mirror([1,0,0])
                    rotate([0,-80,0])   
                        cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
            }

        mirror([0,0,1])
        translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
            union(){
                translate([-1,0,0]) 
                    rotate([0,90,0])
                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                    rotate([0,-80,0])   
                        cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
            translate([20,0,0])
                mirror([1,0,0])
                    rotate([0,-80,0])   
                        cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
            }


//final difference
        }

        //lem
        union(){
            intersection(){
                difference(){
                    translate([0,- hull_wall_thickness,-hull_z_size/2])       
                            cube([hull_x_size, hull_wall_thickness, hull_z_size]);
                    
                    //for front part
                    translate ([-global_clearance,-1 - main_tube_outer_diameter/2,- width_of_engine_holder/2])
                            cube([top_cover_division[1] + global_clearance,hull_y_size+10,width_of_engine_holder]);
                    
                     //for tube in back
                    translate ([hull_x_size-70,0,0])
                        rotate ([0,90,0])
                            cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

                    translate ([hull_x_size-35,-16,10])
                        rotate([0,190,0])
                            cube([40,30,hull_wall_thickness*5]);
                    translate ([hull_x_size-75,-16,-17])
                        rotate([0,-10,0])
                            cube([40,30, 5*hull_wall_thickness]);
                    
                    //holes for undercarriage            

                    translate([main_tube_outer_diameter*2 + coupling_wall_thickness,- thickness_between_tubes - main_tube_outer_diameter,- hull_z_size/2 - 20])
                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
            
                    translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness, - thickness_between_tubes - main_tube_outer_diameter, - hull_z_size/2 - 20])
                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);


                    //odebrání dna
                    translate([ribbon_width,0,0])
                            hollowing_skeleton(ribbon_width, draft);

                }
                //odstranění z vnější strany krytu
                drop(draft);
            }
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
                                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
                                    rotate([0,90,0])
                                        cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                            mirror([0,0,1])
                                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
                                    rotate([0,90,0])
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
                    }

            }
            //odstranění z vnější strany
            drop(draft);
        }
    //šrouby mezi díly 2 a 3
    
        intersection(){
            union(){
                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
    
                    difference(){
        
                        union(){
                            translate([-1,0,0]) 
                                rotate([0,90,0])
                                    cylinder(h = 22, r = M3_screw_diameter/2 + 2, $fn = draft ? 10 : 20);   
                            translate([11,0,-1]) 
                                rotate([0,-81,0])   
                                    cylinder(h = 60, r = Nut_diameter_M3, $fn = draft ? 10 : 20); 
                        translate([9,0,-1])
                            mirror([1,0,0])
                                rotate([0,-81,0])   
                                    cylinder(h = 60, r = Nut_diameter_M3, $fn = draft ? 10 : 20); 
                        }
        
                        union(){
                            translate([-1,0,0]) 
                                rotate([0,90,0])
                                    cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                                rotate([0,-81,0])   
                                    cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
                        translate([20,0,0])
                            mirror([1,0,0])
                                rotate([0,-81,0])   
                                    cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
                        }
        
                    }
            }
            
            drop(draft);

        //intersection
        }

    mirror([0,0,1])
        intersection(){
            union(){
                translate([ bottom_cover_division[2] - 10,- main_tube_outer_diameter,hull_z_size/2 - M3_screw_diameter/1.2])
    
                    difference(){
        
                        union(){
                            translate([-1,0,0]) 
                                rotate([0,90,0])
                                    cylinder(h = 22, r = M3_screw_diameter/2 + 2, $fn = draft ? 10 : 20);   
                            translate([11,0,0]) 
                                rotate([0,-81,0])   
                                    cylinder(h = 60, r = Nut_diameter_M3, $fn = draft ? 10 : 20); 
                        translate([9,0,0])
                            mirror([1,0,0])
                                rotate([0,-81,0])   
                                    cylinder(h = 60, r = Nut_diameter_M3, $fn = draft ? 10 : 20); 
                        }
        
                        union(){
                            translate([-1,0,0]) 
                                rotate([0,90,0])
                                    cylinder(h = 22, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);   
                                rotate([0,-81,0])   
                                    cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
                        translate([20,0,0])
                            mirror([1,0,0])
                                rotate([0,-81,0])   
                                    cylinder(h = 22, r = Nut_diameter_M3/2, $fn = draft ? 10 : 20); 
                        }
                    }
            }
            
            drop(draft);

        //intersection
        }

        //vyztužení otvorů pro podvozkové nohy - určeno k odstranění
        //přední
        translate([0,0,0.3])
            intersection(){
                translate([main_tube_outer_diameter*2 + coupling_wall_thickness, - main_tube_outer_diameter,- hull_z_size/2])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, 0.6]);
                drop_skin(hull_wall_thickness, draft);
            }
        translate([0,0,-0.3])
            intersection(){       
                translate([main_tube_outer_diameter*2 + coupling_wall_thickness, - main_tube_outer_diameter, hull_z_size/2 - hull_wall_thickness/2])
                        cube ([main_tube_outer_diameter, main_tube_outer_diameter, 0.6]);
                drop_skin(hull_wall_thickness, draft);
            }

        //zadní
        translate([0,0,0.3])
            intersection(){      
                translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness, - main_tube_outer_diameter, - hull_z_size/2 + 5])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter, 20]);
                drop_skin(hull_wall_thickness, draft);
            }

        translate([0,0,-0.3])
            intersection(){
                translate([second_undercarriage_hole - main_tube_outer_diameter/2 - coupling_wall_thickness, - main_tube_outer_diameter,  hull_z_size/2 - 20])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter,20]);
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
            difference(){
                intersection(){
                        666_1029(draft);
                    translate([bottom_cover_division[3], -hull_y_size,- hull_z_size/2])
                        cube([bottom_cover_division[4] - bottom_cover_division[3], hull_y_size, hull_z_size]);    
                }

                //pro odstranění zbytku rantlu od protichůdného dílu pro tisk    
                intersection(){
                        hollowing_skeleton(hull_wall_thickness,draft);
                    translate([bottom_cover_division[4] - 2* hull_wall_thickness, - hull_y_size - main_tube_outer_diameter/2, - hull_z_size/2])
                        cube([4*hull_wall_thickness, hull_y_size, hull_z_size]);
                }

                intersection(){
                        hollowing_skeleton(hull_wall_thickness,draft);
                    translate([bottom_cover_division[3] - 2* hull_wall_thickness, - hull_y_size - main_tube_outer_diameter/2, - hull_z_size/2])
                        cube([4*hull_wall_thickness, hull_y_size, hull_z_size]);
                }
            }   

            //zámky přidané    
            union(){
                intersection(){
                    drop_skin(draft);   
            
                    union(){
                       //čtverec pro zámek horní
                        translate([bottom_cover_division[4]- 2*hull_wall_thickness,  - main_tube_outer_diameter*5, -lock_width/2])
                                    cube([hull_wall_thickness*3, hull_y_size, lock_width]);
                            //čtverec pro zámek Z+
                            translate([bottom_cover_division[4] - 2*hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness, main_tube_outer_diameter ])
                                    cube([hull_wall_thickness*3, lock_width, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([bottom_cover_division[4] - 2*hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness, - hull_z_size - main_tube_outer_diameter])
                                    cube([hull_wall_thickness*3, lock_width, hull_z_size]);
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
            translate([hull_wall_thickness,0,0])
                union(){
                    intersection(){
                        drop_skin(draft);   
                    
                        union(){
                       //čtverec pro zámek horní
                        translate([bottom_cover_division[4]- 2*hull_wall_thickness,  - main_tube_outer_diameter*5, -lock_width/2 - global_clearance/2])
                                    cube([hull_wall_thickness*3, hull_y_size, lock_width + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([bottom_cover_division[4] - 2*hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3* hull_wall_thickness - global_clearance/2, main_tube_outer_diameter ])
                                    cube([hull_wall_thickness*3, lock_width + global_clearance, hull_z_size]);
                            //čtverec pro zámek Z-
                            translate([bottom_cover_division[4] - 2*hull_wall_thickness, - main_tube_outer_diameter/2 - thickness_between_tubes - lock_width - 3*hull_wall_thickness - global_clearance/2, - hull_z_size - main_tube_outer_diameter])
                                    cube([hull_wall_thickness*3, lock_width + global_clearance, hull_z_size]);
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

666_1029_C(draft);

//666_1029_D(draft);

//666_1029_E(draft);


//666_1029(draft);




use <888_1000.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>