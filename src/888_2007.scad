include <../Parameters.scad>

module 888_2007(draft = true){

    difference(){
        union(){
            cylinder(d = 70, h = 5, $fn = draft?50:100);
            translate([0,0,5])
                cylinder(d1 = 70, d2 = bearing_efsm_10_d + 3, h = 10, $fn = draft?50:100);

            translate([0,0,15])
                cylinder(d = bearing_efsm_10_d, h = 9/2, $fn = draft?50:100);

        }
            
        // diry pro srouby do podlozky
        translate([0, -46/2, 0])
        {
            cylinder(d = M4_screw_diameter, h = 10, $fn=50);
            translate([0,0,5])
                cylinder(d = M4_nut_diameter, h = 3 * M4_nut_height, $fn = 6);
        }
        translate([0, 46/2, 0]){
            cylinder(d = M4_screw_diameter, h = 10, $fn = 50);
            translate([0,0,5])
                cylinder(d = M4_nut_diameter, h = 3 * M4_nut_height, $fn = 6);
        }

        cylinder(d = M6_screw_diameter, h = 20, $fn = draft?50:100);

        cylinder(d = M6_nut_diameter, h = 7, $fn = 6);

    }
}

888_2007();