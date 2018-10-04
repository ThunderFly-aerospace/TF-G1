use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1247(angle_of_attact){
	union(){
		difference(){
			cube([100,35,12]);

			translate([9+ 20 + 20 + 20 + 20,35-7,-1])
				cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20 + 20 + 20, 35-23, -1])	
				cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20 + 20,35-7,-1])	
    			cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9 + 20, 35-25, -1])	
    			cylinder (h = 20, r = 3.6/2, $fn = 10);

			translate([9,35-7,-1])	
				cylinder (h = 20, r = 3.6/2, $fn = 10);

            translate([50, 15, 11.5])
                linear_extrude(0.5) 
                    text("H", size = 10, halign = "center", valign = "center", font = "PT Sans");

            translate([30, 25, 11.5])
                linear_extrude(0.5) 
                    text( str("AOA: ", angle_of_attact), size = 5, halign = "center", valign = "center", font = "PT Sans");

            translate([50, 15, 0.5])
                rotate([0,180, 0])       
                linear_extrude(0.5) 
                    text("D", size = 10, halign = "center", valign = "center", font = "PT Sans");

            translate([30, 25, 0.5])
                rotate([0,180, 0])       
                linear_extrude(0.5) 
                    text(str("AOA: ", angle_of_attact), size = 5, halign = "center", valign = "center", font = "PT Sans");

            translate([0,35/2,12/2])      // set AOA
                rotate([angle_of_attact,0,0])       
                    cube([400, 400, 8], center = true);
		}
	}
}

module 666_1247_H(angle_of_attact){
    intersection(){
        translate([-1,0,5])      
            cube([200, 100, 20]);
        666_1247(angle_of_attact);
    }
}

module 666_1247_D(angle_of_attact){
    intersection(){
        translate([-1,0,0])      
            cube([200, 100, 5]);
        666_1247(angle_of_attact);
    }
}


666_1247_H(rotor_blade_AOA);

666_1247_D(rotor_blade_AOA);