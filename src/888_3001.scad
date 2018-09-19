draft = true;

module 888_3001(draft){		//druhý díl z issue 156 (ALT)

cone_radius_one = 50;
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

washer_diameter = 16;				//průměr podložky pod lícovaný šroub 

//rozměry dle dílu 888_3002
width = 608_bearing_outer_diameter*1.5;
height = whole_length*0.8;


//výška podstavy počítaná z celkové délky použitého lícovaného šroubu
height_of_base = whole_screw_length - whole_length + head_screw_height;

		difference (){
			//hlavní podstavec
				cylinder (h = height_of_base, r = cone_radius_two, $fn = draft ? 50 : 100);
		
		translate([0,0, whole_screw_length - whole_length])		
				
				//průměr otvoru pro šroub BEZ podložky
				cylinder (h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
				
				////průměr otvoru, pokud BUDE pod hlavou šroubu podložka
				
				//cylinder (h = head_screw_height + global_clearance, r = washer_diameter/2, $fn = draft ? 50 : 100);

		//otvor pro lícovaný šroub od dílu 1
		translate([0,0,-global_clearance])
				cylinder ( h =  whole_screw_length - whole_length + head_screw_height + global_clearance, r = shank_diameter/2, $fn = draft ? 50 : 100);

		}

		difference(){
					union (){
						translate([- coupling_wall_thickness*2 - width/2 - global_clearance,-width/2,height_of_base])
								cube ([coupling_wall_thickness*2,width,whole_length + width/2]);
						translate([- coupling_wall_thickness*2 - width/2 - global_clearance,0,whole_length + height_of_base + width/2])
							rotate([0,90,0])	
								cylinder (h = coupling_wall_thickness*2, r = width/2, $fn = draft ? 50 : 100);

						translate([ + width/2 + global_clearance,-width/2,height_of_base])
								cube ([coupling_wall_thickness*2,width,whole_length + width/2]);
						translate([ + width/2 + global_clearance,0,whole_length + height_of_base + width/2])
							rotate([0,90,0])	
								cylinder (h = coupling_wall_thickness*2, r = width/2, $fn = draft ? 50 : 100);
					}

		//otvor pro lícovaný šroub pro díl 2
			translate([- width,0,whole_length + height_of_base + width/2])
				rotate([0,90,0])
					union(){
								cylinder (h = width*2, r = shank_diameter/2, $fn = draft ? 50 : 100);
						translate([0,0,coupling_wall_thickness/2 - global_clearance])
								cylinder (h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
						translate([0,0, width*2 - head_screw_height - coupling_wall_thickness/2])
								cylinder (h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
					}

		}
	
translate([-cone_radius_two/4 - coupling_wall_thickness/2,cone_radius_two - coupling_wall_thickness/2,0])	
//výběžek a otvor pro šroub M6
		difference(){
					cube([cone_radius_two/2 + coupling_wall_thickness,cone_radius_two/2 + coupling_wall_thickness,height_of_base]);
			
			translate([cone_radius_two/4 + coupling_wall_thickness/2, cone_radius_two/4 + coupling_wall_thickness - M6_screw_diameter/2,- global_clearance/2])
				translate([-whole_length/2,0, height_of_base/2])
					rotate([0,90,0])
						cylinder (h = whole_screw_length+ global_clearance, r= M6_screw_diameter/2, $fn = draft ? 50 :100);

		}



}

//translate([0,0,50])

888_3001(draft);

//888_3000(draft);
/*
translate([0,0,90])
	rotate([180,0,90])
		888_3002(draft);
*/

use <./lib/naca4.scad>
include <../Parameters.scad>
use <888_3000.scad>
use <888_3002.scad>