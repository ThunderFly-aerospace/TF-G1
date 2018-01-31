/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;

/*
//výpočty pro odlehčení závisející na šířce kapky - počítáme počet čtverečků

B = 5;       //B = šířka mezery    2 -< B -< 6
A = 15;      //A = šířka uhlopříčky čtverečku    10 -< A -< 20
X = (hull_drop_length/hull_airfoil_thickness)*100;
Z = A * sqrt(2)


C = (X-B)/(A+B)  //počet čtverečků pro odlehčení
C = Floor(C);
echo (C);
*/


module lightening(x_size, y_size, z_size){        // generování dutin pro snížení hmotnosti podložky

    // lightening holes list
    lightening_hole_size = 15;
    lightening_hole_spacing = 5;

    lightening_grid_list = [
        for (j = [10 : lightening_hole_size + lightening_hole_spacing : x_size], i = [10 : lightening_hole_size + lightening_hole_spacing : y_size]) 
    /*if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) )*/ 
            [j,0, i] ];


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
    //translate([0,-main_tube_outer_diameter/2,z_size/4])
    /*    minkowski(){                   
            cube ([hull_x_size, main_tube_outer_diameter/4,main_tube_outer_diameter/2]);
            rotate ([0,90,0])
                cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);                   
        }*/
        //cube ([hull_x_size, main_tube_outer_diameter/4,main_tube_outer_diameter]);
}

//pouze příčné odlehčení
module lightening_pricne (x_size, y_size, z_size){

       lightening_hole_size = 15;
    lightening_hole_spacing = 5;

    lightening_grid_list = [
        for (j = [10 : lightening_hole_size + lightening_hole_spacing : x_size], i = [10 : lightening_hole_size + lightening_hole_spacing : y_size]) 
    /*if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) )*/ 
            [j,0, i] ];


        rotate([0,45,0])
    for (j = lightening_grid_list) {
        translate(j)
            translate([0,-main_tube_outer_diameter*1.5,z_size/2])
                cube([15, 50, 15]);
    }
}

module 666_1027(draft){

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
                
                union(){                   
                    translate ([0,- main_tube_outer_diameter - thickness_between_tubes, -hull_z_size/2 + hull_wall_thickness])
                        cube([hull_x_size, main_tube_outer_diameter + coupling_wall_thickness + thickness_between_tubes, hull_z_size - 2*hull_wall_thickness - 2 * global_clearance ]);

                    translate([hull_x_size - 115 - hull_wall_thickness, 0, -18])
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
            }
        //for front part
        translate ([0,-6 - main_tube_outer_diameter/2 - 20, (-width_of_engine_holder + 2*hull_wall_thickness + 2*global_clearance)/2])
            cube([52, hull_y_size + 10, width_of_engine_holder + 2*hull_wall_thickness + 2*global_clearance]);

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
        

/*
        //odlehčující prořezy        
        translate([0,0,0])
            lightening(x_size, y_size, z_size);
        translate([112,0,30])
            lightening_pricne (x_size, y_size, z_size);
        //translate([224,0,30])
            //lightening_pricne (x_size, y_size, z_size);
        translate([-112,0,0])
            lightening_pricne (x_size, y_size, z_size);
        */
        //odečtení spojek trubek
        //666_1004 - přední
        translate([main_tube_outer_diameter*2,-40,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, 50, 38 + global_clearance]);

        //666_1004 - zadní
        translate([398,-40,-38/2])
                cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5) + global_clearance, 50, 38 + global_clearance]);

        //666_1017 - prostředek
        translate([170+68 - (3*main_tube_outer_diameter)/2, -40, -36/2])        // rozměr v podélné ose zvětšen, aby byla možnost přesněji nastavit těžiště posouváním pilonu po hlavní trubce. 
                cube ([3 * main_tube_outer_diameter, 50, 36 + global_clearance]);
              
        //odečtení děr pro lemy

        //lem    
        intersection(){

            //dno
            difference(){
                translate([0,- hull_wall_thickness - global_clearance/2 - main_tube_outer_diameter/2,-hull_z_size/2])       
                        cube([hull_x_size, hull_wall_thickness*2 + global_clearance, hull_z_size]);

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

        //šrouby a matky horní kryt - vždy spojení šroubu a matky dohromady

        //část A
            translate([(top_cover_division[0] + top_cover_division[1])/4, -main_tube_outer_diameter/4, -hull_z_size/2])
                rotate([0,45,0])

                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,30])        
                        cylinder(h = Nut_height_M3 + 1, r= Nut_diameter_M3/2, $fn=6);
                    }            
        
        mirror([0,0,1])
            //translate([(top_cover_division[0] + top_cover_division[1])/4, -main_tube_outer_diameter/4, -hull_z_size/2])
                rotate([0,45,0])
                    union(){
                        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,30])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,30])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }            
        

        //část B
            translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],-main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){   
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,hull_z_size/2 - 50])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,hull_z_size/2-50])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2,$fn=6);
                    }
        
        mirror([0,0,1])
            translate([(top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],-main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){   
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,hull_z_size/2 - 50])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,hull_z_size/2-50])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);

            }    
        
        //část C    
            translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],-main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){    
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,hull_z_size/2 - 50])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,hull_z_size/2-50])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        mirror([0,0,1])
            translate([(top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],-main_tube_outer_diameter/4,-hull_z_size/2-15])
                    union(){    
                        cylinder(h = hull_z_size+30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,hull_z_size/2 - 50])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,hull_z_size/2-50])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
                
        //část D        
            translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,-50])
                rotate([0,90+beta,0])   
                    union(){
                       cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,14])        
                       cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,14])        
                       cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        mirror([0,0,1])
            translate([(top_cover_division[4] - top_cover_division[3])/2 + top_cover_division[3],-main_tube_outer_diameter/4,-50])
                rotate([0,90+beta,0])   
                    union(){
                       cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,14])        
                       cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,14])        
                       cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        //část E       
            translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
                rotate([0,90+beta,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,24])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,24])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

        mirror([0,0,1])
            translate([(top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - 20,-main_tube_outer_diameter/4,0])
                rotate([0,90+beta,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,24])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3 + 1]);
                    translate([0,0,24])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        
    //šrouby a matky spodní kryt - vždy spojení šroubu a matky dohromady
            
    //A
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15,-main_tube_outer_diameter*(3/4), -hull_z_size/2])
                rotate([0,45,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,hull_z_size/2 - 35])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,hull_z_size/2-35])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }


        mirror([0,0,1])
            translate([(bottom_cover_division[0] + bottom_cover_division[1])/15, -main_tube_outer_diameter*(3/4), -hull_z_size/2])
                rotate([0,45,0])
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,40])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,40])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }
        
                    

            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter*(3/4), - hull_z_size/2 - 10])       
                    union (){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,25])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,25])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

        mirror([0,0,1])
            translate([bottom_cover_division[1]/1.1, - main_tube_outer_diameter*(3/4), - hull_z_size/2 - 10])       
                    union (){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,25])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,25])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }





        //D
            union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
                rotate([0,90-beta,0])   
                    union(){        
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,5])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,5])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,10])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,10])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    } 
            }
    
        mirror([0,0,1])
            union(){
            translate([(bottom_cover_division[4] - bottom_cover_division[3])/10 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+50])
                rotate([0,90-beta,0])   
                    union(){        
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,5])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,5])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

            translate([(bottom_cover_division[4] - bottom_cover_division[3])/1.3 + bottom_cover_division[3],-main_tube_outer_diameter*(3/4),+30])
                rotate([0,90-beta,0])   
                    union(){
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,10])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,10])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    } 
            }

        //E     
            translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
                rotate([0,90-beta,0])   
                    union(){        
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,17])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,17])        
                        cylinder(h = Nut_height_M3 + 1, r = Nut_diameter_M3/2, $fn=6);
                    }

        mirror([0,0,1])
            translate([(bottom_cover_division[5] - bottom_cover_division[4])/2 + bottom_cover_division[4],-main_tube_outer_diameter*(3/4),0])
                rotate([0,90-beta,0])   
                    union(){        
                        cylinder(h = 50, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                    translate([- Nut_diameter_M3/2,0,17])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+30,Nut_height_M3 + 1]);
                    translate([0,0,17])        
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
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        translate([275,-main_tube_outer_diameter/2,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        //C
        translate([375,-main_tube_outer_diameter/2,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        
        //D
        translate([470,-main_tube_outer_diameter/2,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])           
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);

                translate([0,0, - hull_z_size - main_tube_outer_diameter])           
                    cylinder(h = hull_z_size, r = Nut_diameter_M3/2, $fn = 6);
            }        

        //sloupky pro GPS anténu - matky a otvory pro šrouby

        translate([ hull_x_size-115, - main_tube_outer_diameter - 5, -18])
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

    //final union
    }

//final part
}

module 666_1027_part(part_number, draft){ 

    division_position = base_division[part_number];
    previous_division = base_division[part_number - 1];

    part_lenght = division_position - previous_division;

    intersection(){
        666_1027(draft);
            translate([previous_division,-75,-75])                        
                    cube([part_lenght,150,150]);
    }
}

666_1027(draft);

/*666_1027_part(1,draft);
666_1027_part(2,draft);
666_1027_part(3,draft);
666_1027_part(4,draft);
*/

//666_1025();
//666_1029();


use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>
use <666_1004.scad>
use <666_1026.scad>
use <888_1001.scad>
use <666_1025.scad>
use <666_1029.scad>