include <../parameters.scad>

draft = $preview;

module 888_1023(height = 3, draft = true){

    inner_diameter = M8_screw_diameter;
    outer_diameter = bearing_efsm_12_d + 3;
    rim_height = 1.5;
    bearng_ball_height = height;

    difference(){
        union(){
            cylinder(h = rim_height, d = outer_diameter, $fn = 50);
            translate([0,0,rim_height])
                cylinder(h = bearng_ball_height, d = bearing_efsm_12_d, $fn = 50);
        }


        cylinder(d = M6_screw_diameter, h = 10, $fn = 50);

        translate([0, 0, rim_height])
            cylinder(h = 2 * bearng_ball_height , d = inner_diameter, $fn = 50);
    }
}

888_1023(3, draft);
