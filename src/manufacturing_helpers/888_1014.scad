draft = true;


module 888_1014(draft){

//translate([0,0,coupling_wall_thickness])
	difference(){
		//hlavní díly
		union(){
		translate([-main_tube_outer_diameter, -2* main_tube_outer_diameter,- coupling_wall_thickness])
				color([0,0,0.5])
					cube([2*main_tube_outer_diameter,4*main_tube_outer_diameter, length_of_main_tube]);
		translate([-main_tube_outer_diameter,main_tube_outer_diameter/2 + thickness_between_tubes,-2*main_tube_outer_diameter + main_pilon_position])
				color([0,0,0.5])
					cube([2*main_tube_outer_diameter,height_of_vertical_tube,4*main_tube_outer_diameter]);

		}
		//trubky
		union(){
				cylinder(h = length_of_main_tube + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);
		translate([0,height_of_vertical_tube + thickness_between_tubes + main_tube_outer_diameter/2 + global_clearance, main_pilon_position])	
			rotate([90,0,0])	
				cylinder(h = height_of_vertical_tube + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

		}		
		//šrouby 666_1026
				union(){
					translate([2*coupling_depth_666_1026 + global_clearance/2,0,7.5])
			           rotate([90,0,-90])
			               cylinder(h = coupling_depth_666_1026*4+ global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

			        translate([coupling_depth_666_1026*2 + global_clearance/2,0,42.5])
			           rotate([90,0,-90])
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
					translate ([- coupling_width_666_1017*2 - global_clearance/2,depth_666_1017/4,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
		        		rotate ([0,90,0])
		            		cylinder (h = coupling_width_666_1017*4 + global_clearance, d = M4_screw_diameter, $fn = draft ? 10 : 20);

		   			translate([- coupling_width_666_1017*2 - global_clearance/2,-depth_666_1017/4,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
		        		rotate([0,90,0])
		            		cylinder(h = coupling_width_666_1017*4 + global_clearance, d = M4_screw_diameter, $fn = draft ? 10 : 20);
				    
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
	////šrouby pro připevnění dílu 666_1027 k horizontální trubce
		rotate([0,-90,0])
			union(){
				//A
		        translate([base_division[1]*0.75,0,-hull_z_size/2])
	                   %cylinder(h = hull_z_size*2, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
		        //B
		        translate([base_division[1] + (base_division[2] - base_division[1])/4,0,-hull_z_size/2])
		                cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
		        //C
		        translate([base_division[2]*1.15,0,- hull_z_size/2])
		                cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
		        //D
		        translate([base_division[4]*0.86,0,- hull_z_size/2])
		                cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
			}    


	}
}

//dělení

module 888_1014_part(part_number, draft){

	intersection(){
			888_1014(draft);

		//horizontální část
		if(part_number<=6)
		{

			if (part_number <=4)
			{
					translate([-maximum_printable_size/2,-maximum_printable_size/2,part_number*maximum_printable_size])
						cube([maximum_printable_size, maximum_printable_size, maximum_printable_size]);
			}

			else
			{

				if(part_number <= 5 && part_number >= 5)
				{
				
				maximum_printable_size_Z = maximum_printable_size - main_tube_outer_diameter*2;
				
					translate([-maximum_printable_size/2,-maximum_printable_size/2,part_number*maximum_printable_size])
						cube([maximum_printable_size, maximum_printable_size, maximum_printable_size_Z]);
				}

				else
				{

				maximum_printable_size_Z = maximum_printable_size - main_tube_outer_diameter*2;
				
					translate([-maximum_printable_size/2,-maximum_printable_size/2,part_number*maximum_printable_size - 2*main_tube_outer_diameter])
						cube([maximum_printable_size, maximum_printable_size, maximum_printable_size]);
				}

			}

		}

		//vertikální část
		else
		{
				translate([-maximum_printable_size/2,(part_number - 6)*maximum_printable_size - maximum_printable_size/2, maximum_printable_size + maximum_printable_size/10])
					cube([maximum_printable_size, maximum_printable_size, maximum_printable_size]);

		}


	}
}

rotate([0,90,0])
888_1014();

666_1027();

/*
		888_1014_part(0, draft);
translate([0,0,20])
		888_1014_part(1, draft);
translate([0,0,40])
		888_1014_part(2, draft);
translate([0,0,60])
		888_1014_part(3, draft);
translate([0,0,80])
		888_1014_part(4, draft);
translate([0,0,100])
		888_1014_part(5, draft);
translate([0,0,120])
		888_1014_part(6, draft);
translate([0,20,20])
		888_1014_part(7, draft);
translate([0,40,20])
		888_1014_part(8, draft);

*/
use<../666_1028.scad>
use<../666_1027.scad>
use<../666_1004.scad>
use<../666_1017.scad>
use<../666_1026.scad>
use<../888_1012.scad>


use <./../lib/naca4.scad>
include <../../parameters.scad>

