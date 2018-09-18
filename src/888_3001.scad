draft = true;

module 888_3001(draft){		//druhý díl z issue 156 (ALT)

cone_radius_one = 50;
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

washer_diameter = 16;				//průměr podložky pod lícovaný šroub 



		difference (){
			//hlavní podstavec
				cylinder (h = whole_screw_length - whole_length + head_screw_height, r = cone_radius_two, $fn = draft ? 50 : 100);
		
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
						translate([- coupling_wall_thickness - cone_radius_two*0.5,-cone_radius_two*0.5,0])
								cube ([coupling_wall_thickness*2,cone_radius_two,whole_length]);
						translate([- coupling_wall_thickness - cone_radius_two*0.5,0,whole_length])
							rotate([0,90,0])	
								cylinder (h = coupling_wall_thickness*2, r = cone_radius_two/2, $fn = draft ? 50 : 100);

						translate([- coupling_wall_thickness + cone_radius_two*0.5,-cone_radius_two*0.5,0])
								cube ([coupling_wall_thickness*2,cone_radius_two,whole_length]);
						translate([- coupling_wall_thickness + cone_radius_two*0.5,0,whole_length])
							rotate([0,90,0])	
								cylinder (h = coupling_wall_thickness*2, r = cone_radius_two/2, $fn = draft ? 50 : 100);
					}

		//otvor pro lícovaný šroub pro díl 2
			translate([-cone_radius_one/2,0,whole_length])
				rotate([0,90,0])
					union(){
								cylinder (h = cone_radius_one, r = shank_diameter/2, $fn = draft ? 50 : 100);
						translate([0,0,coupling_wall_thickness/2 - global_clearance])
								cylinder (h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
						translate([0,0, whole_length - head_screw_height - coupling_wall_thickness/2])
								cylinder (h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
					}

		}
	
translate([-cone_radius_two/4 - coupling_wall_thickness/2,cone_radius_two - coupling_wall_thickness/2,0])	
//výběžek a otvor pro šroub M6
		difference(){
					cube([cone_radius_two/2 + coupling_wall_thickness,cone_radius_two/2 + coupling_wall_thickness,whole_screw_length - whole_length + head_screw_height]);
			translate([cone_radius_two/4 + coupling_wall_thickness/2, cone_radius_two/4 + coupling_wall_thickness - M6_screw_diameter/2,- global_clearance/2])
					union (){
								cylinder (h = whole_screw_length - whole_length + head_screw_height + global_clearance, r= M6_screw_diameter/2, $fn = draft ? 50 :100);
						translate([0,0,whole_screw_length - whole_length + head_screw_height - Nut_height_M6 + global_clearance])
								cylinder (h = Nut_height_M6 + global_clearance, r = Nut_diameter_M6/2, $fn = draft ? 50 : 100);
					}
		}




}

//translate([0,0,50])

888_3001(draft);

//888_3000(draft);


use <./lib/naca4.scad>
include <../Parameters.scad>
use <888_3000.scad>