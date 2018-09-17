/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;


////// otvory pro šrouby pro připevnění k dílu 666_1027
module screw_bottom (position_number,draft){
            //funkce

            distance_bottom = - hull_drop_length * surface_distance(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
            echo (distance_bottom);

        if (position_number > 1 && position_number < 3)
        {

            if (distance_bottom <= - maximum_printable_size/2)
            {
                distance_bottom = - maximum_printable_size/2;

                translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,- hull_z_size/2])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            
            //final if
            }
            
            else
            {
                distance_bottom = distance_bottom;

                translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,- hull_z_size])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            
            //final if
            }

        //final if
        }
        else
        {

            if (distance_bottom <= - maximum_printable_size/2)
            {
                distance_bottom = - maximum_printable_size/2;
                
                translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,distance_bottom])
                    rotate([0,surface_angle(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            
            //fianl if
            }
            
            else
            {
                distance_bottom = distance_bottom;
               
                translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,distance_bottom])
                    rotate([0,surface_angle(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            //final if
            }

        //final if
        }

//final module
}


/////////////////////////////////////////
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
                    translate([second_undercarriage_hole ,- thickness_between_tubes + 2*hull_wall_thickness,hull_z_size/2 - sqrt(15)*6 - hull_wall_thickness*2])
                        rotate([0,45,0])
                           %cube([15,2*hull_wall_thickness,15]);
                    translate([-15 - 15 + 15/2 + second_undercarriage_hole,- thickness_between_tubes + 2*hull_wall_thickness,15 + 15 + sqrt(15) + ribbon_width + 15 + 3*hull_wall_thickness])
                        rotate([0,45,0])
                          % cube([15,2*hull_wall_thickness,15]);
            
                    translate([ + second_undercarriage_hole, - thickness_between_tubes + 2*hull_wall_thickness, - hull_z_size/2 + sqrt(15) + sqrt(15) + 15 +hull_wall_thickness*2])
                        rotate([0,45,0])
                           % cube([15,2*hull_wall_thickness,15]);
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

        for (position_number = [1:4])
        {
                screw_bottom(position_number, draft);
            mirror([0,0,1])
                screw_bottom(position_number, draft);
        }


        //šrouby mezi 2 a 3

        translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length *surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
          rotate([0,90 +  2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                union(){
                        cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
                translate([0,0,- Nut_height_M3 - 5])
                    rotate([0,0,90])    
                        cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                translate([-20,- Nut_diameter_M3/2,- Nut_height_M3 - 5])
                        cube([20,Nut_diameter_M3, Nut_height_M3]);
                translate([0,0,2])   
                        cylinder(h = 30, r = Nut_diameter_M3/2, $fn = draft ? 100 : 200);
                }


        mirror([0,0,1])
        translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length *surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
          rotate([0,90 + 2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                union(){
                        cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
                translate([0,0,- Nut_height_M3 - 5])
                    rotate([0,0,90])    
                        cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                translate([-20,- Nut_diameter_M3/2,- Nut_height_M3 - 5])
                        cube([20,Nut_diameter_M3, Nut_height_M3]);
                translate([0,0,2])   
                        cylinder(h = 30, r = Nut_diameter_M3/2, $fn = draft ? 100 : 200);
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
                                
                                translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length *surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                                    rotate([0,90 + 2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                                        cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
                                mirror([0,0,1])  
                                translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length *surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                                    rotate([0,90 + 2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                                        cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
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
                        
                        //vyztužení dílu A
                        difference(){

                        union(){ 

                            union(){

                            translate([0,- hull_wall_thickness,width_of_engine_holder/2])       // výztuha v přední části krytu
                                rotate([50,0,0])
                                    cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);

                            translate([0, - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2, main_tube_outer_diameter/2 + thickness_between_tubes + hull_wall_thickness + global_clearance/2])    
                                rotate([55,0,0])
                                   cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);
                            
                            translate([0,-main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2,0])       // výztuha v přední části krytu
                                rotate([65,0,0])
                                    cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);
                            }

                        translate([0,-main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2,0])
                            rotate([90,0,0])
                                cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);


                        mirror([0,0,1])

                            union(){

                            translate([0,- hull_wall_thickness,width_of_engine_holder/2])       // výztuha v přední části krytu
                                rotate([50,0,0])
                                    cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);

                            translate([0, - main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2, main_tube_outer_diameter/2 + thickness_between_tubes + hull_wall_thickness + global_clearance/2])    
                                rotate([55,0,0])
                                   cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);
                            
                            translate([0,-main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2,0])       // výztuha v přední části krytu
                                rotate([65,0,0])
                                    cube([bottom_cover_division[1], hull_wall_thickness, hull_z_size]);

                            }
                        // final union výztuhy v části A
                        }
                            
                            //odstranění zásahu výztuh do otvorů podvozkové trubky
                        translate([main_tube_outer_diameter*2 + coupling_wall_thickness,- thickness_between_tubes - main_tube_outer_diameter,- hull_z_size/2 - 20])
                            union(){    
                                translate([main_tube_outer_diameter/2,0,0])
                                        cylinder (h = hull_z_size+40, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                                            cube ([main_tube_outer_diameter, 2*main_tube_outer_diameter, hull_z_size+40]);
                            }

                        //final difference výztuhy v části A
                        }

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

                        translate([bottom_cover_division[2] - hull_wall_thickness,- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width, - hull_z_size/2])
                            cube([hull_wall_thickness, ribbon_width, hull_z_size]);
                    
                        translate([bottom_cover_division[2],- main_tube_outer_diameter/2 - thickness_between_tubes - hull_wall_thickness - global_clearance/2 - ribbon_width, - hull_z_size/2])
                            cube([hull_wall_thickness, ribbon_width, hull_z_size]);
                    }
            }
            //odstranění z vnější strany
            drop(draft);
        }
    //šrouby mezi díly 2 a 3

        intersection(){
            union(){
                difference(){
                    translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 3, - main_tube_outer_diameter, hull_drop_length * surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                        rotate([180,0,0])
                            union(){
                                translate([17,8,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 20, r = 18, $fn = draft ? 100 : 200);
                                            translate([0,0,20])    
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                        }
                                mirror([1,0,0])
                                translate([21,8,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 15, r = 18, $fn = draft ? 100 : 200);
                                            translate([0,0,15])    
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                        }
                            }
                    translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length * surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                        rotate([0,90 + 2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            union(){
                                    cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
                            translate([0,0,- Nut_height_M3 - 5])
                                rotate([0,0,90])    
                                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                            translate([-20,- Nut_diameter_M3/2,- Nut_height_M3 - 5])
                                    cube([20,Nut_diameter_M3, Nut_height_M3]);
                            translate([0,0,2])   
                                    cylinder(h = 30, r = Nut_diameter_M3/2, $fn = draft ? 100 : 200);
                            }
                }
            }

            drop(draft);

        //intersection
        }

    mirror([0,0,1])
        intersection(){
            union(){
                difference(){
                    translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 3, - main_tube_outer_diameter, hull_drop_length * surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                        rotate([180,0,0])
                            union(){
                                translate([17,8,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 20, r = 18, $fn = draft ? 100 : 200);
                                            translate([0,0,20])    
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                        }
                                mirror([1,0,0])
                                translate([21,8,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 15, r = 18, $fn = draft ? 100 : 200);
                                            translate([0,0,15])    
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                                sphere (r = 18,$fs = 0.5, $fa = 10);
                                        }
                            }

                    translate([hull_drop_length * (bottom_cover_division[2]/hull_drop_length) + 2, - main_tube_outer_diameter, hull_drop_length * surface_distance(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 26])
                        rotate([0,90 + 2*surface_angle(x = bottom_cover_division[2]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            union(){
                                    cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);   
                            translate([0,0,- Nut_height_M3 - 5])
                                rotate([0,0,90])    
                                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                            translate([-20,- Nut_diameter_M3/2,- Nut_height_M3 - 5])
                                    cube([20,Nut_diameter_M3, Nut_height_M3]);
                            translate([0,0,2])   
                                    cylinder(h = 30, r = Nut_diameter_M3/2, $fn = draft ? 100 : 200);
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
                translate([main_tube_outer_diameter*2 + coupling_wall_thickness, - main_tube_outer_diameter * 0.9,- hull_z_size/2 - 10])
                    cube ([main_tube_outer_diameter, main_tube_outer_diameter * 0.9, 20]);
                drop_skin(hull_wall_thickness, draft);
            }
        translate([0,0,-0.3])
            intersection(){       
                translate([main_tube_outer_diameter*2 + coupling_wall_thickness, - main_tube_outer_diameter*0.9, hull_z_size/2 - 10])
                   cube ([main_tube_outer_diameter, main_tube_outer_diameter * 0.9, 20]);
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
use <888_1003.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>