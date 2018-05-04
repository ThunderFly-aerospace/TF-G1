use <./lib/naca4.scad>
include <../Parameters.scad>

AOA = 3.0; // set Angle of Attact of the airfoil

module 666_1247(){
	union(){
		difference(){
			cube([100,35,12]);

			translate([100-9,35-7,-1])
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([100-9-20,35-25,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([100-9-20-20,35-7,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20,35-23,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20-20,35-7,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([-1,0,1.07-0.5])		// set AOA
				rotate([AOA,0,0])		
					cube([200, 100, 8]);
		}
	}
}
666_1247();