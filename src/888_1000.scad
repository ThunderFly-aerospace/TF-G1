/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/
//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

//vnitřní kapka
module hollowing_skeleton(shell_thickness = hull_wall_thickness, draft = true)
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    intersection(){

    resize([hull_drop_length - shell_thickness - trailing_wall* shell_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*shell_thickness, (hull_drop_length*hull_airfoil_thickness/100) - 2*shell_thickness], auto=true)
            rotate ([0,90,0])
            rotate_extrude($fn = draft ? 50 : 200)
                rotate([0,0,90])
                    difference()
                    {
                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 200));
                      square(hull_drop_length);
                    }

      translate([0,0,hull_corner_radius])
        minkowski(){
            translate ([0,- hull_y_size , - hull_z_size/2 + shell_thickness])
                cube ([hull_x_size,2*hull_y_size - shell_thickness, hull_z_size - 2*shell_thickness - 2*hull_corner_radius]);
                rotate ([0,90,0])
                    cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);
          }

    }
}

module hollowing_skeleton_hem(ribbon_width, draft)
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    intersection () {
    resize([hull_drop_length - ribbon_width - trailing_wall* ribbon_width, (hull_drop_length*hull_airfoil_thickness/100) - 2*ribbon_width, (hull_drop_length*hull_airfoil_thickness/100) - 2*ribbon_width], auto=true)
            rotate ([0,90,0])
            rotate_extrude($fn = draft ? 50 : 200)
                rotate([0,0,90])
                    difference()
                    {
                      polygon(points = airfoil_data(naca=hull_airfoil_thickness, L = hull_drop_length, N=draft ? 50 : 200));
                      square(hull_drop_length);
                    }

      translate([0,0,hull_corner_radius])
        minkowski(){
            translate ([0,- hull_y_size, - hull_z_size/2 + ribbon_width])
                cube ([hull_x_size,2*hull_y_size - ribbon_width, hull_z_size - 2*ribbon_width - 2*hull_corner_radius]);
                rotate ([0,90,0])
                    cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);
          }

    }
}




//celá kapka
module drop(draft = true)
{

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

	intersection () {
    	rotate ([0,90,0])
        	rotate_extrude($fn = draft ? 50 : 200)
                    rotate([0,0,90])
                        difference()
                        {
	                        polygon(points = airfoil_data(naca=hull_airfoil_thickness, L =hull_drop_length , N=draft ? 50 : 200));
    	                    square(hull_drop_length);
        	            }

        translate([0,0,hull_corner_radius])
          	minkowski(){
             	translate ([0,-hull_y_size,-hull_z_size/2])
             			cube ([hull_x_size, 2*hull_y_size,hull_z_size-2*hull_corner_radius]);
             	  	rotate ([0,90,0])
                 		cylinder (h = 1, r = hull_corner_radius, $fn = draft ? 50 : 100);
		    }

	}
}


//základní kapka
module drop_skin(draft = true){

	difference(){
		drop(draft);
		translate([hull_wall_thickness,0,0])
			hollowing_skeleton(hull_wall_thickness, draft);
	}

}




drop_skin();














use <./lib/naca4.scad>
include <../parameters.scad>
