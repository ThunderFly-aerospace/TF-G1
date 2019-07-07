include <../parameters.scad>

fork_wheel_width = 10;
fork_thickness = 20;

pipe_diameter = tube_for_undercarriage_outer_diameter;
pipe_holder_length = 20;
pipe_holder_thickness = pipe_diameter/2+3;

pipe_holder_space =3;

M3_screw_head_diameter = M3_nut_diameter;

module 888_2015() {
    difference() {
        union () {
            translate([0,fork_wheel_width/2, 0])
                cube ([pipe_holder_length, pipe_holder_thickness, fork_thickness]);

            translate([0,fork_wheel_width/2-pipe_holder_thickness/2, 0])
                cube ([pipe_holder_length, pipe_holder_thickness/2, fork_thickness]);
        }

        rotate ([0,90,0])
            translate([-fork_thickness/2, fork_wheel_width/2+pipe_diameter/2+pipe_holder_space, -global_clearance/2])
                cylinder(h=pipe_holder_length + global_clearance, d=pipe_diameter, $fn=50);
        rotate ([90,0,0,])
            translate([pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
                cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);
        rotate ([90,0,0,])
            translate([pipe_holder_length/2,fork_thickness/2,-(fork_wheel_width/2+M3_screw_head_height-pipe_holder_thickness/2)])
                cylinder (h=30, d=M3_screw_head_diameter, $fn=50);

    }
}


888_2015();
