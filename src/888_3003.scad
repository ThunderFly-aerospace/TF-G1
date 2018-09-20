draft = true;


module licovany_sroub_m6(delka = 70){
    translate([0,0,(11-5.5)/2]) color([0,0,1]){
        cylinder(d=13, h=5.5);
        cylinder(d=8, h=5.5+70);
        cylinder(d=6, h=5.5+70+11);
    }
}

module 888_3003(){

cone_radius_one = 65;
cone_radius_two = 45;
cone_height = 60;
cylinder_height = 10;

whole_length = cone_height + cylinder_height;
height_3001 = 90;

//lícovaný šroub  M6
shank_diameter = 8 + 1 ;		//průměr dříku + tolerance pro díru
screw_length = 70; // délka lícovaného sroubu
whole_screw_length = screw_length + 11+6; 		//celková délka
thread_length = 11;				//délka závitu
thread_diameter = 6; 
length_screw_behind_nut = 3;
head_screw_diameter = 13 + 0.2;		//průměr válcové hlavy šroubu
head_screw_height = 8 + 0.2;		//výška válcové hlavy šroubu


//samojistná šestihranná matice ISO 7040 - M6
lock_nut_diameter = 11.05; //výška samojistné matice pro průměr M6
lock_nut_height = 8; 

//šířka žebra
rib_thickness = 7;


width = 608_bearing_outer_diameter*1.5;
height = whole_length;

//výška podstavy počítaná z celkové délky použitého lícovaného šroubu - díl 888_3001
height_of_base = whole_screw_length - whole_length + head_screw_height;

////////// MODEL

difference(){union(){
			888_3000();

translate([0,0,whole_length+0.8])
	color([1,0,0])		
			888_3001();

translate([0,0, whole_length + height_3001 - 608_bearing_outer_diameter])
	color([0,0.5,0])
		rotate([0,0,90])
			888_3002();
}
cube(200);
}
}



888_3003();
translate([0,0,91]) rotate([180, 0, 0]) licovany_sroub_m6(70);
translate([-(70+5.5+11)/2,0, 90+49]) rotate([0, 90, 0]) licovany_sroub_m6(70);


use <./lib/naca4.scad>
include <../Parameters.scad>


use <888_3000.scad>
use <888_3001.scad>
use <888_3002.scad>