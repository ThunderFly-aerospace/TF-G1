use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1028(){
//mirror ([1,0,0])



//BASIC DROP
difference (){

    union (){
        translate([0,0,-8.5])
            rotate_extrude($fn = 100)
                rotate([0,0,90])
                    difference()
                    {

                      polygon(points = airfoil_data(naca=0030, L = 130)); 
                      square(200, 200); 
                    }


    //TRIANGLE PROFILE

    //UPPER
        translate([0,0,0])
            rotate([0,-90,152.5])
                airfoil(naca = 0008, L = 50, N=101, h = 130, open = false);
    //LOWER

        translate([0,0,0])
            rotate([0,-90,-152.5])
                airfoil(naca = 0008, L =50, N=101, h = 130, open = false);


    //VERTICAL

        translate([115,74,0])
            rotate([90,-90,0])
                airfoil(naca = 0008, L = 70, N=101, h = 148, open = false);
    }


    //tube
    translate([0,0,-10])
        cylinder (h = 60, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);

    //screw
    translate ([-150*0.4,0,150*0.4/2])
        rotate ([0,90,0])
            cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

    translate ([-150*0.4,0,150*0.4])
        rotate ([0,90,0])
            cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

    //nut
    translate([-150*0.4/2,0,150*0.4])
        rotate([0,90,0])
            %cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


    translate([-150*0.4/2,0,150*0.4/2])
        rotate([0,90,0])
            cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);



    //for printing
    translate ([-149.9,-75,-1])
        cube ([150,150,170]);

    translate ([-50,-100,-200])
        cube ([200,200,200]);
}



}
666_1028();









