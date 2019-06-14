//valec k disku do mechoveho kola

include <../Parameters.scad>

cylinder_1_thickness = 4;
cylinder_1_diameter = 608_bearing_outer_diameter+2;
cylinder_2_thickness = 5;
cylinder_2_diameter = 608_bearing_inner_diameter+2;

module 888_1030 () {
    difference() {
        union() {
            cylinder(h=cylinder_1_thickness, d=cylinder_1_diameter, $fn=50 );
            cylinder(h=cylinder_2_thickness, d=cylinder_2_diameter, $fn=50 );
            cylinder(h=wheel_inner_thickness/2+wheel_disc_upper_thickness+608_bearing_thickness/2+cylinder_1_thickness,
                  d=608_bearing_inner_diameter, $fn=50);
        }
        translate([0,0,-1])
            cylinder(h=wheel_inner_thickness, d=M5_screw_diameter, $fn=50);
    }
}

888_1030();
