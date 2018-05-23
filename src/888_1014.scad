draft = true;


module 888_1014(){





difference(){
	union(){
	translate([-main_tube_outer_diameter, -2* main_tube_outer_diameter,- coupling_wall_thickness])
			color([0,0,0.5])
				cube([2*main_tube_outer_diameter,4*main_tube_outer_diameter, length_of_main_tube]);
	translate([-main_tube_outer_diameter,main_tube_outer_diameter/2 + thickness_between_tubes,-2*main_tube_outer_diameter + main_pilon_position])
			color([0,0,0.5])
				cube([2*main_tube_outer_diameter,height_of_vertical_tube,4*main_tube_outer_diameter]);

	}
	union(){

			cylinder(h = length_of_main_tube + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);
	translate([0,height_of_vertical_tube + thickness_between_tubes + main_tube_outer_diameter/2 + global_clearance, main_pilon_position])	
		rotate([90,0,0])	
			cylinder(h = height_of_vertical_tube + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

	}		
	//šrouby 666_1026
			union(){
				translate([0,coupling_depth_666_1026*2 + global_clearance/2,7.5])
		           rotate([90,0,0])
		               cylinder(h = coupling_depth_666_1026*4+ global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

		        translate([0,coupling_depth_666_1026*2 + global_clearance/2,42.5])
		           rotate([90,0,0])
		               cylinder(h = coupling_depth_666_1026*4 + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
			}
	//šrouby 666_1004
	translate([0,0,2*main_tube_outer_diameter])
			union(){
			 	translate([-coupling_width_666_1004*2 - global_clearance/2,0,height_666_1004/2])
		           rotate ([0,90,0])   
		                cylinder(h = coupling_width_666_1004*4 + global_clearance, r = M3_screw_diameter/2, $fn = 15);
			}

	///šrouby 666_1017
		
	translate([0,height_666_1017 - main_tube_outer_diameter/2 - coupling_wall_thickness,main_pilon_position])
		rotate([90,0,0])
			union(){
				translate ([- coupling_width_666_1017*2 - global_clearance/2,10 - M3_screw_diameter/2,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
	        		rotate ([0,90,0])
	            		cylinder (h = coupling_width_666_1017*4 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

	   			translate([- coupling_width_666_1017*2 - global_clearance/2,- 10 + M3_screw_diameter/2,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
	        		rotate([0,90,0])
	            		cylinder(h = coupling_width_666_1017*4 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
			    
			    translate([- coupling_width_666_1017*2 - global_clearance/2,0,27.5])
			        rotate([0,90,0])
			            cylinder(h = coupling_width_666_1017*4 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

			    translate([- coupling_width_666_1017*2 - global_clearance/2,0,7.5])
			        rotate([0,90,0])
			           cylinder(h = coupling_width_666_1017*4 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);





			}
	///šrouby 666_1004
	translate([0,0,second_undercarriage_hole - coupling_width_666_1004/2])
			union(){
			 	translate([-coupling_width_666_1004*2 - global_clearance/2,0,height_666_1004/2])
		           rotate ([0,90,0])   
		                cylinder(h = coupling_width_666_1004*4 + global_clearance, r = M3_screw_diameter/2, $fn = 15);
			}

		////šrouby 666_1026 - vertikální trubka
		
	translate([0,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes,main_pilon_position])
		rotate([-90,0,0])
			union(){
				translate([0,coupling_depth_666_1026*2 + global_clearance/2,7.5])
		           rotate([90,0,0])
		               cylinder(h = coupling_depth_666_1026*4+ global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

		        translate([0,coupling_depth_666_1026*2 + global_clearance/2,42.5])
		           rotate([90,0,0])
		               cylinder(h = coupling_depth_666_1026*4 + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
			}

	////šrouby 666_1028
	translate([0,0,length_of_main_tube - 80 + global_clearance])
			union(){
		        translate ([-150*0.4,0,150*0.4/2])
	   	 	       	rotate ([0,90,0])
	                	cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

	        	translate ([-150*0.4,0,150*0.4])
	            	rotate ([0,90,0])
	                	cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);
	     	}
    ///šrouby 666_1028
    translate([0,0,length_of_main_tube - 80 + global_clearance])
		rotate([0,0,180])	
			union(){
		        translate ([-150*0.4,0,150*0.4/2])
	   	 	       	rotate ([0,90,0])
	                	cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

	        	translate ([-150*0.4,0,150*0.4])
	            	rotate ([0,90,0])
	                	cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);
	     	}


}

/*
	rotate([0,-90,0])
		666_1027(draft);

*/

/*
			666_1026(draft);
	
	translate([0,0,2*main_tube_outer_diameter])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft);
	
	translate([0,height_666_1017 - main_tube_outer_diameter/2 - coupling_wall_thickness,main_pilon_position])
		rotate([90,0,0])
			666_1017(draft);
	
	translate([0,0,second_undercarriage_hole - coupling_width_666_1004/2])
			666_1004(coupling_wall_thickness, thickness_between_tubes, draft);

	translate([0,height_of_vertical_tube - main_tube_outer_diameter*2 + main_tube_outer_diameter/2 + thickness_between_tubes,main_pilon_position])
		rotate([-90,0,0])
			666_1026(draft);


translate([0,0,length_of_main_tube - 80 + global_clearance])
	//rotate([0,90,0])
		666_1028();

translate([0,0,length_of_main_tube - 80 + global_clearance])
	//rotate([0,-90,180])
	rotate([0,0,180])	
		666_1028();
*/


}





888_1014();


use<666_1028.scad>
use<666_1027.scad>
use<666_1004.scad>
use<666_1017.scad>
use<666_1026.scad>
use <888_1012.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>

