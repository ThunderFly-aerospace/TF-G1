use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1018(){
union(){
	difference(){
				cylinder (h = 10, r1 = (main_tube_outer_diameter*1.2)/2, r2 = (main_tube_outer_diameter*1.2)/2, $fn = 100);
		translate([0,0,-2])	
				cylinder (h = 14, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 100);
		translate([-2,-main_tube_outer_diameter,-2])		
				cube([main_tube_outer_diameter*2, main_tube_outer_diameter*2, main_tube_outer_diameter]);

	}
	difference(){
		translate([-2,-23,0])
				cube([2,46,10]);
		translate([0,0,-2])			
				cylinder (h = 14, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 100);
	//otvory pro šrouby
		translate([-15,(main_tube_outer_diameter*1.2)/2+4,5])
			rotate([0,90,0])
				cylinder(h = 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
		translate([-15,-(main_tube_outer_diameter*1.2)/2-4,5])
			rotate([0,90,0])
				cylinder(h = 30, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);


	//otvor pro matku
		translate([-3,(main_tube_outer_diameter*1.2)/2+4,5])
			rotate([0,90,0])
                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
		translate([-3,-(main_tube_outer_diameter*1.2)/2-4,5])
			rotate([0,90,0])
                cylinder(h = Nut_height_M3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

	}
}





}
666_1018();