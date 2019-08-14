include <../parameters.scad>


module beam_side_holder(l = 20){
    difference(){
        translate([l/2, 0, 0])
            cube([l, beam_width, beam_thickness], center = true);

        for (i=[0,2])
            translate([-global_clearance/2, 0, 0])
                rotate([90*i, 0, 0])
                    translate([0, -beam_width/2, 0]){
                        rotate([90-beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);

                        rotate([180+beam_edge_angle, 0, 0])
                            translate([0, 0, 0])
                                cube([l+global_clearance, 80, 50]);
                    }

        translate([-global_clearance/2, -beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_thickness, h = l + global_clearance, $fn = 50);

        translate([-global_clearance/2, beam_main_pipe_distance/2, 0])
            rotate([0, 90, 0])
                cylinder(d = beam_main_pipe_thickness, h = l + global_clearance, $fn = 50);
    }
}

module 888_1006(){
    beam_side_holder():
}

888_1006();
