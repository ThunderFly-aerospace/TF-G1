include <./parameters.scad>
wall_thickness = main_tube_outer_diameter/5;
width = wall_thickness * 3 + main_tube_outer_diameter + main_tube_inner_diameter;
depth = main_tube_outer_diameter + wall_thickness * 2;
height = 20;

difference () {

translate ([-(main_tube_outer_diameter/2+wall_thickness),-(main_tube_outer_diameter/2+wall_thickness),0])
cube ([width,depth,height]);

cylinder (h = height, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2);

translate ([-main_tube_outer_diameter/2,-main_tube_outer_diameter/2,0])
cylinder (h = height, r1 = M4_screw_diameter/2, r2 = M4_screw_diameter/2);

}


union () {

	translate ([main_tube_outer_diameter/2 + wall_thickness + main_tube_inner_diameter/2,0,-10])
	cylinder (h = 20, r1 = main_tube_inner_diameter/2, r2 = main_tube_inner_diameter/2);

}