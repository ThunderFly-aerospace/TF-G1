draft = true;

module 888_3001(draft){		//druhý díl z issue 156 (ALT)

cone_radius_one = 65;
cone_radius_two = 45;
cone_height = 60;
cylinder_height = 10;

whole_length = cone_height + cylinder_height;

//lícovaný šroub  M6
shank_diameter = 8 + 1 ;		//průměr dříku + tolerance pro díru
screw_length = 70; // délka lícovaného sroubu
whole_screw_length = screw_length + 11+6; 		//celková délka
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
height_of_base = whole_screw_length - whole_length;
echo(height_of_base);

		difference (){
			//hlavní podstavec
				cylinder(h = whole_length + height_of_base + width*0.6, r = cone_radius_two, $fn = draft ? 50 : 100);
            
                    translate([0,0, whole_screw_length - whole_length - 6])		
                    //průměr otvoru pro šroub BEZ podložky
                    cylinder(h = head_screw_height + global_clearance, r = head_screw_diameter/2, $fn = draft ? 50 : 100);
                    ////průměr otvoru, pokud BUDE pod hlavou šroubu podložka
                    //cylinder (h = head_screw_height + global_clearance, r = washer_diameter/2, $fn = draft ? 50 : 100);

                //otvor pro lícovaný šroub od dílu 1
                translate([0,0,-global_clearance])
                    cylinder ( h =  whole_screw_length - whole_length + head_screw_height + global_clearance, r = shank_diameter/2, $fn = draft ? 50 : 100);
                    
                translate([-width/2, -cone_radius_two,height_of_base])
                   cube([width, cone_radius_two*2, whole_length+height_of_base+whole_screw_length+global_clearance]);


                translate([0,0,whole_length + height_of_base ]) rotate([0,90,0]) union(){
                    translate([0, 0, -screw_length/2]) cylinder(h = screw_length, d = shank_diameter, $fn = draft ? 50 : 100);
                    translate([0,0, screw_length/2])
                        cylinder (h = 100, d = 608_bearing_outer_diameter, $fn = draft ? 50 : 100);
                    translate([0,0, -100-screw_length/2 -0.5])
                        cylinder (h = 100, d = 608_bearing_outer_diameter, $fn = draft ? 50 : 100);
                }

		}

//Kostka pro omezení rotace
translate([-cone_radius_two/8 - coupling_wall_thickness/2,cone_radius_two - coupling_wall_thickness/2,0])	
	cube([cone_radius_two/4 + coupling_wall_thickness,cone_radius_two/2 + coupling_wall_thickness,height_of_base]);
		
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