use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1032.scad>



module 666_1027(){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness.    

hole_for_nut_x = 15;
hole_for_nut_y = 50;
hole_for_nut_z = 20;
    
        
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
                        translate ([0,-(main_tube_outer_diameter/2),-hull_z_size/2 + hull_wall_thickness])
                            //v ose y mínus 100 - pro zmenšení kapky na vložku
                            cube ([hull_x_size,hull_y_size - hull_wall_thickness - 100, hull_z_size - 2*hull_wall_thickness - 2*hull_corner_radius]);
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

    //vyříznutí díry pro horizontální trubku
            rotate([0,90,0])
                cylinder(h = hull_drop_length, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 100);
        translate([0,0, -main_tube_outer_diameter/2])        
                cube([hull_drop_length,main_tube_outer_diameter,main_tube_outer_diameter]);
    //díry pro šrouby z horního krytu            
            ///horní kryt část 1
            translate([0,-5,-85])
                rotate([0,45,0])
                    cylinder (h = 70, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([0,-5,85])
                rotate([0,135,0])
                    cylinder (h = 70, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([120,-5,-200/2])
                    cylinder (h = 200, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            
            //horní kryt část 2
            translate([180,-5,-200/2])
                    cylinder (h = 200, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([270,-5,-200/2])
                    cylinder (h = 200, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            
            //horní kryt část 3
            translate([330,-5,-200/2])
                    cylinder (h = 200, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            
            translate([408,-5,-25])
                rotate([0,+90+beta,0])
                    cylinder (h = 70, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([392,-5,-25])
                rotate([0,90-beta,0])
                    cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            
            //horní kryt část 4
            translate([448,-5,0])
                rotate([0,90-beta,0])
                    cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([455,-5,0])
                rotate([0,90+beta,0])
                    cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

            translate([507,-5,0])
                rotate([0,90-beta,0]) 
                    cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
            translate([507,-5,0])
                rotate([0,90+beta,0])   
                    cylinder(h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);


    //díry pro matky
        //horní kryt část 1
    translate([30,-hole_for_nut_y/2,-45])
        rotate([0,45,0])
            cube([hole_for_nut_x,hole_for_nut_y,hole_for_nut_z]);
    translate([45,-hole_for_nut_y/2,30])
        rotate([0,-45,0])        
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    
    translate([120 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/2 - hole_for_nut_z - 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    translate([120 - hole_for_nut_x/2,-hole_for_nut_y/2,- hull_z_size/2 + 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);

        //horní kryt část 2   
    translate([180 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/2 - hole_for_nut_z - 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    translate([180 - hole_for_nut_x/2,-hole_for_nut_y/2,- hull_z_size/2 + 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    
    translate([270 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/2 - hole_for_nut_z - 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    translate([270 - hole_for_nut_x/2,-hole_for_nut_y/2,- hull_z_size/2 + 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);

           //horní kryt část 3
    translate([330 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/2 - hole_for_nut_z - 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);
    translate([330 - hole_for_nut_x/2,-hole_for_nut_y/2,- hull_z_size/2 + 8])       
           cube ([hole_for_nut_x, hole_for_nut_y, hole_for_nut_z]);

    translate([430 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/5 - 5])       
        rotate([0,-beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);
    translate([410 - hole_for_nut_x/2,-hole_for_nut_y/2, - hull_z_size/5])       
        rotate([0,beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);

           //horní kryt část 4
    translate([470 - hole_for_nut_x/2,-hole_for_nut_y/2,hull_z_size/12])       
        rotate([0,-beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);

    translate([460 - hole_for_nut_x/2,-hole_for_nut_y/2,-hull_z_size/12])       
        rotate([0,beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);

    translate([520 - hole_for_nut_x/2,-hole_for_nut_y/2,-3])       
        rotate([0,-beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);

    translate([506 - hole_for_nut_x/2,-hole_for_nut_y/2,3])       
        rotate([0,beta,0])   
           cube ([hole_for_nut_z, hole_for_nut_y, hole_for_nut_x]);



    //prořezy        
        translate([390,-30,-25])
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


    //final difference
    }
//final part
}
666_1027();


