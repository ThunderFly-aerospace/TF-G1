

wall_thickness=10; 

module 888_1009_cradle_half(x_size = 100, y_size = 20, z_size = 20, thickness = 10){        //kolébka
    //základní deska
    translate([0,-y_size/2,0])
        cube([x_size/2 - wall_thickness*1.5,y_size,thickness]);


    difference(){
        translate([x_size/2 - wall_thickness*2.5, -y_size/2, 0])
            cube([wall_thickness*3.5,y_size,wall_thickness*2]);
        

        translate([x_size/2 - thickness*1.5 , 0, 6])
            rotate([-16,0,0])
                translate([0, 0, -6])
                    cube([thickness*2, y_size,70]);

        mirror([0,1,0])
        translate([x_size/2 - thickness*1.5 , 0,6])
            rotate([-16,0,0])
                translate([0, 0, -6])
                    cube([thickness*2, y_size,70]);


        // zůžení přesahující kostky
        translate([x_size/2,-25,25/2])
            cube([wall_thickness*2,30,50],center = true);

        translate([x_size/2,25,25/2])
            cube([wall_thickness*2,30,50],center = true);

    }
}


module 888_1009_cradle(x_size = 180, y_size = 80, z_size = 20, thickness = 10){     //kolébka

    888_1009_cradle_half();
    mirror([1,0,0])
        888_1009_cradle_half();

    thickness = 12; 
    translate([0,0,thickness/2])
        rotate([0,0,90])
            difference(){
                cube([50,35,thickness], center = true);


                //díry pro přišroubování závěsu rotorového listu. 
                translate([20,0,0])
                    union(){
                        translate([0,10, 0]) 
                            cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);

                        translate([0, -10, 0]) 
                            cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);
                    }

                translate([-20,0,0])
                    union(){
                        translate([0,10, 0]) 
                            cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);

                        translate([0, -10, 0]) 
                            cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);
                    }



            }
}

        888_1009_cradle();
/*
translate([10,45,100])
        888_1009_shape();
*/




module crandle(){

thickness = 12; 
	difference(){
        cube([50,35,thickness], center = true);


        //díry pro přišroubování závěsu rotorového listu. 
        translate([20,0,0])
            union(){
                translate([0,10, 0]) 
                    cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);

                translate([0, -10, 0]) 
                    cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);
            }

        translate([-20,0,0])
            union(){
                translate([0,10, 0]) 
                    cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);

                translate([0, -10, 0]) 
                    cylinder (h = 2*thickness, r = M4_screw_diameter/2, $fn = 10, center = true);
            }



	}
}
//crandle();

include <../parameters.scad>