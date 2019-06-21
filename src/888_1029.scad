//Navrh disku pro mechove kolo

include <../Parameters.scad>

module 888_1029 (nut = true) {
    difference() {
        union() {
            cylinder(h=wheel_disc_upper_thickness, d=wheel_disc_diameter, $fn=50);
            cylinder(h=wheel_disc_upper_thickness+wheel_inner_thickness/2-0.5, d=wheel_inner_diameter, $fn=50);
        }

        translate([0, 0, 608_bearing_thickness/2 + wheel_disc_upper_thickness+2])
            cylinder(h=wheel_inner_thickness/2, d=wheel_inner_diameter-M3_nut_diameter-5, $fn=50);

        for (i=[0:2]) {
            //diry na srouby
            rotate([0,0,120*i])
                translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                    cylinder(h=wheel_inner_thickness, d=M3_screw_diameter, $fn=60);

            //diry na matice nebo zapusteni hlavy sroubu M3x35
            rotate([0,0,120*i])
                  translate([wheel_inner_diameter/2-M3_screw_diameter+0.5, 0, -1])
                      cylinder(h=M3_screw_head_height+2, d=M3_nut_diameter, $fn= nut? 6 : 50);

          }

        //dira na M5 sroub
        translate([0, 0, 608_bearing_thickness+global_clearance])
            cylinder (h=wheel_inner_thickness, d=608_bearing_outer_diameter-6, $fn=60);

        //dira pro lozisko 608
        translate([0, 0, -1])
            cylinder(h=608_bearing_thickness+1, d=608_bearing_outer_diameter, $fn=50);
    }
}

888_1029(true);
