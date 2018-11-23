include <../Parameters.scad>

module 888_2007(draft = true){

    screw_length = 30;

    difference(){
        union(){
            cylinder(d = 70, h = 5, $fn = draft?50:100);
            translate([0,0,5])
                cylinder(d1 = 70, d2 = bearing_efsm_10_d + 3, h = screw_length, $fn = draft?50:100);

            translate([0,0, 5 + screw_length])
                cylinder(d = bearing_efsm_10_d, h = 9, $fn = draft?50:100);

        }
            
        // diry pro srouby do podlozky
        translate([0, -46/2, 0])
        {
            cylinder(d = M4_screw_diameter, h = 10, $fn=50);
            translate([0,0,5])
                cylinder(d = M4_nut_diameter, h = 10 * M4_nut_height, $fn = 6);
        }
        translate([0, 46/2, 0]){
            cylinder(d = M4_screw_diameter, h = 10, $fn = 50);
            translate([0,0,5])
                cylinder(d = M4_nut_diameter, h = 10 * M4_nut_height, $fn = 6);
        }

        cylinder(d = M8_screw_diameter - 0.2, h = 2 * screw_length, $fn = draft?50:100);

        cylinder(d = M8_nut_diameter, h = 5 + screw_length + 9  - (screw_length - 7), $fn = 6);

    }
}

888_2007();