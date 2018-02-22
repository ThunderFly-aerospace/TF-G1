use <./lib/naca4.scad>
include <../Parameters.scad>


module 666_1206(){
	union(){
		difference(){
            translate([110/2, 34/2, 0])
                minkowski(){
                    cube([110-14,34-14,1], center = true);
                    cylinder (h = 0.5, r = 7, $fn = 20, center = true);
                }

            // díry pro uchycení rotorového listu
			translate([23,7,-1])
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([43,25,-1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([63, 7, -1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([83, 23, -1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([103, 7, -1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

            //díry pro přišroubování závěsu rotorového listu. 

            translate([7,7,-1]) 
                cylinder (h = 10, r = M4_screw_diameter/2, $fn = 10);

            translate([7,27,-1]) 
                cylinder (h = 10, r = M4_screw_diameter/2, $fn = 10);

		}
	}
}
666_1206();
