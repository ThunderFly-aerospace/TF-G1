//========== DRŽÁK PÍSTU ==========//

include <../parameters.scad>

wall_thickness = 2;

module 888_2025() {
    difference() {
        cylinder(d=RT57208M25_BE+wall_thickness, h=RT57208M25_MR+RT57208M25_LB+wall_thickness, $fn=60);

        translate([0, 0, -0.1])
            intersection() {
                cylinder(d=RT57208M25_BE, h=RT57208M25_MR+RT57208M25_LB+0.1, $fn=50);

                translate([RT57208M25_EW/-2, RT57208M25_BE/-2, 0])
                    cube([RT57208M25_EW, RT57208M25_BE, RT57208M25_MR+RT57208M25_LB+0.1]);
            }

        translate([0, 0, RT57208M25_LB])
            rotate([0, 90, 0])
                cylinder(d=M3_screw_diameter, h=100, $fn=20, center=true);
    }
}

888_2025();