use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;
$fs =  draft ? 50 :100;



module 888_3009(draft){    /////// 1. díl (AZ, YAW)

    8_shank_diameter = 8.4;		//průměr dříku + tolerance pro díru


    difference(){
        union (){
            cylinder(r = g3_0_cone1, h = g3_9_height - global_clearance, $fn=draft?50:100);
        }

        // srouby pri pridelani na strechu
        for (i = [1:4]){
            rotate([0, 0, i*90])
                translate([g3_0_srcew_dist, 0, -global_clearance/2])
                    cylinder(h = g3_9_height + global_clearance, d = M6_screw_diameter, $fn=draft?50:100);

            rotate([0, 0, i*90])
                translate([g3_0_srcew_dist, 0, -global_clearance])
                    cylinder(h=1, d1 = M6_screw_diameter+2, d2 = M6_screw_diameter, $fn=draft?50:100);

            rotate([0, 0, i*90 ])
                translate([g3_0_srcew_dist, 0, 2 * M6_nut_height])
                    cylinder(h = M6_nut_height + global_clearance, d = M6_nut_diameter, $fn = 6);

            rotate([0, 0, i*90])
                translate([-M6_nut_pocket/2 , g3_0_srcew_dist, 2 * M6_nut_height])
                    cube([M6_nut_pocket, 100, M6_nut_height + global_clearance]);


            rotate([0, 0, i*90 ])
                translate([g3_0_srcew_dist, 0, g3_9_height - 3 * M6_nut_height])
                    cylinder(h = M6_nut_height + global_clearance, d = M6_nut_diameter, $fn = 6);

            rotate([0, 0, i*90])
                translate([-M6_nut_pocket/2 , g3_0_srcew_dist, g3_9_height - 3 * M6_nut_height])
                    cube([M6_nut_pocket, 100, M6_nut_height + global_clearance]);

        }
    }
}

888_3009(draft);
