use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>
use <666_1004.scad>
use <666_1026.scad>
use <888_1001.scad>



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

width_of_accumulator = 134+1;//45+1;
depth_of_accumulator = 41.5+1;
height_of_accumulator = 45+1;
sink_of_accumulator = main_tube_outer_diameter/4 - Nut_height_M3*1.5;
move_of_accumulator = 160;

okraj = 18;
width =width_of_accumulator + okraj;
depth = 20;
height = height_of_accumulator + 5 - sink_of_accumulator;




width_cube = 10;
depth_cube = depth;
height_cube = 3;    

translate([move_of_accumulator,hull_corner_radius,-height_of_accumulator])    
    rotate([270,0,0])
        888_1001();

union(){
//samotná podložka
    difference(){
                //hollowing skeleton
               translate ([hull_wall_thickness,0,0])
                intersection () {
                    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness], auto=true)
                        rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=200)); 
                                      square(hull_drop_length); 
                                    }
                    translate([0,0,hull_corner_radius])
                    minkowski(){                   
                        translate ([0,-main_tube_outer_diameter,-hull_z_size/2 + hull_wall_thickness])
                            //v ose y mínus 100 - pro zmenšení kapky na vložku
                            cube ([hull_x_size,main_tube_outer_diameter, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);
                                rotate ([0,90,0])
                                    cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
                    }                   
                }
    //for front part
        translate ([-2,-6 - main_tube_outer_diameter/2-20,- width_of_front_part/2])
                cube ([52,hull_y_size+10,width_of_front_part]);

    //for tube in back
        translate ([hull_x_size-70,0,0])
            rotate ([0,90,0])
                cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
                            
    //for printing
        translate([hull_x_size-50-30,-main_tube_outer_diameter,-main_tube_outer_diameter/2])       
                cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);  

    //vyříznutí díry pro horizontální trubku
        translate([0,-main_tube_outer_diameter/2,0])    
            rotate([0,90,0])
                cylinder(h = hull_drop_length, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 100);
        translate([0,-main_tube_outer_diameter*1.5, -main_tube_outer_diameter/2])        
                cube([hull_drop_length,main_tube_outer_diameter,main_tube_outer_diameter]);
    
    //díra pro lem           




    //prořezy        
        translate([390,-40,-25])
           rotate([0,0,90])    
                for (i = [0:17]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            cube([60, 0.1, 65]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                        else{
                        translate([0, i * 19, -20]) // liche prorezy
                            cube([60, 0.1, 65]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }

    //odečtení spojek trubek
    
    //666_1004 - přední
    translate([main_tube_outer_diameter*2,-40,-38/2])
            cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5),50,38]);
    
    //666_1004 - zadní
    translate([398,-40,-38/2])
            cube([main_tube_outer_diameter+2*(main_tube_outer_diameter/5),50,38]);

    //666_1017 - prostředek
    translate([170+68-(main_tube_outer_diameter+2*(main_tube_outer_diameter/5))/2,-40,-36/2])
            cube ([main_tube_outer_diameter+2*(main_tube_outer_diameter/5),50,36]);
          
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
                            cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

                //kapka pro kapkovitý tvar
                    translate ([hull_wall_thickness+2.5+0.5,0,0])
                intersection () {
                    resize([hull_drop_length - hull_wall_thickness - trailing_wall* hull_wall_thickness-5-1, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-1, (hull_drop_length*hull_airfoil_thickness/100) - 2*hull_wall_thickness-5-1], auto=true)
                        rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference()
                                    {

                                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=200)); 
                                      square(hull_drop_length); 
                                    }
                    translate([0,0,hull_corner_radius])
                    minkowski(){                   
                        translate ([2.5+0.5,-(main_tube_outer_diameter/2)-2.5-0.5,-hull_z_size/2 + hull_wall_thickness+2.5+0.5])
                            cube ([hull_x_size-5-1,hull_y_size - hull_wall_thickness-5-1, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius-5-1]);
                            rotate ([0,90,0])
                                cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
                    }                   
                }

                }       

            //odstranění dna z vnější strany
                translate([0,0,0])
                    intersection () {
                        rotate ([0,90,0])           
                            rotate_extrude($fn = 100)
                                rotate([0,0,90])
                                    difference()
                                    {
                                    polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
                                    square(hull_drop_length); 
                                    }
                    }
                translate([-20,0,hull_corner_radius])
                    minkowski(){                   
                        translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
                                cube ([hull_x_size, hull_y_size,hull_z_size-2*hull_corner_radius]);
                
                            rotate ([0,90,0])
                                cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
                    }
        }

    
        //šrouby a matky
            //část AA
            
            
            translate([30,0,hull_z_size/2-30])
                rotate([0,-45,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,5])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,5])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
            
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

                    }        
            

            translate([5,0,-hull_z_size/2])
               rotate([0,45,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,35])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,35])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    
                         translate([0,-main_tube_outer_diameter/4,0])   
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    } 


            //část A
            //translate([50+50,main_tube_outer_diameter/4,-hull_z_size/2-20])
                translate([100,0,-hull_z_size/2-20])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,35])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,35])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                   }

                translate([100,0,hull_z_size/2-15])    
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,5])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,5])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    } 

            //část B

                translate([225,0,-hull_z_size/2-20])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,35])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,35])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                   }

                translate([225,0,hull_z_size/2-15])    
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,5])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,5])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    } 


            //část C
            
            translate([360,0,50])    
                rotate([0,90-beta,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,15])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,15])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    } 

            translate([360,0,-50])            
                rotate([0,90+beta,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,15])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,15])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                    
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 40, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                   }



            //část D        
            translate([485,0,0])    
                rotate([0,90-beta,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,25])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,25])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    } 

            translate([485,0,0])    
                rotate([0,90+beta,0])
                    union(){ //spojení kvárdu, matky a díry pro šroub
                        translate([- Nut_diameter_M3/2,- main_tube_outer_diameter/4,25])        
                                cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
            
                        translate([0,- main_tube_outer_diameter/4,25])        
                                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);
                        translate([0,-main_tube_outer_diameter/4,0])        
                                cylinder(h = 50, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
                    }
    
    //akumulátory
    translate([move_of_accumulator,- sink_of_accumulator,-height_of_accumulator*1.5])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

    translate([move_of_accumulator,- sink_of_accumulator,height_of_accumulator/2])  
            cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);


    //šrouby pro připevnění akumulátorů
    translate([move_of_accumulator - okraj/2 - width_cube/2,-50,height_of_accumulator])
        rotate([270,0,0])
            cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

    translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-50,height_of_accumulator])
        rotate([270,0,0])
            cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
        
    translate([move_of_accumulator - okraj/2 - width_cube/2,-50,-height_of_accumulator])
        rotate([270,0,0])
            cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

    translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-50,-height_of_accumulator])
        rotate([270,0,0])
            cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

        //matka
        translate([move_of_accumulator - okraj/2 - width_cube/2,-main_tube_outer_diameter - 3,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-main_tube_outer_diameter-3,height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

        translate([move_of_accumulator - okraj/2 - width_cube/2,-main_tube_outer_diameter - 3,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
    
        translate([move_of_accumulator + width_of_accumulator + okraj/2 + width_cube/2-1,-main_tube_outer_diameter-3,-height_of_accumulator])
            rotate([90,0,0])
               cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


//připevnění horizontální trubky
translate([100,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);

translate([150,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);

translate([200,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);

translate([280,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);

translate([330,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);

translate([380,-main_tube_outer_diameter-2,-main_tube_outer_diameter/2-5])        
        %cube([10,2,main_tube_outer_diameter+10]);


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
     //základní dělení pro tisk
        translate([20,0,0])    
            intersection(){
                666_1027();
                    translate([150,-75,-75])                        
                            cube([150,150,150]);
            }
}            


module 666_1027C(){        
//část 3        
    //základní dělení pro tisk
        translate([40,0,0])
            intersection(){
                666_1027();
                    translate([300,-60,-75])                        
                        cube([150,150,150]);
            }
}

module 666_1027D(){
//část 4
    //základní dělení pro tisk
        translate([60,0,0])
            intersection(){
                666_1027();
                    translate([450,-60,-75])                        
                       cube([150,150,150]);
            }
}

666_1027();
