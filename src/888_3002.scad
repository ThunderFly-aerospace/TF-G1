draft = true;

module 888_3002(draft){

cone_radius_one = 65;
cone_radius_two = 30;
cone_height = 40;
cylinder_height = 10;

whole_length = cone_height + cylinder_height;

//lícovaný šroub  M6
shank_diameter = 8 + 1 ;		//průměr dříku + tolerance pro díru
whole_screw_length  = 56; 		//celková délka
thread_length = 11;				//délka závitu
thread_diameter = 6; 
length_screw_behind_nut = 3;
head_screw_diameter = 13 + 0.2;		//průměr válcové hlavy šroubu
head_screw_height = 8 + 0.2;		//výška válcové hlavy šroubu

width = 608_bearing_outer_diameter*1.5;
height = whole_length;

difference(){

//základní kostka
			union(){
				translate([- width/2,- width/2,0])
						cube([width,width,height]);
				translate([0,width/2,height])
					rotate([90,0,0])
						cylinder(h = width, r = width/2, $fn = draft ? 50 : 100);
			}

//otvor pro lícovaný šroub z dílu 2
	translate([0,width/2 + global_clearance/2,height])
		rotate([90,0,0])
			cylinder (h = width + global_clearance, d = 608_bearing_outer_diameter-6,, $fn = draft ? 50 : 100);

//otvor pro závitovou tyč M8
	translate([0,0,height*0.4])
			union(){
				translate([- width/2 - global_clearance/2,0,0])
					rotate([0,90,0])
						cylinder(h = width + global_clearance, r = M8_screw_diameter/2, $fn = draft ? 50 : 100);

			//otvory pro ložiska 608
				translate([width/2 - 608_bearing_thickness,0,0])
					rotate([0,90,0])
						cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50:100);
				
				translate([- width/2 - global_clearance,0,0])
					rotate([0,90,0])
						cylinder(h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50:100);
			}
}



}


888_3002(draft);




use <./lib/naca4.scad>
include <../Parameters.scad>