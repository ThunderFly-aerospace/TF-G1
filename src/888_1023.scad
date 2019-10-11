include <../parameters.scad>

module 888_3016(draft = true){

    inner_diameter = M8_screw_diameter;
    outer_diameter = bearing_efsm_12_d + 3;
    rim_height = 1.2;
    bearng_ball_height = 3;
    difference(){
        union(){
            cylinder(h = rim_height, d = outer_diameter, $fn = 50);
            translate([0,0,rim_height])
                cylinder(h = bearng_ball_height, d = bearing_efsm_12_d, $fn = 50);
        }
        cylinder(h = 2 * bearng_ball_height , d = inner_diameter, $fn = 50);
    }
}
888_3016($preview);
