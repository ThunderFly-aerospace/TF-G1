draft = true;


module 888_3000(draft){    /////// 1. díl (AZ, YAW)

cone_radius_one = 65;
cone_radius_two = 45;
cone_height = 25;
cylinder_height = 10;

whole_length = cone_height + cylinder_height;

//lícovaný šroub  M6
shank_diameter = 8 + 1 ;		//průměr dříku + tolerance pro díru
screw_length = 30; // délka lícovaného sroubu
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

rotate_angle = 40;

//výška podstavy počítaná z celkové délky použitého lícovaného šroubu
height_of_base = whole_screw_length - whole_length + head_screw_height;

base_thickness = 30-18-6; // sila materialu pod srouby pro pridelani

union (){
	difference(){

		union(){
					cylinder (h = cylinder_height, r = cone_radius_one, center = false, $fn = draft ? 50 : 100);
			translate([0,0,cylinder_height])
					cylinder(h = cone_height, r1 = cone_radius_one, r2 = cone_radius_two, center=false, $fn = draft ? 50 : 100);
		}

	//šrouby pro uchycení
		translate([- cone_radius_one/2 - 3, - cone_radius_one/2 - 3,-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, r = M6_screw_diameter/2, $fn = draft ? 10 : 20);
		translate([ - cone_radius_one/2 - 3, cone_radius_one/2 + 3,-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, r = M6_screw_diameter/2, $fn = draft ? 10 : 20);
		translate([cone_radius_one/2 + 3,cone_radius_one/2 + 3,-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, r = M6_screw_diameter/2, $fn = draft ? 10 : 20);
		translate([cone_radius_one/2 + 3, - cone_radius_one/2 - 3,-global_clearance])	
				cylinder (h = whole_length +  2*global_clearance, r = M6_screw_diameter/2, $fn = draft ? 10 : 20);
        
	//šrouby pro uchycení
		translate([- cone_radius_one/2 - 3, - cone_radius_one/2 - 3,base_thickness-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, r = Nut_diameter_M6/2, $fn = draft ? 10 : 20);
		translate([ - cone_radius_one/2 - 3, cone_radius_one/2 + 3, base_thickness-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, d = Nut_diameter_M6, $fn = draft ? 10 : 20);
		translate([cone_radius_one/2 + 3,cone_radius_one/2 + 3, base_thickness-global_clearance])	
				cylinder (h = whole_length + 2*global_clearance, d = Nut_diameter_M6, $fn = draft ? 10 : 20);
		translate([cone_radius_one/2 + 3, - cone_radius_one/2 - 3, base_thickness-global_clearance])	
				cylinder (h = whole_length +  2*global_clearance, d = Nut_diameter_M6, $fn = draft ? 10 : 20);


	//otvory pro ložiska
		//horní
		translate([0,0, whole_length - 608_bearing_thickness - global_clearance/2])
				cylinder (h = 608_bearing_thickness + global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);
		//spodní
		translate([0,0,- global_clearance/2])
				cylinder (h = 608_bearing_thickness + thread_length + 1+ global_clearance, r = 608_bearing_outer_diameter/2, $fn = draft ? 50 : 100);

	//otvor pro lícovaný šroub
		translate ([0,0,- global_clearance/2])
				cylinder (h = whole_screw_length + global_clearance, d = 608_bearing_outer_diameter-6, $fn = draft ? 50 : 100);


	}

	//sloupky pro rotaci
	difference(){
		union(){
			rotate([0,0,rotate_angle/2])
				translate([-rib_thickness*2,0,cylinder_height])
					cube([rib_thickness*2, cone_radius_one, whole_length + height_of_base - cylinder_height]);
			rotate([0,0,-rotate_angle/2])
				translate([0,0,cylinder_height])
					cube([rib_thickness*2, cone_radius_one, whole_length + height_of_base - cylinder_height]);
		}

	//otvory pro ložiska
		//horní
		translate([0,0, whole_length - 608_bearing_thickness - global_clearance])
				cylinder (h = 608_bearing_thickness + global_clearance, d = 608_bearing_outer_diameter, $fn = draft ? 50 : 100);

	//otvor pro lícovaný šroub
		translate ([0,0,- global_clearance/2])
				cylinder (h = whole_screw_length + global_clearance, d = 608_bearing_outer_diameter-6, $fn = draft ? 50 : 100);
	//odstranění zbylých částí
				cylinder (h = whole_length + cylinder_height + global_clearance + height_of_base, r = cone_radius_two+1);
	
//výběžek a otvor pro šroub M6 - z dílu 888_3001

	translate([-cone_radius_two/4 - coupling_wall_thickness/2,cone_radius_two - coupling_wall_thickness/2,whole_length])	
			translate([cone_radius_two/4 + coupling_wall_thickness/2, cone_radius_two/4 + coupling_wall_thickness - M6_screw_diameter/2,- global_clearance/2])
				translate([-whole_length,0, height_of_base/2])
					rotate([0,90,0])
						union(){
									//cylinder (h = whole_screw_length*2, r= M6_screw_diameter/2, $fn = draft ? 50 :100);
						
					//kapsa pro matku
							translate([0,0,whole_screw_length/2 - rib_thickness/3])
								rotate([0,0,90])
									union(){
												//cylinder(h = Nut_height_M6, r = Nut_diameter_M6/2, $fn = 6);
										//translate([-Nut_diameter_M6/2 - global_clearance/2,0,0])
												//cube([Nut_diameter_M6 + global_clearance, 20, Nut_height_M6]);
									}
						}
	}		

}

}


888_3000(draft);

use <./lib/naca4.scad>
include <../Parameters.scad>