use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>



module 666_1027(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

    
        
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
                            minkowski(){                   
                                translate ([0,-(main_tube_outer_diameter/2),-hull_z_size/2 + hull_wall_thickness])
                                    cube ([hull_x_size,hull_y_size - hull_wall_thickness-110, hull_z_size - 2*hull_wall_thickness]);
                                    rotate ([0,90,0])
                                        cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   
                            }                   
                        }
    //for front part
        translate ([-2,-6 - main_tube_outer_diameter/2,-25])
                cube ([52,hull_y_size+10,50]);

    //for tube in back
        translate ([hull_x_size-70,0,0])
            rotate ([0,90,0])
                cylinder (h = 80, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);
                                    
                            
    //for printing
        translate([hull_x_size-50,-main_tube_outer_diameter,-main_tube_outer_diameter/2])       
                cube([80,main_tube_outer_diameter, main_tube_outer_diameter]);  

    //prořezy        
        translate([330,-30,30])
            rotate([0,0,90])    
                for (i = [0:15]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 19, -20]) // liche prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }

        translate([350,-30,-10])
            rotate([0,0,90])    
                for (i = [0:15]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 19, -20]) // liche prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }

        translate([330,-30,-40])
            rotate([0,0,90])    
                for (i = [0:15]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 19, -20]) // liche prorezy
                            %cube([50, 0.1, 40]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }
    }

}
666_1027();


