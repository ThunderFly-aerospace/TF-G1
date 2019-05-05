include <../Parameters.scad>

module 888_2007(draft = true){

    screw_length = 30;
    diameter = 75;
    distance_between_screws = 42.5;

    difference(){
        union(){
            cylinder(d = diameter, h = 5, $fn = draft?50:100);
            translate([0,0,5])
                cylinder(d1 = diameter, d2 = bearing_efsm_10_d + 3, h = screw_length, $fn = draft?50:100);

            translate([0,0, 5 + screw_length])
                cylinder(d = bearing_efsm_10_d, h = 9/2, $fn = draft?50:100);

        }
            
        // diry pro srouby do podlozky
        translate([0, - distance_between_screws/2, - global_clearance]) //nerozumím, proč tu bylo 46/2
        {
            cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn=50);
            translate([0,0,5])
               cylinder(d = M4_nut_diameter, h = 10 * M4_nut_height, $fn = 6);
        }
        translate([0,distance_between_screws/2, - global_clearance]){ //zde také bylo 46/2
            cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn = 50);
            translate([0,0,5])
                cylinder(d = M4_nut_diameter, h = 10 * M4_nut_height, $fn = 6);
        }

        translate([0,0, - global_clearance])
                cylinder(d = M6_screw_diameter - 0.2, h = 2 * screw_length + global_clearance, $fn = draft?50:100);

                cylinder(d = M6_nut_diameter, h = 5 + screw_length + 9  - (screw_length - 7), $fn = 6);

    }
}

888_2007();