draft = true;

module 888_3003(){  ///4 a 5 díl z issue 156

width = 608_bearing_outer_diameter*1.5;
height = 70;


difference(){
	translate([-width,- width/2,0])
	cube ([width*2, width,height]);


//otvor pro závitovou tyč M8, kapsa pro matku
	translate([0,0,Nut_diameter_M8])
		rotate([90,0,0])
			cylinder (h = 40, r = M8_screw_diameter/2, $fn = draft ? 50 : 100, center = true);
	translate([0,width/2-5,Nut_diameter_M8])
		rotate([90,90,0])
			cylinder (h = Nut_height_M8, r = Nut_diameter_M8/2, $fn = 6);
	translate([0,width/2 - Nut_height_M8 - 5,Nut_diameter_M8/2])
		rotate([0,-90,0])
			cube([Nut_diameter_M8, Nut_height_M8, 40]);
//vidlice
	translate([- (608_bearing_outer_diameter*1.5)/2,- width/2 - global_clearance/2,height - width])
			cube([608_bearing_outer_diameter*1.5, width + global_clearance, width + global_clearance]);
//otvor pro horní šroub s otvory pro ložiska
	translate([-width,0,height - 608_bearing_outer_diameter*0.75])
		rotate([0,90,0])
			union(){
				translate([0,0,-global_clearance/2])
					cylinder(h = width*2 + global_clearance, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,width - 608_bearing_thickness - 608_bearing_outer_diameter*0.75])
					cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);
			translate([0,0,width + 608_bearing_outer_diameter*0.75 - global_clearance])
					cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);
			
			}

}



}


888_3003();




use <./lib/naca4.scad>
include <../Parameters.scad>