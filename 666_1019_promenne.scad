diameter=25;
radius=diameter/2;
wall_thickness=diameter/(10/3);
width=diameter+2*wall_thickness;	
depth=width;
height=width;


c_na_druhou=width*width+width*width;
uhlopricka=sqrt(c_na_druhou);

mini_diameter=4;
mini_radius=mini_diameter/2;
wall_thickness_mini_cylinder_X = mini_radius;
stred_mini_cylinder_X = width/2 - mini_radius - mini_radius;
stred_mini_cylinder_Z_horni = height - mini_radius - mini_diameter*0.75;
stred_mini_cylinder_Z_dolni = mini_radius + mini_diameter*2;

difference (){

translate([-(width/2),-(depth/2),0])
cube ([width,depth,height]);
	
	cylinder(h=height,r1=radius,r2=radius);


	translate([stred_mini_cylinder_X,depth/2,stred_mini_cylinder_Z_horni])
	rotate([90,0,0])
	cylinder(h=height,r1=mini_radius,r2=mini_radius);

	translate([-(stred_mini_cylinder_X),depth/2,stred_mini_cylinder_Z_horni])
	rotate([90,0,0])
	cylinder(h=height,r1=mini_radius,r2=mini_radius);

	translate([stred_mini_cylinder_X,depth/2,stred_mini_cylinder_Z_dolni])
	rotate([90,0,0])
	cylinder(h=height,r1=mini_radius,r2=mini_radius);

	translate([-(stred_mini_cylinder_X),depth/2,stred_mini_cylinder_Z_dolni])
	rotate([90,0,0])
	cylinder(h=height,r1=mini_radius,r2=mini_radius);


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