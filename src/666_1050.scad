use <./lib/naca4.scad>
include <../parameters.scad>


module 666_1050(draft = true){

    plate_depth = 34;
    plate_length = 210;
    bevel_radius = 7;

    bevel_angle = 90 - atan((23-7)/(103-83));
    bevel_distance = tan(bevel_angle) * bevel_radius;
    echo("bevel angle", bevel_angle);
	union(){
		difference(){
            translate([plate_length/2, plate_depth/2, 0])
                minkowski(){
                    difference()
                    {
                        cube([plate_length- 2*bevel_radius, plate_depth - 2*bevel_radius,1], center = true);
                        translate([plate_length/2 - bevel_radius + bevel_distance, -plate_depth/2, -1])
                            rotate([0,0, bevel_angle])
                                cube([40,150,2]);
                    }

                    cylinder (h = 0.5, r = 7, $fn = draft ? 10 : 80, center = true);
                }



            // díry pro uchycení rotorového listu
			translate([100 + 23, 7,-1])
				cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

			translate([100 + 43, 25,-1])	
				cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

			translate([100 + 63, 7, -1])	
				cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

			translate([100 + 83, 23, -1])	
				cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

			translate([100 + 103, 7, -1])	
				cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

            //díry pro přišroubování závěsu rotorového listu. 

            translate([7,7,-1]) 
                cylinder (h = 10, d = 4, $fn = draft ? 20 : 80);

            translate([7,27,-1]) 
                cylinder (h = 10, d = 4, $fn = draft ? 20 : 80);

            // díry pro vzpěry mezi dva plechy 
            translate([43, plate_depth/2, -1])   
                cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);

            translate([43 + 40, plate_depth/2, -1])   
                cylinder (h = 10, d = 3, $fn = draft ? 10 : 20);



		}
	}
}
666_1050();
