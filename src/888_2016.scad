include <../parameters.scad>
use <lib/igus.scad>

wall = 6;
length = 47;
space = 1.5;
kstm = 8;
bolt_length = 30;
bolt_support_length = 15-M3_nut_height;
bolt_bearing_length = 15;       // Delka M4 sroubu skrze prirubu

pipe_recessed = 20;
kstm_offset = 5;

module 888_2016(){


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
                translate([-beam_patern/8, 0, -pipe_recessed])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 4, h = pipe_recessed/2);
                translate([beam_patern/8, 0, -pipe_recessed])
                    cylinder(d =  tube_for_undercarriage_outer_diameter + 4, h = pipe_recessed/2);

                rotate([-20, 0, 0]){
                    translate([0, 38/2, -kstm_offset + 5])
                        cylinder(d = 10, h = kstm_offset);
                    translate([0, -38/2, -kstm_offset + 5])
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

        rotate([-20, 0, 0])
        translate([0, 0, 5]){
            translate([0, 33/2, -3.5])
                cylinder(d = M4_screw_diameter, h = 10);
            translate([0, -33/2, -3.5])
                cylinder(d = M4_screw_diameter, h = 10);

            translate([0, 33/2, -9-15])
                cylinder(d = M4_nut_diameter, h = 20, $fn = 6);
            translate([0, -33/2, -9-15])
                cylinder(d = M4_nut_diameter, h = 20, $fn = 6);
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
        translate([-tube_for_undercarriage_outer_diameter/2-5, -tube_for_undercarriage_outer_diameter/2-10, 0])
            cube([tube_for_undercarriage_outer_diameter + 10 + beam_patern, tube_for_undercarriage_outer_diameter+20, 2 + pipe_recessed]);

        translate([beam_patern, 0, 2+global_clearance])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = 100);

        translate([0, 0, 2+global_clearance])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = 100);

        translate([0, 0, 10+3 + global_clearance]) rotate([90, 0, 0]){
            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            translate([beam_patern, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
        }

        rotate([90, 0, 0]) translate([beam_patern/2, 14, tube_for_undercarriage_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("888_2016", halign = "center", size = 6);
        rotate([90, 0, 0]) translate([beam_patern/2, 5, tube_for_undercarriage_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("drill end", halign = "center", size = 6);
    }
}


module 888_2016_drill_center(){

    difference(){
        translate([-tube_for_undercarriage_outer_diameter/2-5, -tube_for_undercarriage_outer_diameter/2-10, 0])
            cube([tube_for_undercarriage_outer_diameter + 10 + beam_patern, tube_for_undercarriage_outer_diameter+20,  25]);

        translate([beam_patern, 0, -global_clearance])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = 100);

        translate([0, 0, -global_clearance])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = 100);

        translate([0, 0, 25/2]) rotate([90, 0, 0]){
            cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            translate([beam_patern, 0, 0])
                cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 60);
            rotate([0, 90, 0])
                cylinder(d = M3_screw_diameter, h = 200, center = true, $fn = 60);
        }

        rotate([90, 0, 0]) translate([beam_patern/2, 14, tube_for_undercarriage_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("888_2016", halign = "center", size = 6);
        rotate([90, 0, 0]) translate([beam_patern/2, 5, tube_for_undercarriage_outer_diameter/2 + 10-0.1]) linear_extrude(0.2) text("drill center", halign = "center", size = 6);
    }
}

module 888_2016_pipe(){
    rotate([90, 0, 0])
    difference(){
        cylinder(d = tube_for_undercarriage_outer_diameter, h = chassis_suspension_basewidth, center = true, $fn = $preview? 10:90);
        cylinder(d = tube_for_undercarriage_outer_diameter-3, h = chassis_suspension_basewidth, center = true, $fn = $preview? 10:90);

        rotate([90, 0, 0])
            cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview? 10:50);

        rotate([0, 90, 0]){
            translate([chassis_suspension_basewidth/2 - 12, 0, 0])
                cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview? 10:50);
            translate([-chassis_suspension_basewidth/2 + 12, 0, 0])
                cylinder(d = M3_screw_diameter, h = 20, center = true, $fn = $preview? 10:50);

        }
    }
}


//translate([0, 0, pipe_recessed])
888_2016();

//translate([0, 50, 0])    888_2016_drill();
//translate([0, -50, 0]) 888_2016_drill_center();
