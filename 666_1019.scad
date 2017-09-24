include <./parameters.scad>

radius=main_tube_outer_diameter/2;
wall_thickness=main_tube_outer_diameter/(10/3);
width=main_tube_outer_diameter+2*wall_thickness;	
depth=width;
height=width;


c_na_druhou=width*width+width*width;
uhlopricka=sqrt(c_na_druhou);



M4_screw_radius=M4_screw_diameter/2;
wall_thickness_M4_cylinder_X = M4_screw_radius;
stred_M4_cylinder_X = width/2 - M4_screw_radius * 2;
stred_M4_cylinder_Z_horni = height - M4_screw_radius - M4_screw_diameter*0.75;
stred_M4_cylinder_Z_dolni = M4_screw_radius + M4_screw_diameter*2;

difference (){

translate([-(width/2),-(depth/2),0])
cube ([width,depth,height]);
	
	cylinder(h=height,r1=radius,r2=radius);


	translate([stred_M4_cylinder_X,depth/2,stred_M4_cylinder_Z_horni])
	rotate([90,0,0])
	cylinder(h=height,r1=M4_screw_radius,r2=M4_screw_radius);

	translate([-(stred_M4_cylinder_X),depth/2,stred_M4_cylinder_Z_horni])
	rotate([90,0,0])
	cylinder(h=height,r1=M4_screw_radius,r2=M4_screw_radius);

	translate([stred_M4_cylinder_X,depth/2,stred_M4_cylinder_Z_dolni])
	rotate([90,0,0])
	cylinder(h=height,r1=M4_screw_radius,r2=M4_screw_radius);

	translate([-(stred_M4_cylinder_X),depth/2,stred_M4_cylinder_Z_dolni])
	rotate([90,0,0])
	cylinder(h=height,r1=M4_screw_radius,r2=M4_screw_radius);


	translate([width/2,depth/2-1,0])
	rotate([0,0,45])
	cube([uhlopricka/2,uhlopricka/2,height]);

	translate([-(width/2),depth/2-1,0])
	rotate([0,0,45])
	cube([uhlopricka/2,uhlopricka/2,height]);

	translate([-(width/2),-(depth/2+uhlopricka/2-1),0])
	rotate([0,0,45])
	cube([width/2,depth/2,height]);

	translate([(width/2),-(depth/2+uhlopricka/2-1),0])
	rotate([0,0,45])
	cube([width/2,depth/2,height]);
}