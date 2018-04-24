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

		//zábrana vlevo
		translate([0,0,10])
			color([0.5,0,0])
				cube([10,80,40]);				//zábrana
		
	difference(){
		translate([-10.5,40 - 12.5/2,10 + 50/3 - 25])
				cube([11.5,12.5,27]);				//koska pro hrot
		
		translate([-14,31.25,-4])
			rotate([16,0,0])
				cube([15,10,35]);

		translate([-14,39.55,0])
			rotate([-16,0,0])
				cube([15,10,35]);

		translate([-5,30,-1.45])
				cube([6,20,25]);
	}
		
		//zábrana vpravo
		translate([115,0,10])
			color([0.5,0,0])
				cube([10,80,40]);
	

	difference(){
		translate([ + 124,40 - 12.5/2,10 + 50/3 - 25])
				cube([11.5,12.5,27]);				//koska pro hrot
		
		translate([ + 124,31.25,-4])
			rotate([16,0,0])
				cube([15,10,35]);

		translate([124,39.55,0])
			rotate([-16,0,0])
				cube([15,10,35]);

		translate([124,30,-1.45])
				cube([6,20,25]);
	}


//final module kolébka	
}


translate([10 + 2.5,34.972,50.063])
		888_1009_cradle(draft);

/*translate([10,45,100])
		888_1009_shape(draft);
*/
		888_1009_base(draft);



use <./lib/naca4.scad>
include <../Parameters.scad>

