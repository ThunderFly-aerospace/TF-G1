// Rozperka lozesik v dilu predniho podvozku

include <../parameters.scad>
$fn = $preview? 20:80;

module 888_2020() {
	height = front_undercarriage_bearing_distance;

	difference(){
		cylinder(d = 13, h = height);
		cylinder(d = M8_screw_diameter, h = height);
		cylinder(d1 = M8_screw_diameter+1, d2=M8_screw_diameter, h = 1);
		translate([0, 0, height-1])
		cylinder(d2 = M8_screw_diameter+1, d1=M8_screw_diameter, h = 1);
	}
}


888_2020();