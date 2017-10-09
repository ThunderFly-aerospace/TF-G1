include <../Parameters.scad>

radius=main_tube_outer_diameter/2;
wall_thickness=main_tube_outer_diameter/10;
width=main_tube_outer_diameter+2*wall_thickness;	
depth=main_tube_outer_diameter*2;
height=depth;


c_na_druhou=width*width+width*width;
uhlopricka=sqrt(c_na_druhou);
c2_na_druhou=(depth/2*depth/2)+(depth/2*depth/2);
uhlopricka_2=sqrt(c2_na_druhou);




M4_screw_radius=M4_screw_diameter/2;
wall_thickness_M4_cylinder_X = M4_screw_radius;
stred_M4_cylinder_X = width/2 - M4_screw_radius * 2;
stred_M4_cylinder_Z_horni = height - M4_screw_radius - M4_screw_diameter*0.75;
stred_M4_cylinder_Z_dolni = M4_screw_radius + M4_screw_diameter*2;

difference (){

translate([-(width/2),-(depth/2),0])
cube ([width,depth,height]);
	
	//tube
	translate([0,0,-3])
	cylinder(h=height+6,r1=radius,r2=radius,$fn=200);

	//screw
	translate([0,depth/2+3,7.5])
	rotate([90,0,0])
	cylinder(h=depth+6, r1=M4_screw_radius, r2 = M4_screw_radius, $fn=20);


	translate([0,depth/2+3,42.5])
	rotate([90,0,0])
	cylinder(h=depth+6, r1=M4_screw_radius, r2 = M4_screw_radius, $fn=20);

	//nut
	translate([0,depth/2+3,7.5])
	rotate([90,0,0])
	cylinder(h = Nut_height_M4 + 3, r1 = Nut_diameter_M4/2, r2= Nut_diameter_M4/2, $fn = 6);

	translate([0,depth/2+3,42.5])
	rotate([90,0,0])
	cylinder(h = Nut_height_M4 + 3, r1 = Nut_diameter_M4/2, r2= Nut_diameter_M4/2, $fn = 6);

	translate([0,-depth/2+3,7.5])
	rotate([90,0,0])
	cylinder(h = Nut_height_M4 + 3, r1 = Nut_diameter_M4/2, r2= Nut_diameter_M4/2, $fn = 6);

	translate([0,-depth/2+3,42.5])
	rotate([90,0,0])
	cylinder(h = Nut_height_M4 + 3, r1 = Nut_diameter_M4/2, r2= Nut_diameter_M4/2, $fn = 6);
	
	//bevelled edge

	translate([width/2,depth/2-1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([-(width/2),depth/2-1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([-(width/2),-uhlopricka_2-depth/2+1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([width/2,-uhlopricka_2-depth/2+1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);
}
