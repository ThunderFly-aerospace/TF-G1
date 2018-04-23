//vyvažovací přípravek
draft = true;

module 888_1009_base(draft){		//základna

			cube([150,150,20]);			//základní plocha
	
//podpěra vpravo
	translate([140,15,20])
		rotate([90,0,90])
			
			difference(){
					cube([120,80,10]);			//základní plocha pro zkosení
				translate([0,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([120,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([60,31.73,-5])
					rotate([0,0,45])
						cube([20,20,20]);		//vyskousnutí


			}

//podpěra vlevo
	translate([0,15,20])
		rotate([90,0,90])
			
			difference(){
					cube([120,80,10]);			//základní plocha pro zkosení
				translate([0,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([120,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([60,31.73,-5])
					rotate([0,0,45])
						cube([20,20,20]);		//vyskousnutí


			}

//final module základna
}


module 888_1009_shape(draft){

union(){
difference(){
	//základní deska
		color([0,0.5,0])
			cube([130,60,20]);
	//otvor pro rotorový list
	translate([75,-60,-5])
		rotate([0,0,30])
			%cube([70,20,40]);
}

//výstupek pro nasazení rysky vlevo
	translate([10,30,20])
		cylinder(h = 10, r = 5, $fn = draft ? 50 : 100);

//výstupek pro nasazení rysky vpravo
	translate([120,30,20])
		cylinder(h = 10, r = 5, $fn = draft ? 50 : 100);


}


//final module tvar
}


module 888_1009_cradle(draft){		//kolébka
		//základní deska
		color([0.5,0,0])
			cube([125,80,10]);

	union(){
		//zábrana vlevo
		translate([0,0,10])
			color([0.5,0,0])
				cube([10,80,40]);				//zábrana
		translate([-12.5,40 - 12.5/2,10 + 50/3 - 10])
				cube([12.5,12.5,5]);				//koska pro hrot
		translate([-12.5/2 - 2.5,40,10 + 50/3 - 10 - 20])
			rotate([0,0,45])
				cylinder(h = 20, r1 = 0, r2 = 12.5/2, $fn = 4);

		//zábrana vpravo
		translate([115,0,10])
			color([0.5,0,0])
				cube([10,80,40]);
	}
//final module kolébka	
}


translate([10 + 2.5,35,55])
		%888_1009_cradle(draft);


translate([10,45,100])
		888_1009_shape(draft);

		888_1009_base(draft);



use <./lib/naca4.scad>
include <../Parameters.scad>

