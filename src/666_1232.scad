module 666_1232(){

thickness = 12; 
	difference(){
        union(){
            cube([27.4,35,thickness]);
            translate([27.4,0,0])
                rotate([0,0,20])
                    cube([14.41,35,thickness]);
        }
        // díra pro domek
        translate([0,5-0.25,-1])
            cube([17.5,25.5,thickness + 2]);


        // díry pro čep
		translate([5,38,thickness/2])
            rotate([90,0,0])
                cylinder (h = 40, r = 4.1/2, $fn = 15);

        //díry pro přišroubování závěsu rotorového listu. 
        translate([27.4,0,0])
        rotate([0,0,20])
            union(){
                translate([14.41-6,6.46,-1]) 
                    cylinder (h = thickness + 2, r = M4_screw_diameter/2, $fn = 10);

                translate([14.41-6, 6.46+20,-1]) 
                    cylinder (h = thickness + 2, r = M4_screw_diameter/2, $fn = 10);
            }

	}
}
666_1232();

use <./lib/naca4.scad>
include <../parameters.scad>