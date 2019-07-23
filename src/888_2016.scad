include <../parameters.scad>
use <lib/igus.scad>

$fn = 80;


module 888_2016_sleeve(){
    wall = 6;
    length = 47;
    space = 1.5;
    kstm = 8;
    bolt_length = 30;
    bolt_support_length = 15-M3_nut_height;
    bolt_bearing_length = 15;       // Delka M4 sroubu skrze prirubu


    difference(){
        hull(){
            rotate([0, -90, 0])
                cylinder(d = main_tube_outer_diameter+wall*2, h = length, $fn = 80, center = true);
                translate([-length/2, -5, -main_tube_outer_diameter/2-15])
                    cube([length, 10, main_tube_outer_diameter/2]);
        }
        rotate([0, -90, 0])
            cylinder(d = main_tube_outer_diameter, h = length + global_clearance, $fn = 80, center = true);

        // zarez na stazeni trubky
        translate([-length/2 - global_clearance/2, -space/2, 0])
            cube([length + global_clearance, space, main_tube_outer_diameter+wall]);


        // diry pro pridelani loziska
        for (i=[1,-1]) {
            translate([kstm_flange_holes_distance(kstm)*i/2, 0, -main_tube_outer_diameter/2 - wall])
                cylinder(d = M4_screw_diameter, h = 40, $fn = 50, center = true);

            translate([kstm_flange_holes_distance(kstm)*i/2, 0, -main_tube_outer_diameter/2 - wall - global_clearance + (bolt_bearing_length-6) -10])
                cylinder(d = M4_nut_diameter, h = main_tube_inner_diameter, $fn = 6);
        }

        for (i=[1,-1]) {
            translate([length/3*i, 0, 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = main_tube_outer_diameter+2*wall + global_clearance, $fn = 50, center = true);

            translate([length*i/3, -bolt_length/2 , 0])
                rotate([90, 30, 0])
                        cylinder(d = M3_nut_diameter, h = 20, $fn = 6);

            translate([length*i/3, bolt_length/2 + 20 , 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
        }


        translate([0, 0, main_tube_outer_diameter/2 + 3])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, $fn = 60, center = true);

        translate([0, -bolt_support_length/2, main_tube_outer_diameter/2 + 3])
            rotate([90, 0, 0])
                cylinder(d = M3_nut_diameter, h = 50, $fn = 60);

        translate([0, bolt_support_length/2 + 50, main_tube_outer_diameter/2 + 4])
            rotate([90, 30, 0])
                cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
    }
}

module 888_2016_sleeve_drill(){
    wall = 10;
    length = 45;
    space = 1.5;
    kstm = 8;
    bolt_length = 35;
    bolt_support_length = 20;

    difference(){
        translate([-length/2, -main_tube_outer_diameter/2 - wall, -main_tube_outer_diameter/2 - wall])
            cube([length, main_tube_outer_diameter + 2*wall, main_tube_outer_diameter + 2*wall]);

        rotate([0, 90, 0])
            cylinder(d = main_tube_outer_diameter, h = length + global_clearance, center = true, $fn = 90);

        for (i=[1,-1]) {
            translate([length/3*i, 0, 0])
                rotate([90, 0, 0])
                    cylinder(d = M3_screw_diameter, h = main_tube_outer_diameter+2*wall + global_clearance, $fn = 50, center = true);
        }

        translate([0, 0, main_tube_outer_diameter/2 + wall - 0.2])
            linear_extrude(0.3)
                text("drill 888_2016", size = 4, valign = "center", halign = "center");
    }
}

module 888_2016(){

    wall = 2;
    screw_length = 35 - M3_nut_height*1.5;
    screw_from_end = 10+0.5;                    // Vzdalenost sroubu od konce trubky

    difference(){

        union(){
            hull(){
                translate([ kstm_flange_holes_distance(8)/2+2, 0, 0]) cylinder(d = M4_nut_diameter+4, h = 8, $fn = 60);
                translate([-kstm_flange_holes_distance(8)/2-2, 0, 0]) cylinder(d = M4_nut_diameter+4, h = 8, $fn = 60);
                cylinder(d = main_tube_outer_diameter+wall*2, h = 15);
                //translate([0, 13, 0]) cylinder(d = M4_nut_diameter+4, h = 15, $fn = 60);
                //translate([0, -13, 0]) cylinder(d = M4_nut_diameter+4, h = 15, $fn = 60);
            }
            hull(){
                cylinder(d = main_tube_outer_diameter+wall*2, h = 25);

                translate([0, 13, 2+screw_from_end]) cylinder(d = M4_nut_diameter+4, h = 8, $fn = 60, center = true);
                translate([0, -13, 2+screw_from_end]) cylinder(d = M4_nut_diameter+4, h = 8, $fn = 60, center = true);

            }
        }

        translate([0, 0, 2]) cylinder(d = main_tube_outer_diameter, h = 25);
        translate([ kstm_flange_holes_distance(8)/2+2, 0, 5]) rotate(30) cylinder(d = M4_nut_diameter, h = 20, $fn = 6);
        translate([-kstm_flange_holes_distance(8)/2-2, 0, 5]) rotate(30) cylinder(d = M4_nut_diameter, h = 20, $fn = 6);
        translate([ kstm_flange_holes_distance(8)/2+2, 0, -global_clearance]) cylinder(d = M4_screw_diameter, h = 5, $fn = 60);
        translate([-kstm_flange_holes_distance(8)/2-2, 0, -global_clearance]) cylinder(d = M4_screw_diameter, h = 5, $fn = 60);

        translate([0, 0, 2+screw_from_end]) rotate([90, 0, 0]){
            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            translate([0, 0, -screw_length/2-20]) cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
            translate([0, 0, screw_length/2]) cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
        }
    }

}


888_2016();
