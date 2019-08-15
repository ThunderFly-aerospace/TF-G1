include <../parameters.scad>;

length = 70;
width = 40;
height = 4;
shaft_width = 13;
screw_radius = 25/2;
encoder_radius = 19/2;

$fn = 100;

//function for making hexagon
module hex(width, radius, height) {
	//witdh = diameter, radius = edge rounding, height = height

	hull() {
		translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
		rotate([0, 0, 60])translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
		rotate([0, 0, 120])translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
		rotate([0, 0, 180])translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
		rotate([0, 0, 240])translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
		rotate([0, 0, 300])translate([width/2-radius, 0, 0])cylinder(r=radius, h=height);
	}
}



//main part
difference() {
	translate([-width/2, -width/2, 0])
	cube([length, width, height]);

	//motor mounting holes
	for(i = [0:3]) {
		rotate([0, 0, i * 90 + 45])
		translate([screw_radius, 0, - 1])
		union() {
			cylinder(height + 2, d = M3_screw_diameter);
			translate([0, 0, height - 1.5])
			cylinder(height + 2, d = M3_nut_diameter);
		}
	}

	//nut holes
	translate([encoder_radius, 0, - 1])
	union() {
		cylinder(height + 2, d = M3_screw_diameter);
		rotate([0, 0, 90])
		hex(M3_nut_diameter, 0.2, M3_nut_height);
	}
	translate([- encoder_radius, 0, - 1])
	union() {
		cylinder(height + 2, d = M3_screw_diameter);
		rotate([0, 0, 90])
		hex(M3_nut_diameter, 0.2, M3_nut_height);
	}

	//shaft hole
	translate([0, 0, - 1])
	cylinder(height + 2, d = shaft_width);
	


	//side mounting holes
	translate([length - width / 2 - 10, - 10, - 1])
	cylinder(height + 2, d = M3_screw_diameter);
	translate([length - width / 2 - 10, 10, - 1])
	cylinder(height + 2, d = M3_screw_diameter);
}
