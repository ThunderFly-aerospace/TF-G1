draft = true;

module 888_3003(){

cone_radius_one = 65;
cone_radius_two = 35;
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

//samojistná šestihranná matice ISO 7040 - M6
lock_nut_diameter = 11.05; //výška samojistné matice pro průměr M6
lock_nut_height = 8; 

//šířka žebra
rib_thickness = 5;


width = 608_bearing_outer_diameter*1.5;
height = whole_length;

//výška podstavy počítaná z celkové délky použitého lícovaného šroubu - díl 888_3001
height_of_base = whole_screw_length - whole_length + head_screw_height;

////////// MODEL


			888_3000();

translate([0,0,whole_length])
	color([1,0,0])		
			888_3001();

translate([0,0,whole_length + height_of_base + width/2])
	color([0,0.5,0])
		rotate([0,0,90])
			888_3002();




}



888_3003();


use <./lib/naca4.scad>
include <../Parameters.scad>


use <888_3000.scad>
use <888_3001.scad>
use <888_3002.scad>