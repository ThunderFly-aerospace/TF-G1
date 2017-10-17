use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1028(){
//mirror ([1,0,0])

    //BASIC DROP
    render(convexity = 2) difference (){

        union (){
            translate([0,0,-8.5])
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0030, L = 140)); 
                          square(200, 200); 
                        }


        //TRIANGLE PROFILE

        //UPPER
            translate([0,-10,0])
                rotate ([0,-90, 160])			//rotate([0,-90,152.5])
                    airfoil(naca = 0005, L = 95, N=101, h = 149, open = false);
        //LOWER

            translate([0,10,0])
                rotate ([0,-90,-160])		//rotate([0,-90,-152.5])
                    airfoil(naca = 0005, L =95, N=101, h = 149, open = false);


        //VERTICAL

            translate ([140,75,0])//translate([115,74,0])
                rotate([90,-87,0])
                    airfoil(naca = 0005, L = 150, N=101, h = 150, open = false);
        }


        //straightening ribbons 
        translate([140/2,-100,40])
            cube([0.5,200,15]);
        translate([125,0,45])
            cube([50,0.5,30]);



        //tube
        translate([0,0,-10])
            cylinder (h = 90, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);

        //screw
        translate ([-150*0.4,0,150*0.4/2])
            rotate ([0,90,0])
                cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4])
            rotate ([0,90,0])
                cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

        //nut
        translate([17.5,0,150*0.4])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


        translate([17.5,0,150*0.4/2])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);



        //cleanup for printing
        translate ([-149.9,-75,-1])
            cube ([150,150,170]);

        translate ([-50,-100,-200])
            cube ([200,200,200]);
    }
}



666_1028();

//For printing size limits check.
//translate([0,-75,0])
//%    cube ([150,150,150]);









