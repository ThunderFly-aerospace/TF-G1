include <../parameters.scad>

module 888_1029 () {
    difference() {
        union() {
            cylinder(h=wheel_disc_upper_thickness, d=wheel_inner_diameter+wheel_disc_upper_difference, $fn=50);
            cylinder(h=wheel_inner_thickness/2, d=wheel_inner_diameter, $fn=50);
        }
        translate([0, 0, 608_bearing_thickness/2 + wheel_disc_upper_thickness])
            cylinder(h=wheel_inner_thickness/2, d=wheel_inner_diameter-M3_nut_diameter-5, $fn=50);

        //diry na srouby
        translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
            cylinder(h=wheel_inner_thickness, d=M3_screw_diameter, $fn=50);

        rotate([0,0,120])
            translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                cylinder(h=wheel_inner_thickness, d=M3_screw_diameter, $fn=50);

        rotate([0,0,-120])
            translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                cylinder(h=wheel_inner_thickness, d=M3_screw_diameter, $fn=50);

        //diry na matice
        translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
              cylinder(h=M3_nut_height+1, d=M3_nut_diameter, $fn=6);

        rotate([0,0,120])
              translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                  cylinder(h=M3_nut_height+1, d=M3_nut_diameter, $fn=6);

        rotate([0,0,-120])
              translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                  cylinder(h=M3_nut_height+1, d=M3_nut_diameter, $fn=6);

        //dira na M5 sroub
        translate([0, 0, -1])
            cylinder (h=wheel_inner_thickness, d=M5_screw_diameter, $fn=50);

        //dira pro lozisko 608
        translate([0, 0, -608_bearing_thickness/2])
            cylinder(h=608_bearing_thickness, d=608_bearing_outer_diameter, $fn=50);
    }
}

888_1029();
