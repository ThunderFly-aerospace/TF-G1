draft = true;
include <../Parameters.scad>

rotx = ($t)*20 - 10;      //  -10 .. +10
roty = -(($t)*10 - 5);       //   -5 .. +5

rotx = 0;
roty = 0;

use <888_1015.scad>
use <888_1020.scad>
use <lib/servo.scad>


module efsm_12(){

    difference(){
        union(){

            intersection(){
                translate([0,0,0])
                    cylinder(h = bearing_efsm_12_ag, d = 12);

                translate([0,0, bearing_efsm_12_ag - bearing_efsm_12_B/2])
                    sphere(d=12, $fn = 50);
            }
        }
        cylinder(h=20, d=12);
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

color([0.2, 0.2, 0.8, 0.6])
    translate([-6.8,0, 0])
        rotate([0,9,0])
            translate([0,0,0])
                efsm_12();

difference(){
    union(){
    color([0.8, 0.3, 60])
        rotate([0, -9, 0])
            translate([4.2, 0, -78.5])
                888_1015();

    rotate([0, -9, 0]) translate([25, -43, -56]) rotate([0, 180, 0]) LW_20MG();

    color([0.2, 0.8, 0.2, 0.9])
        translate([0,0, 0])
            rotate([rotx,roty,0])
                translate([0,0,0])
                    888_1020();

    //translate([40, -40, -48])
    //    rotate([0, 3, 0])
    //        cube([10, 10, 50]);

    }

translate([0, 0, -250])
    cube(500);

}
