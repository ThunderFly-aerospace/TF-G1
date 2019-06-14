draft = true;
include <../Parameters.scad>

rotx = ($t)*20 - 10;      //  -10 .. +10
roty = -(($t)*10 - 5);       //   -5 .. +5

rotx = 7.5;
roty = 5;

use <888_1015.scad>
use <888_1020.scad>


module efsm_12(){

    difference(){
        union(){
            //translate([-20, -20, 0])
                //cube([40, 40, 7]);

            intersection(){
                translate([0,0,0])
                    cylinder(h = bearing_efsm_12_ag, d = 12);

                translate([0,0, bearing_efsm_12_ag - bearing_efsm_12_B/2])
                    sphere(d=12, $fn = 50);
            }
        }
        //cylinder(h=20, d=12);
    }
}


module efsm_8(){
    translate([-33/2, -33/2, 0])
        cube([33, 33, 5.5]);

    //cylinder(h = 8.5, d = 18);

    translate([0,0,8.5])
        cylinder(h = 2, d1 = 18, d2 = 15);

    translate([0,0,6.5])
        #cylinder(h = 7.94/2, d = 2);

    translate([0, 0, 6.5])
        sphere(r=3, $fn = 50);
}


/* color([0.2, 0.2, 0.8, 0.6])
    translate([-7,0, 61])
        rotate([0,9,0])
            translate([0,0,7])
                efsm_12(); */

color([0.2, 0.2, 0.8, 0.6])
    translate([-6.8,0, 63])
        rotate([0,9,0])
            translate([0,0,7])
                efsm_12();

difference(){
    union(){
    color([0.8, 0.3, 0.3])
        888_1015();
    color([0.2, 0.8, 0.2, 0.9])
        translate([-4.5,0, 78])
            rotate([rotx,9+roty,0])
                translate([0,0,-2])
                    888_1020();

    }
    //translate([-250, 0, 0]) cube(500);
    //cube(500);
    
}
