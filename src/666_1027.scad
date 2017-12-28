module 666_1027(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

    hole_for_nut_x = 15;
    hole_for_nut_y = 50;
    hole_for_nut_z = 20;
    y_size = 100;
    z_size = 150;
    x_size = 580;
    
   
    width_of_front_part = 63;  

    // lightening holes list
    lightening_hole_size = 15;
    lightening_hole_spacing = 5;

    lightening_grid_list = [
        for (j = [10 : lightening_hole_size + lightening_hole_spacing : x_size], i = [10 : lightening_hole_size + lightening_hole_spacing : y_size]) 
    /*if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) )*/ 
            [j,0, i] ];


    //akumulátor
    width =width_of_accumulator + okraj;
    depth = 20;
    height = height_of_accumulator + 5 - sink_of_accumulator;

    //kostka spojky pro akumulátor, ve které je umístěn otvor pro šroub
    width_cube = 10;
    depth_cube = depth;
    height_cube = 10;   

    //opticalFlow
    width_optical_flow_senzor = 45.5;
    depth_optical_flow_senzor = 10;
    height_optical_flow_senzor = 35;
    sink_of_optical_flow_senzor = depth_optical_flow_senzor - 5; 
    M3_optical_flow_senzor_Z = 30.4;
    M3_optical_flow_senzor_X = 24;
    M3_optical_flow_senzor_Z_alone = 9.1;
    M3_optical_flow_senzor_X_alone = 16.7;

    //translate([move_of_accumulator,hull_corner_radius,-height_of_accumulator])    
        //rotate([270,0,0])
            //888_1001();
    

    union(){
//samotná podložka

    difference(){
        //hollowing skeleton
        translate ([hull_wall_thickness,0,0])
            intersection () {
                resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness], auto=true)
                    rotate ([0,90,0])           
                        rotate_extrude($fn = draft ? 50 : 100)
                            rotate([0,0,90])
                                difference()
                                {

                                  polygon(points = airfoil_data(naca = hull_airfoil_thickness, L = hull_drop_length, N = draft ? 50 : 100)); 
                                  square(hull_drop_length); 
                                }
                translate([0,0,hull_corner_radius])
                minkowski(){                   
                    translate ([0,-main_tube_outer_diameter,-hull_z_size/2 + hull_wall_thickness])
                        //v ose y mínus 100 - pro zmenšení kapky na vložku
                        cube ([hull_x_size,main_tube_outer_diameter, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);
                            rotate ([0,90,0])
                                cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 10 : 100);                   
                }                   
            }
        //for front part
        translate ([0,-6 - main_tube_outer_diameter/2-20,-width_of_front_part/2])
            cube([52, hull_y_size + 10, width_of_front_part]);

        //for tube in back
        translate ([hull_x_size-70,0,0])
            rotate ([0,90,0])
                cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
                            
        //for printing
        translate([hull_x_size-50-30,-main_tube_outer_diameter, -main_tube_outer_diameter/2])       
            cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);  

        //vyříznutí díry pro horizontální trubku
        translate([0,-main_tube_outer_diameter/2,0])    
            rotate([0,90,0])
                cylinder(h = hull_drop_length, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
        translate([0,-main_tube_outer_diameter*1.5, -main_tube_outer_diameter/2])        
                cube([hull_drop_length, main_tube_outer_diameter, main_tube_outer_diameter]);
        


        //odlehčující prořezy        
        /*translate([100,0,-25])
           rotate([0,45,0])    
                for (i = [0:17]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([i * 19, 0, 0])  //sude prorezy
                            cube([15, 50, 15]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                    translate([i * 19, 0, 20]) // liche prorezy
                        cube([15, 50, 15]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                }
            }*/
        
        rotate([0,45,0])
        for (j = lightening_grid_list) {
            translate(j)
                translate([0,-main_tube_outer_diameter*1.5,z_size/2])
                    cube([15, 50, 15]);
        }

        for (i = [10 : lightening_hole_size + 2*lightening_hole_spacing : x_size])
            translate([i,- main_tube_outer_diameter,-z_size/2])
                rotate([0,0,45]) 
                    cube([15, 15, z_size*2]);


        //render()
        // podélné odlehčení 
        translate([0,-main_tube_outer_diameter/2,z_size/4])
            minkowski(){                   
                cube ([hull_x_size, main_tube_outer_diameter/4,main_tube_outer_diameter/2]);
                rotate ([0,90,0])
                    cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
            }




        //odečtení spojek trubek
        //666_1004 - přední
        translate([main_tube_outer_diameter*2,-40,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, 50, 38 + global_clearance]);

        //666_1004 - zadní
        translate([398,-40,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, 50, 38 + global_clearance]);

        //666_1017 - prostředek
        translate([170+68-(main_tube_outer_diameter+2*(main_tube_outer_diameter/5))/2,-40,-36/2])
                cube ([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, 50, 36 + global_clearance]);
              
        //odečtení děr pro lemy

        //lem    
        intersection(){

            //dno
            difference(){
                translate([0,-main_tube_outer_diameter/2 - hull_wall_thickness-0.25,-hull_z_size/2])       
                        cube([hull_x_size, hull_wall_thickness*2+0.5, hull_z_size]);

            //for front part
                translate ([-2,-1 - main_tube_outer_diameter/2,-25])
                        cube ([52,hull_y_size+10,50]);

            //for tube in back
                translate ([hull_x_size-70,-6,0])
                    rotate ([0,90,0])
                        cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

            //kapka pro kapkovitý tvar
                translate ([hull_wall_thickness+2.5+0.5,0,0])
                    intersection () {
                        resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness-5-1, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-1, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-1], auto=true)
                            rotate ([0,90,0])           
                                rotate_extrude($fn = 100)
                                    rotate([0,0,90])
                                        difference()
                                        {

                                          polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 200)); 
                                          square(hull_drop_length); 
                                        }
                        translate([0,0,hull_corner_radius])
                        minkowski(){                   
                            translate ([2.5+0.5,-(main_tube_outer_diameter/2)-2.5-0.5,-hull_z_size/2 + hull_wall_thickness+2.5+0.5])
                                cube ([hull_x_size-5-1,hull_y_size - hull_wall_thickness-5-1, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius-5-1]);
                                rotate ([0,90,0])
                                    cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 10 : 50);                   
                        }                   
                    }
            }       

            //odstranění dna z vnější strany
            translate([0,0,0])
                intersection () {
                    rotate ([0,90,0])           
                        rotate_extrude($fn = 100)
                            rotate([0,0,90])
                                difference(){
                                    polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=draft ? 50 : 100)); 
                                    square(hull_drop_length); 
                                }
                }
            translate([-20,0,hull_corner_radius])
                minkowski(){                   
                    translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
                        cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
            
                    rotate ([0,90,0])
                        cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
                }
        }

    
        //šrouby a matky horní kryt
        //část AA
        translate([30,0,hull_z_size/2-30])
            rotate([0,-45,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,4])        
                            cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,4])        
                            cylinder(h = Nut_height_M3 +1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
        
                    translate([0,-main_tube_outer_diameter/4,0])        
                            cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                }        
        

        translate([5,0,-hull_z_size/2])
           rotate([0,45,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,35])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,35])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                
                    translate([0,-main_tube_outer_diameter/4,0])   
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                } 


        //část A
        //translate([50+50,main_tube_outer_diameter/4,-hull_z_size/2-20])
        translate([100,0,-hull_z_size/2-20])
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
    
                translate([0,- main_tube_outer_diameter/4,30])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
            
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
           }

        translate([100,0,hull_z_size/2-20-2])    
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,10])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
    
                translate([0,- main_tube_outer_diameter/4,10])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            } 

    //část B

        translate([187,0,-hull_z_size/2-20])
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3+1]);
    
                translate([0,- main_tube_outer_diameter/4,30])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
            
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        translate([187,0,hull_z_size/2-20-2])    
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,10])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3+1]);
    
                translate([0,- main_tube_outer_diameter/4,10])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            } 

    //část BB
        translate([262,0,-hull_z_size/2-20])
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
    
                translate([0,- main_tube_outer_diameter/4,30])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
            
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }

        translate([262,0,hull_z_size/2-20-2])    
            union(){ //spojení kvárdu, matky a díry pro šroub
                translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,10])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
    
                translate([0,- main_tube_outer_diameter/4,10])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            } 
    
        //část C
        
        translate([360,0,50])    
            rotate([0,90-beta,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,14])        
                            cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,14])        
                            cylinder(h = Nut_height_M3+1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    translate([0,-main_tube_outer_diameter/4,0])        
                            cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                } 

        translate([360,0,-50])            
            rotate([0,90+beta,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,14])        
                            cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,15])        
                            cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                
                    translate([0,-main_tube_outer_diameter/4,0])        
                            cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                }



        //část D        
        translate([485,0,0])    
            rotate([0,90-beta,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,24])        
                            cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,24])        
                            cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    translate([0,-main_tube_outer_diameter/4,0])        
                            cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                } 

        translate([485,0,0])    
            rotate([0,90+beta,0])
                union(){ //spojení kvárdu, matky a díry pro šroub
                    translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,24])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
        
                    translate([0,- main_tube_outer_diameter/4,25])        
                        cylinder(h = Nut_height_M3 + 1, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    translate([0,-main_tube_outer_diameter/4,0])        
                        cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                }

        //akumulátory
        translate([move_of_accumulator,- sink_of_accumulator,-height_of_accumulator*1.5])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

        translate([move_of_accumulator,- sink_of_accumulator,height_of_accumulator/2])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);


        //šrouby pro připevnění akumulátorů
        translate([move_of_accumulator - okraj/2 - width_cube/2,-50,height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-50,height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            
        translate([move_of_accumulator - okraj/2 - width_cube/2,-50,-height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-50,-height_of_accumulator])
            rotate([270,0,0])
                cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        //matka
        translate([move_of_accumulator - okraj/2 - width_cube/2,-main_tube_outer_diameter/4,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-main_tube_outer_diameter/4,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        translate([move_of_accumulator - okraj/2 - width_cube/2,-main_tube_outer_diameter/4,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-main_tube_outer_diameter/4,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = main_tube_outer_diameter, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


        //připevnění horizontální trubky
        //A
        
        translate([100,-main_tube_outer_diameter/2,0])
        union(){
            translate([0,0, -hull_z_size/2 - 20])           
                cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([0,0, main_tube_outer_diameter])           
                cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

            translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

        }        

        //B
        translate([200,-main_tube_outer_diameter/2,0])
        union(){
            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 6);
        
            translate([-M3_screw_diameter/2,- main_tube_outer_diameter, - hull_z_size/2 - 10])
                    cube([M3_screw_diameter, main_tube_outer_diameter, hull_z_size + 20]);
        }        
        
        translate([275,-main_tube_outer_diameter/2,0])
        union(){
            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 6);
        
            translate([-M3_screw_diameter/2,- main_tube_outer_diameter, - hull_z_size/2 - 10])
                    cube([M3_screw_diameter, main_tube_outer_diameter, hull_z_size + 20]);
        }        

        //C
        translate([375,-main_tube_outer_diameter/2,0])
        union(){
            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 6);
        
            translate([-M3_screw_diameter/2,- main_tube_outer_diameter, - hull_z_size/2 - 10])
                    cube([M3_screw_diameter, main_tube_outer_diameter, hull_z_size + 20]);
        }    
        //D
        translate([470,-main_tube_outer_diameter/2,0])
        union(){
            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            translate([0,0,- hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size + 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 6);
        
            translate([-M3_screw_diameter/2,- main_tube_outer_diameter, - hull_z_size/2 - 10])
                    cube([M3_screw_diameter, main_tube_outer_diameter, hull_z_size + 20]);
        }    

            //šrouby a matky spodní kryt
                //šrouby
    //část A
    translate([40,-30,hull_z_size/2 - 10])
        rotate([-110,0,0])
            union(){    
                    cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
            translate([0,0,18])    
                    cylinder(h = 20, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
            }        
    translate([29,- main_tube_outer_diameter/2  + 2,hull_z_size/2 - 20])  
        rotate([0,53,0])      
            cube([25,40,20]);

    translate([40,-50,-hull_z_size/2])
        rotate([-70,0,0])
            union(){    
                cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
            translate([0,0,40])        
                    cylinder(h = 20, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
            }
    translate([46,- main_tube_outer_diameter/2 + 2,- hull_z_size/2+5])  
        rotate([0,-53,0])      
            cube([25,40,20]);

//umístění OpticalFlow senzoru
    translate([hull_x_size*0.58,- depth_optical_flow_senzor - main_tube_outer_diameter + sink_of_optical_flow_senzor,hull_z_size/8])
        
        union(){    
            translate([0,0,-20])
            cube([width_optical_flow_senzor,depth_optical_flow_senzor,height_optical_flow_senzor+20]);
        //otvory pro šrouby pro připevnění senzoru
        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            rotate([90,0,0])
                cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            rotate([90,0,0])
                cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        
        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            rotate([90,0,0])
                cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,50,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            rotate([90,0,0])
                cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([width_optical_flow_senzor - M3_optical_flow_senzor_X_alone,50, height_optical_flow_senzor - M3_optical_flow_senzor_Z_alone])
            rotate([90,0,0])
                cylinder(h = 80, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        //otvory pro matky
        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,40 + depth_optical_flow_senzor + 10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            rotate([90,0,0])
                cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2,40 + depth_optical_flow_senzor + 10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            rotate([90,0,0])
                cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,40 + depth_optical_flow_senzor + 10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2])    
            rotate([90,0,0])
                cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        translate([(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_X,40 + depth_optical_flow_senzor + 10,(height_optical_flow_senzor - M3_optical_flow_senzor_Z)/2 + M3_optical_flow_senzor_Z])    
            rotate([90,0,0])
                cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
       
        translate([width_optical_flow_senzor - M3_optical_flow_senzor_X_alone,40 + depth_optical_flow_senzor + 10, height_optical_flow_senzor - M3_optical_flow_senzor_Z_alone])
            rotate([90,0,0])
                cylinder (h = 40, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        }
    

           
    //final difference
        }
    
    //final union
    }

//final part
}


module 666_1027A(){
//část 1
//základní dělení pro tisk

   intersection(){
        666_1027();
            translate([0,-75,-75])                        
                    cube([150,150,150]);
    }
}

module 666_1027B(){
//část 2
translate([20,0,0])
//základní dělení pro tisk
    intersection(){
        666_1027();
            translate([150,-75,-75])                        
                    cube([150,150,150]);
    }
}            


module 666_1027C(){        
//část 3        
translate([40,0,0])
//základní dělení pro tisk
    intersection(){
        666_1027();
            translate([300,-60,-75])                        
                cube([150,150,150]);
    }
}

module 666_1027D(){
//část 4
translate([60,0,0])
//základní dělení pro tisk
    intersection(){
        666_1027();
            translate([450,-60,-75])                        
               cube([150,150,150]);
    }
}

666_1027();

//666_1027A();
//666_1027B();
//666_1027C();
//666_1027D();

use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>
use <666_1004.scad>
use <666_1026.scad>
use <888_1001.scad>