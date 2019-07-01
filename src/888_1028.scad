include <../parameters.scad>

fork_wheel_width = 50 ;
fork_thickness = 20;
fork_width = 10 ;
fork_hole_diameter = 10 ;
length = 120;

pipe_diameter = tube_for_undercarriage_outer_diameter;
pipe_holder_length = 20;
pipe_holder_thickness = pipe_diameter/2+3;

pipe_holder1_pos = 10;
pipe_holder2_pos = 50;
pipe_holder_space =3;

include <../parameters.scad>
M3_screw_head_diameter = M3_nut_diameter;

module 888_1028() {
    difference() {
        union () {
            translate([pipe_holder1_pos,fork_wheel_width/2+fork_width, 0])
                cube ([pipe_holder_length, pipe_holder_thickness, fork_thickness]);

            translate([pipe_holder1_pos,fork_wheel_width/2+fork_width-pipe_holder_thickness/2, 0])
                cube ([pipe_holder_length, pipe_holder_thickness/2, fork_thickness]);
        }

        rotate ([0,90,0])
            translate([-fork_thickness/2, fork_wheel_width/2+fork_width+pipe_diameter/2+pipe_holder_space, 0])
                cylinder(h=length, d=pipe_diameter, $fn=50);
        rotate ([90,0,0,])
            translate([pipe_holder1_pos+pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
                cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);
        rotate ([90,0,0,])
            translate([pipe_holder1_pos+pipe_holder_length/2,fork_thickness/2,-(fork_wheel_width/2+fork_width+M3_screw_head_height-pipe_holder_thickness/2)])
                cylinder (h=fork_width, d=M3_screw_head_diameter, $fn=50);

    }
}


888_1028();
