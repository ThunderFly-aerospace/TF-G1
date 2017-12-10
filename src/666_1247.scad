use <./lib/naca4.scad>
include <../Parameters.scad>

AOA = 3.0; // set Angle of Attact of the airfoil

module 666_1247(){
	union(){
		difference(){
			cube([100,35,2.9]);

			translate([100-9,7,-1])
				rotate([AOA,0,0])
					cylinder (h = 10, r = 3.6/2, $fn = 10);
			translate([100-9,35-7,-1])
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20,25,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);
			translate([100-9-20,35-25,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20,7,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);
			translate([100-9-20-20,35-7,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20,23,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);
			translate([100-9-20-20-20,35-23,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([100-9-20-20-20-20,7,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);
			translate([100-9-20-20-20-20,35-7,-1])	
				rotate([AOA,0,0])	
					cylinder (h = 10, r = 3.6/2, $fn = 10);

			translate([-1,0,1.07])		// set AOA
				rotate([AOA,0,0])		
					cube([200, 100, 10]);
		}
	}
}
666_1247();