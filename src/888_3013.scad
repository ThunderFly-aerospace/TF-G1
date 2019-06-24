module 888_3013_A (draft = true){

width = 90;
depth = 45;
height = 10;
tube_lenght = 70;

// TODO:  Slaoučit do jednoho dílu který se pak bude dělit na díl A a díl B až z celkového modelu. Důvodem je lepší udržitelnost kódu.

slit_width = 10-0.2;

    difference(){
        union(){
            // zakladni trubka
            rotate([0, 90, 0])
                translate([0, 0, -tube_lenght/2])
                    cylinder(d = main_tube_outer_diameter * 1.5, h = tube_lenght, $fn=200);

            // sloupky pro srouby
            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);

            hull(){
                translate([-main_tube_outer_diameter, -slit_width/2, 0])
                    cube([main_tube_outer_diameter*2, slit_width, 1]);
                translate([0, slit_width/2, main_tube_outer_diameter])
                    rotate([90, 0, 0])
                        cylinder(d = 10, h=slit_width);
            }
        }
        rotate([0, 90, 0])
            translate([0, 0, -tube_lenght/2])
                cylinder(d = main_tube_outer_diameter + global_clearance, h = tube_lenght, $fn=200);

            // diry pro srouby
            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=50);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=50);

            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);

            // sroub skrz kloub
            translate([0, 50, main_tube_outer_diameter])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h=100, $fn=20);

            translate([-100, -100, -30])
                cube([200, 200, 30]);
    }
}

module 888_3013_B(){

    width = 90;
    depth = 45;
    height = 10;
    tube_lenght = 70;


    difference(){
        union(){
            // zakladni trubka
            rotate([0, 90, 0])
                translate([0, 0, -tube_lenght/2])
                    cylinder(d = main_tube_outer_diameter * 1.5, h = tube_lenght, $fn=200);

            // sloupky pro srouby
            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=9, h = main_tube_outer_diameter/3, $fn=50);

        }
        rotate([0, 90, 0])
            translate([0, 0, -tube_lenght/2])
                cylinder(d = main_tube_outer_diameter + global_clearance, h = tube_lenght, $fn=200);

            // diry pro srouby
            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=20);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=20);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=20);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, 0])
                cylinder(d=M3_screw_diameter, h = main_tube_outer_diameter/3, $fn=20);

            translate([tube_lenght/4, main_tube_outer_diameter/2 +3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([-tube_lenght/4, main_tube_outer_diameter/2 +3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([tube_lenght/4, -main_tube_outer_diameter/2 -3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);
            translate([-tube_lenght/4, -main_tube_outer_diameter/2 -3, main_tube_outer_diameter/3 - M3_nut_height])
                cylinder(d=M3_nut_diameter, h = main_tube_outer_diameter/3, $fn=6);

            translate([-100, -100, -30])
                cube([200, 200, 30]);
    }
}

rotate([0, 180, 0])
    888_3013_A();
888_3013_B();

include <../parameters.scad>
