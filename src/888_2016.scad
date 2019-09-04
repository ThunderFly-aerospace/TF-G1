    include <../parameters.scad>
use <lib/igus.scad>

$fn = 80;


module 888_2016(){
    wall = 6;
    length = 47;
    space = 1.5;
    kstm = 8;
    bolt_length = 30;
    bolt_support_length = 15-M3_nut_height;
    bolt_bearing_length = 15;       // Delka M4 sroubu skrze prirubu

    pipe_recessed = 20;
    kstm_offset = 5;


    difference(){
        union(){
            // otvory pro tyce
            hull(){
                translate([-beam_patern/2, 0, -pipe_recessed])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 6, h = pipe_recessed + 2);
                translate([beam_patern/2, 0, -pipe_recessed])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 6, h = pipe_recessed + 2);
            }

            // cast pro prirubove lozisko
            hull(){
                translate([-beam_patern/8, 0, -pipe_recessed/2 + 2])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 4, h = pipe_recessed/2);
                translate([beam_patern/8, 0, -pipe_recessed/2 + 2])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 4, h = pipe_recessed/2);

                rotate([0, 0, 0]){
                    translate([0, 38/2, -kstm_offset + 2])
                        cylinder(d = 10, h = kstm_offset);
                    translate([0, -38/2, -kstm_offset + 2])
                        cylinder(d = 10, h = kstm_offset);
                }
            }
        }

        // Otvory pro pricne tyce
        translate([-beam_patern/2, 0, -pipe_recessed - 0.1])
            cylinder(d =  tube_for_undercarriage_outer_diameter, h = pipe_recessed+0.2);
        translate([beam_patern/2, 0, -pipe_recessed - 0.1])
            cylinder(d =  tube_for_undercarriage_outer_diameter, h = pipe_recessed+0.2);

        // Otvory pro srouby do loziska
        translate([0, 0, 2]){
            translate([0, 33/2, -9])
                cylinder(d = M4_screw_diameter, h = 10);
            translate([0, -33/2, -9])
                cylinder(d = M4_screw_diameter, h = 10);

            translate([0, 33/2, -9])
                cylinder(d = M4_nut_diameter, h = 5, $fn = 6);
            translate([0, -33/2, -9])
                cylinder(d = M4_nut_diameter, h = 5, $fn = 6);
        }

        // diry pro sroub skrz tyce
        for (i=[0, 1]) mirror([i, 0, 0]){
            translate([beam_patern/2 + tube_for_undercarriage_outer_diameter/2 + 5, 0, -M3_screw_diameter/2 - 10])
                rotate([0, -90, 0])
                    cylinder(d = M3_screw_diameter, h = 20);

            translate([beam_patern/2 + tube_for_undercarriage_outer_diameter/2 +1.5 , 0, -M3_screw_diameter/2 - 10])
                rotate([0, 90, 0])
                    cylinder(d = M3_nut_diameter, h = 20);

            translate([beam_patern/2 - tube_for_undercarriage_outer_diameter/2 -3, 0, -M3_screw_diameter/2 - 10])
                rotate([0, -90, 0])
                    cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);

            translate([beam_patern/2 - tube_for_undercarriage_outer_diameter/2 -3, 0, -M3_screw_diameter/2 - 10 - M3_nut_diameter/2])
                rotate([0, -90, 0])
                    cube([M3_nut_diameter, 20, M3_nut_height]);
        }

    }
}


module 888_2016_drill(){
    screw_from_end = 10+0.5;                    // Vzdalenost sroubu od konce trubky

    difference(){
        translate([-tube_for_undercarriage_outer_diameter/2-10, -tube_for_undercarriage_outer_diameter/2-10, 0])
            cube([tube_for_undercarriage_outer_diameter + 20, tube_for_undercarriage_outer_diameter+20, 25]);

        translate([0, 0, 2+global_clearance])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = 100);

        translate([0, 0, 2+screw_from_end]) rotate([90, 0, 0]){
            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            //translate([0, 0, -screw_length/2-20]) cylinder(d = M3_nut_diameter, h = 20, $fn = 6);
            //translate([0, 0, screw_length/2]) cylinder(d = M3_nut_diameter, h = 20, $fn = 60);
        }

        rotate([90, 0, 90]) translate([0, 14, main_tube_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("888_2016", halign = "center", size = 6);
        rotate([90, 0, 90]) translate([0, 5, main_tube_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("drill", halign = "center", size = 6);


    }
}


888_2016();
//888_2016_drill();
