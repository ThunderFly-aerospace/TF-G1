use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1025.scad>

module 666_1032(){

    airfoil_thickness = 0030;
    depth = main_tube_outer_diameter*2;
    width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
    height = depth;

    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 


    difference (){

    	airfoil(naca = airfoil_thickness, L = 170, N=101, h = 195, open = false);
    	translate ([hull_wall_thickness,0,-5])
            resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness,(170*airfoil_thickness/100)- 2*hull_wall_thickness,210], auto=true) 
                airfoil(naca = airfoil_thickness, L = 170, N=101, h = 200, open = false);

    	//pro otevření
    	translate ([150,-0.5,-3])
    	   cube ([10,1,201]);

    	translate ([35,-depth/2-3,195-height])
    	   cube ([width*5,depth+6,height+3]);

        // hull shell from 666_1025.scad
        translate ([-180,0,0])
            rotate ([90,0,0])
                intersection () {
                    rotate ([0,90,0])           
                        rotate_extrude($fn = 100)
                            rotate([0,0,90])
                                difference()
                                {

                                  polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=100)); 
                                  square(hull_drop_length); 
                                }

                    minkowski(){                   
                        translate ([0,-(main_tube_outer_diameter/2)+1,-hull_z_size/2])
                            cube ([hull_x_size,hull_y_size,hull_z_size]);
                            rotate ([0,90,0])
                                cylinder (h = 1, r = hull_corner_radius, $fn = 100);                   

                    }
                }
    }
}

666_1032();