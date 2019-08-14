include <../parameters.scad>
use <888_1004.scad>

column_upper_diameter = 60;
column_lower_diameter = 608_bearing_outer_diameter*2;
column_height = 80;


module 888_2009(){
    difference(){

        //sloupek
        hull(){

            translate([-engine_holder_beam_depth-3, -(beam_width+10)/2, -beam_thickness/2])
                cube([engine_holder_beam_depth+3, beam_width+10, beam_thickness/2 - global_clearance]);

            translate([0, 0, -column_height]) cylinder (h=column_height, d=column_lower_diameter, $fn=50);
        }

        translate([-engine_holder_beam_depth, 0, 0]) beam_plug(100);


        translate([-engine_holder_beam_depth + beam_patern/2, (beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -10])
                rotate(0)
                    cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
            rotate(0)
                translate([-M4_nut_diameter/2, 0, -10])
                    cube([M4_nut_diameter, 50, M4_nut_height]);
        }

        translate( [-engine_holder_beam_depth + beam_patern/2, -(beam_main_pipe_distance/2-beam_main_pipe_thickness-3), -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -10])
                rotate(0)
                    cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
            rotate(180)
                translate([-M4_nut_diameter/2, 0, -10])
                    cube([M4_nut_diameter, 50, M4_nut_height]);
        }

        translate([-engine_holder_beam_depth + beam_patern*1.5, 0, -beam_thickness/2]){
            translate([0, 0, -30])
                cylinder(d = M4_screw_diameter, h = 50, $fn = 20);
            translate([0, 0, -10])
                rotate(30)
                    cylinder(d = M4_nut_diameter, h = M4_nut_height, $fn = 6);
            rotate(-90)
                translate([-M4_nut_diameter/2, 0, -10])
                    cube([M4_nut_diameter, 50, M4_nut_height]);
        }


        //dira pro hlavni M5 osou
        translate([0, 0, -1-column_height])
            cylinder(h=column_height-80, d=M5_screw_diameter, $fn=50);

        //kapsa pro M5 matici
        rotate([0, 0, 90])
            translate([0, -M5_nut_pocket/2, column_height*1.5])
                hull() {
                    translate([0,M5_nut_pocket/2,0]) cylinder(h=M5_nut_height, d=M5_nut_diameter, $fn=6);
                    cube ([column_upper_diameter/2, M5_nut_pocket, M5_nut_height ]);
                }

        //diry pro M3 srouby


        //kapsy pro M3 matice
    }
}

888_2009();
