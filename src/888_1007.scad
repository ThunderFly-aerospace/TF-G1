draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1007(){

width=main_tube_outer_diameter+4*coupling_wall_thickness;
depth=width;
height= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;

//666_1017
translate([0,0,+ coupling_wall_thickness + main_tube_outer_diameter + thickness_between_tubes])
	rotate([180,0,0])
		
		difference () {
			translate([-(width/2),-(width/2),0])
	   				cube ([width,depth,height]);
    		//vertical tube
    		translate ([0,0, - thickness_between_tubes])
        			cylinder(h = height - coupling_wall_thickness - main_tube_outer_diameter,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

			//screws
 			translate([- 2.5 * main_tube_outer_diameter,0,27.5])
        		rotate([0,90,0])
            		cylinder(h = 5*main_tube_outer_diameter, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 			translate([- 2.5 * main_tube_outer_diameter,0,7.5])
        		rotate([0,90,0])
            		cylinder(h = 5*main_tube_outer_diameter, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
		}

//666_1026
translate([0,0, + height_of_vertical_tube - 2*main_tube_outer_diameter + coupling_wall_thickness + main_tube_outer_diameter + thickness_between_tubes])
   difference (){

        translate([-(width/2),-main_tube_outer_diameter,0])
            cube ([width,2*main_tube_outer_diameter,height]);
    	
    	//tube
    	translate([0,0,- global_clearance])
    	   cylinder(h = 2*main_tube_outer_diameter + global_clearance,r = main_tube_outer_diameter/2,$fn = draft ? 100 : 200);

    	//screw
    	translate([0,2.5 * main_tube_outer_diameter,7.5])
    	   rotate([90,0,0])
    	       cylinder(h= 5 *main_tube_outer_diameter, r = M4_screw_diameter/2, $fn = draft ? 10 :20);


    	translate([0,2.5 * main_tube_outer_diameter,42.5])
    	   rotate([90,0,0])
    	       cylinder(h = 5 * main_tube_outer_diameter, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
    	
    }

//trubka
//cylinder (h = height_of_vertical_tube, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);



//final module
}


888_1007();

use <./lib/naca4.scad>
include <../Parameters.scad>