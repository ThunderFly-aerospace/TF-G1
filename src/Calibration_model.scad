include <../Parameters.scad>
wall_thickness = main_tube_outer_diameter/5;
width = wall_thickness * 3 + main_tube_outer_diameter + main_tube_inner_diameter;
depth = main_tube_outer_diameter + wall_thickness * 2;
height = 10;
protrusion_height = 5;

difference () {

translate ([-(main_tube_outer_diameter/2+wall_thickness),-(main_tube_outer_diameter/2+wall_thickness),0])
cube ([width,depth,height]);

translate([0,0,-3])
cylinder (h = height+6, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);

translate ([main_tube_outer_diameter/2 + wall_thickness + main_tube_inner_diameter/2,-4,-3])
cylinder (h = height+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2, $fn=200);

//screw

translate ([-main_tube_outer_diameter/2,-main_tube_outer_diameter/2,-3])
cylinder (h = height+6, r1 = M4_screw_diameter/2, r2 = M4_screw_diameter/2, $fn=15);

translate ([-main_tube_outer_diameter/2,main_tube_outer_diameter/2,-3])
cylinder(h = height+6, r1 = M3_screw_diameter/2, r2=M3_screw_diameter/2, $fn=15);

//nut

translate ([-main_tube_outer_diameter/2,-main_tube_outer_diameter/2,-3])
cylinder(h = Nut_height_M4+3, r1 = Nut_diameter_M4/2, r2 = Nut_diameter_M4/2, $fn=6);

translate ([-main_tube_outer_diameter/2,main_tube_outer_diameter/2,-3])
cylinder(h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn=6);

}

union () {

	difference(){

	translate ([main_tube_outer_diameter/2 + wall_thickness + main_tube_inner_diameter/2,-4,-(protrusion_height)])
	cylinder (h = protrusion_height, r1 = main_tube_inner_diameter/2, r2 = main_tube_inner_diameter/2,$fn=200);

		translate ([main_tube_outer_diameter/2 + wall_thickness + main_tube_inner_diameter/2,-4,-protrusion_height-3])
		cylinder (h = protrusion_height+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2,$fn=200);


}
}

union(){

	translate ([main_tube_outer_diameter/2 + wall_thickness/2+2,main_tube_outer_diameter/2 - 2,-protrusion_height])
	cylinder (h = protrusion_height, r1 = tube_for_undercarriage_inner_diameter, r2 = tube_for_undercarriage_inner_diameter,$fn=200);

}
