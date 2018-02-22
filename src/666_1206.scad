use <./lib/naca4.scad>
include <../Parameters.scad>


module 666_1206(){
	union(){
		difference(){
            translate([-10,0,0])
			cube([110,35,2]);

            // díry pro uchycení rotorového listu
			translate([100-9,7,-1])
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20,25,-1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20,7,-1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20,23,-1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20-20,7,-1])	
				cylinder (h = 10, r = 3.6/2, $fn = 10);

            //díry pro přišroubování závěsu rotorového listu. 

            translate([-10+7,7,-1]) 
                cylinder (h = 10, r = M4_screw_diameter/2, $fn = 10);

            translate([-10+7,27,-1]) 
                cylinder (h = 10, r = M4_screw_diameter/2, $fn = 10);

		}
	}
}
666_1206();