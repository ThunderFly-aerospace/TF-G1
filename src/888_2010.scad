//BACK WHEEL HOLDER

include <../parameters.scad>

wheel_holder_thickness = 30;
hole_for_pipe_diameter = 25;
side_hole_diameter = 10;
wheel_holder_diameter = hole_for_pipe_diameter + M3_nut_diameter*2 +10;
distance_between_parts = 3;
M3_screw_lenght = 20;
M3_nut_pos = M3_screw_lenght/2;

//valcova cast
module 888_2010_1 () {
    difference() {
        cylinder (h=wheel_holder_thickness, d=wheel_holder_diameter, $fn=50);

    //dira pro trubku d=25 mm
        translate([0, 0, -1])
            cylinder (h=wheel_holder_thickness+2, d=hole_for_pipe_diameter, $fn=50);

        translate([-distance_between_parts/2, -wheel_holder_diameter/2, -1])
            cube (wheel_holder_diameter);

    //otvory pro M3x20 srouby pro dotazeni na trubku
        translate([0, wheel_holder_diameter/2-8 , wheel_holder_thickness/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=50);
            }
        }

        translate([0, wheel_holder_diameter/2-8 , wheel_holder_thickness*3/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=50);
            }
        }

        translate([0, -wheel_holder_diameter/2+8 , wheel_holder_thickness*3/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=50);
            }
        }

        translate([0, -wheel_holder_diameter/2+8 , wheel_holder_thickness/4]) {
            rotate([0, -90, 0])  {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=50);
            }
        }
    }
}

//protahlejsi cast s diru na bocni trubku
module 888_2010_2 () {
    difference() {
        hull(){
            translate([-wheel_holder_diameter+10, 0, wheel_holder_thickness/2])
                cube ([side_hole_diameter+8, side_hole_diameter+8,wheel_holder_thickness], center=true);
            cylinder (h=wheel_holder_thickness, d=wheel_holder_diameter, $fn=50);
        }

    //dira pro trubku d=25 mm
        translate([0, 0, -1])
            cylinder (h=wheel_holder_thickness+2, d=hole_for_pipe_diameter, $fn=50);

        translate([-distance_between_parts/2, -wheel_holder_diameter/2, -1])
            cube (wheel_holder_diameter);

    //dira pro bocni trubku
        translate([-wheel_holder_diameter-hole_for_pipe_diameter/2-5, 0, wheel_holder_thickness/2])
            rotate ([0,90,0])
                cylinder (h=wheel_holder_diameter, d=side_hole_diameter, $fn=50);

    //otvor na M3 sroub pro bocni trubku
        translate([-22, 0, -1]) {
            cylinder(h=wheel_holder_thickness+2, d=M3_screw_diameter, $fn=50);
            cylinder(h=M3_screw_head_height+1, d=M3_nut_diameter, $fn=50);
        }
        translate([-22, 0, wheel_holder_thickness-M3_nut_height])
            cylinder(h=M3_nut_height+1, d=M3_nut_diameter, $fn=6);

    //otvory pro M3x20 srouby pro dotazeni na trubku
        translate([0, wheel_holder_diameter/2-8 , wheel_holder_thickness/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=6);
            }
        }

        translate([0, wheel_holder_diameter/2-8 , wheel_holder_thickness*3/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=6);
            }
        }

        translate([0, -wheel_holder_diameter/2+8 , wheel_holder_thickness*3/4]) {
            rotate([0, -90, 0]) {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=6);
            }
        }

        translate([0, -wheel_holder_diameter/2+8 , wheel_holder_thickness/4]) {
            rotate([0, -90, 0])  {
                cylinder(h=wheel_holder_diameter, d=M3_screw_diameter, $fn=50);
                translate([0, 0, M3_nut_pos])
                    cylinder(h=wheel_holder_diameter, d=M3_nut_diameter, $fn=6);
            }
        }
    }
}

888_2010_1 ();

mirror ([1, 0, 0])
    888_2010_2 ();
