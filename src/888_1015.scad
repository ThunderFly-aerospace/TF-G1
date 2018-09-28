draft = true; 


module 888_1015(draft){
	
	plate_thickness = 1.5;

	width = 70;
	depth = 2*plate_thickness + 2*main_tube_outer_diameter + 2*thickness_between_tubes;
	height = 68.5 + 10;

	rake_angle = 9;		//úhel horního zkosení

	servo_width = 21;	//šřka otvoru pro servo
	servo_height = 42;	//výška otvoru pro servo

	//příruba
	flange_width = 40;						//h
	flange_depth = flange_width;
	flange_height = 4.5;
	flange_length_beteween_screws = 28;		//m
	flange_screw_diameter = 5.3 + 1;		//N
	flange_main_hole = 25 + 1;				//d1

	//otvor pro klíč
	key_width = flange_width;
	key_depth = flange_depth;
	key_height = M5_nut_height;

	M5_screw_length = 19;
	M2_5_screw_length = 10;
	M2_5_pocket_depth = 5;
		
	difference (){
		//základní kostka
		translate([-width/2,-depth/2,0])
				cube ([width, depth, height]);
		//zkosení
		translate([-width/2 + 10,-depth/2-global_clearance,height])
			rotate([0,rake_angle,0])
				cube([width + 2*global_clearance, depth + 2*global_clearance,20]);

		//otvory z dílu 666_1026
		translate([17.5 - width/2,0,0])
			union(){
			//vertikální trubka
				translate([0,0,-global_clearance])
					cylinder(h = height_666_1026 + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
			//otvory pro upevnění vertikální trubky
				translate([0,depth/2 + global_clearance/2,7.5])
			        rotate([90,0,0])
			            cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
		        translate([0,depth/2 + global_clearance/2,42.5])
			        rotate([90,0,0])
			            cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

			}
		//otvory pro serva
		translate([width/2 - servo_width - 4,-depth/2 - global_clearance/2,7.5])
			cube([servo_width, depth + global_clearance,servo_height]);
		//otvor pro kabely od serv
		translate([width/2 - servo_width + servo_width/4- 4,-15,-global_clearance])
			cube([servo_width/2,30,20]);
		//otvory pro šrouby pro připevnění serva
		translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4])
			rotate([0,-90,90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4])
			rotate([0,-90,90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}

		translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
			rotate([0,-90, 90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
			rotate([0,-90, 90])
				union(){
					cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
					translate([0,0,M2_5_pocket_depth])
						rotate([0,0,90])
							cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
					translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
							cube([30,M2_5_nut_diameter,M2_5_nut_height]);
				}
		translate([0,0,48 + 9])
			rotate([180,0,0])
				union(){
					translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4])
						rotate([0,90,-90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
					translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4])
						rotate([0,90,-90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}

					translate([width/2 - 4 - 5.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
						rotate([0, 90, -90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
					translate([width/2 - 4 - 15.5,-depth/2 + M2_5_screw_length,4.5 + 48.5])
						rotate([0, 90, -90])
							union(){
								cylinder (h = M2_5_screw_length + global_clearance, r = M2_5_screw_diameter/2, $fn = draft ? 50 : 100 );
								translate([0,0,M2_5_pocket_depth])
									rotate([0,0,90])
										cylinder (h = M2_5_nut_height, r = M2_5_nut_diameter/2, $fn = 6);
								translate([0,-M2_5_nut_diameter/2,M2_5_pocket_depth])
										cube([30,M2_5_nut_diameter,M2_5_nut_height]);
							}
				}

		//příruba
		translate([- global_clearance - width/2 + 10,-flange_depth/2 - global_clearance, height - flange_height])
			rotate([0,rake_angle,0])
				union(){
				//základní tvar
					cube([flange_width + 2*global_clearance, flange_depth + 2*global_clearance, flange_height + global_clearance]);
				//hlavní otvor
					translate([flange_width/2, flange_depth/2,- 15])
						cylinder(h = 30, r = flange_main_hole/2, $fn = draft ? 50 : 100);
				//otvor pro šrouby
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2,-M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2,- M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,- M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws, - M5_screw_length])
						cylinder(h = M5_screw_length + global_clearance, r = M5_screw_diameter/2, $fn = draft ? 50 : 100);
				//otvory pro matky
					translate([(flange_width - flange_length_beteween_screws)/2, (flange_width - flange_length_beteween_screws)/2, -M5_screw_length + key_height - 2*M5_nut_height])
						cylinder(h = 4*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2,-M5_screw_length + key_height - M5_nut_height])
						cylinder(h = 3*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,-M5_screw_length + key_height - M5_nut_height])
						cylinder(h = 3*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);
					translate([(flange_width - flange_length_beteween_screws)/2,(flange_width - flange_length_beteween_screws)/2 + flange_length_beteween_screws,-M5_screw_length + key_height - 2*M5_nut_height])
						cylinder(h = 4*M5_nut_height, r = M5_nut_diameter/2, $fn = 6);

				//otvor pro klíč na matku nosníku rotoru
					translate([-M5_nut_diameter/2-30, M5_nut_diameter/2, - flange_height - key_height*3.2])
						cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2]);

		//otvor na čep
		translate([flange_width/2 + 32, flange_depth/2, -20])
			hull(){
				translate([1.5,0,0])
					cylinder (h = 25, r1 = 8, r2 = 2.55, $fn = draft ? 50 : 100);
				translate([-1.5,0,0])
					cylinder (h = 25, r1 = 8, r2 = 2.55, $fn = draft ? 50 : 100);
			}
		}
		//otvor pro klíč k přírubě
		translate([- global_clearance - width/2 + 10 -M5_nut_diameter/2-30, M5_nut_diameter/2 -flange_depth/2 - global_clearance, height - flange_height - flange_height - key_height*4.5])
			cube([key_width + M5_nut_diameter + 20, key_depth - M5_nut_diameter, key_height*2.3]);


	}
}


888_1015(draft);

include <../Parameters.scad>