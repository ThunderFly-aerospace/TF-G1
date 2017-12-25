use <./lib/naca4.scad>
include <../Parameters.scad>

module 888_1001(){

width_of_accumulator = 129.4;//45+1;
depth_of_accumulator = 40.61;
height_of_accumulator = 43.65;
sink_of_accumulator = main_tube_outer_diameter/4 - Nut_height_M3*1.5;

okraj = 18;
width =width_of_accumulator + okraj;
depth = 20;
height = height_of_accumulator - sink_of_accumulator + 5;




width_cube = 10;
depth_cube = depth;
height_cube = 10;	


union(){
	
	difference (){
		translate([- (okraj/2),- depth/2,0])
				cube ([width,depth,height]);
		translate([-0.5,height_of_accumulator/2+0.5,-2 - sink_of_accumulator])		
			rotate([90,0,0])	
				%cube([width_of_accumulator+1, depth_of_accumulator+3, height_of_accumulator+1]);
 	}

	difference(){
		translate([-width_cube - okraj/2,-depth/2,0])	
				cube([width_cube,depth_cube,height_cube]);
	//šroub
		translate([-okraj/2 - width_cube/2,0,-10])
				cylinder(h = 20, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
	//matka
		translate([-okraj/2 - width_cube/2,0,height_cube-1])
				cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
	}

	difference(){
		translate([width_of_accumulator + okraj/2,-depth/2,0])	
				cube([width_cube,depth_cube,height_cube]);
	//šroub
		translate([width_of_accumulator + okraj/2 + width_cube/2,0,-10])
				cylinder(h = 20, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
	//matka
		translate([width_of_accumulator + okraj/2 + width_cube/2,0,height_cube-1])
				cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
	}

//final union
}


//final module
}


888_1001();