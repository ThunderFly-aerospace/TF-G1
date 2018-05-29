use <./lib/naca4.scad>
include <../Parameters.scad>

AOA = 3.0; // set Angle of Attact of the airfoil

module 666_1247(){
	union(){
		difference(){
			cube([100,35,12]);

			translate([9+ 20 + 20 + 20 + 20,35-7,-1])
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20 + 20 + 20, 35-23.6, -1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20 + 20,35-7,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20, 35-25, -1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9,35-7,-1])	
					cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([-1,0,(12-8)/4])		// set AOA
				rotate([AOA,0,0])		
					cube([200, 100, 8]);

            translate([50, 15, 11.5])
                            linear_extrude(0.5) 
                                text("H", size = 10, halign = "center", valign = "center", font = "PT Sans");

            translate([50, 15, 0])
                            linear_extrude(0.5) 
                                text("D", size = 10, halign = "center", valign = "center", font = "PT Sans");

		}
	}
}

module 666_1247_H(){
    intersection(){
        translate([-1,0,5])      
            cube([200, 100, 20]);
        666_1247();

    }
}

module 666_1247_D(){
    intersection(){
        translate([-1,0,0])      
            cube([200, 100, 5]);
        666_1247();

    }
}


666_1247_H();