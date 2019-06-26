			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

//sestava listy, závaží, kování

module 666_2300(draft){

delka_listu = 970;
sirka_listu = 50;
uchytna_cast = 100;

//angles from 888_1015
rake_angle = 9; 
rotx = 20/2;
roty = 20/2;

motor_distance = 79.03; //888_1020 vzdalenost prerotatoru od hlavni pos_y
motor_diameter = 35+2;	//888_1020


prerotator_imitation_height = 48; 	//prerotator_imitation
prerotator_imitation_diameter = 35; //prerotator_imitation

plate_bearing_center_distance = 14;     //888_1020 vzdalenost horni spodni steny placky od stredu loziska

/*
translate([0,0,45])
	rotate([roty/2 + rake_angle,180 + rake_angle,0])
		union(){

			union(){
				translate([-24.4,40.7,19])
					rotate([rotor_flap0,180, - rotor_delta])
						union(){
						//list
							
							translate([-sirka_listu/2, delka_listu/2,6])
								rotate([0,rotor_blade_AOA,0])
										import ("../../STL/rotor_blade.stl");

							//podložka listu
							%translate([-35/4,0,0])
								rotate([0,0,90])
									color([0,0,1])
										import ("../../STL/666_1247.stl");

							//kování
							translate([-33.5 - 33.5/3.4 - 0.8,-15 + 1,13])
								rotate([180,0,90])
									color([1,0,0])
										import ("../../STL/666_1206.stl");

							translate([-33.5 - 33.5/3.4 - 0.8,-15 + 1,0])
								rotate([180,0,90])
									color([1,0,0])
										import ("../../STL/666_1206.stl");

						}
					//závěs
					translate([-20,-5,18.5])
						rotate([180,0,90])
							color([1,0,1])
								import ("../../STL/666_1232.stl");
				}

		rotate([0,0,180])
			union(){
				translate([-24.4,40.7,19])
					rotate([rotor_flap0,180, - rotor_delta])
						union(){
							//list
							
							translate([-sirka_listu/2, delka_listu/2,6])
								rotate([0,rotor_blade_AOA,0])
										import ("../../STL/rotor_blade.stl");

							//podložka listu
							translate([-35/4,0,0])
								rotate([0,0,90])
									color([0,0,1])
										import ("../../STL/666_1247.stl");

							//kování
							translate([-33.5 - 33.5/3.4 - 0.8,-15 + 1,13])
								rotate([180,0,90])
									color([1,0,0])
										import ("../../STL/666_1206.stl");

							translate([-33.5 - 33.5/3.4 - 0.8,-15 + 1,0])
								rotate([180,0,90])
									color([1,0,0])
										import ("../../STL/666_1206.stl");

						}
					//závěs
					translate([-20,-5,18.5])
						rotate([180,0,90])
							color([1,0,1])
								import ("../../STL/666_1232.stl");
		}
			
		//domek
		translate([0,0,25])
			rotate([0,180,90 ])
				color([1,0.5,0])
					import ("../../STL/666_1207.stl");

		//ozubená řemenice
		translate([0,0,45])
			rotate([0,180,0])
				color([0.5,0,1])
					import ("../../STL/rotor_pulley.stl");
		}
*/
union(){
	//sestava rotorové hlavy
		rotate([0,0,90])
			color([0.5,1,1])
				import ("../../STL/888_1101.stl");

	//prerotator
	//translate([0, motor_distance, -global_clearance/2-10])
//translate([-prerotator_imitation_diameter/4,motor_distance - prerotator_imitation_diameter/2,0])
	//translate([-7,59,-111.8])
	//translate([0,motor_distance,plate_bearing_center_distance/2])
	//rotate([-rake_angle ,rake_angle,0])	
		//translate([-3,motor_distance - prerotator_imitation_diameter/1.5,prerotator_imitation_height/2.3])
		translate([0,motor_distance,plate_bearing_center_distance/2])	
			rotate([-rake_angle,rake_angle,0])	
				import ("../../STL/imitation/prerotator_imitation.stl");

	//prerotator pulley motor
	translate([0,0,50])
				import ("../../STL/prerotator_pulley_motor.stl");

}				

}

//rotate([0,0,-20])
666_2300(draft);

use <./../lib/naca4.scad>
include <../../parameters.scad>