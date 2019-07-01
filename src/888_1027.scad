
//VIDLICE PRO ZADNI KOLO

include <../parameters.scad>

fork_wheel_width = 39 ;
fork_thickness = 20;
fork_width = 10 ;
fork_hole_diameter = 10 ;
fork_lenght = 85;

pipe_diameter = tube_for_undercarriage_outer_diameter;
pipe_holder_length = 20;
pipe_holder_thickness = pipe_diameter/2+3;

pipe_holder1_pos = 10;
pipe_holder2_pos = 50;
pipe_holder_space =3;


module 888_1027() {
    difference() {
      union () {
        difference() {
            union () {
                cylinder ( h=fork_thickness, d=2*fork_width+fork_wheel_width, $fn=100);

                translate ([0,fork_wheel_width/2,0])
                    cube ([fork_lenght, fork_width, fork_thickness]);

                translate ([0,-(fork_wheel_width/2+fork_width),0])
                    cube ([fork_lenght, fork_width, fork_thickness]);
            }

            translate([0, 0, -10])
                cylinder ( h=fork_thickness+20, d=fork_wheel_width, $fn=50);

            translate([0,-(fork_wheel_width/2),-10])
                cube ([2*fork_width+fork_wheel_width+20,fork_wheel_width,fork_thickness+20 ]);

            //osa M4
            rotate ([90,0,0,]) {
                translate([fork_lenght-0.1*fork_lenght, fork_thickness/2, 0])
                  cylinder (h=2*fork_width+fork_wheel_width+20, d=M4_screw_diameter, center=true, $fn=50);

                translate([fork_lenght-0.1*fork_lenght, fork_thickness/2, -(0.5*fork_wheel_width+M4_nut_height)])
                  cylinder (h=fork_width, d=M4_nut_diameter, $fn=6);

                translate([fork_lenght-0.1*fork_lenght,fork_thickness/2,-((0.5*fork_wheel_width)+(2*fork_width)-M4_screw_head_height)])
                  cylinder (h=fork_width, d=M4_nut_diameter, $fn=50);

                translate([fork_lenght-0.1*fork_lenght, fork_thickness/2, 0.5*fork_wheel_width+fork_width-M4_nut_height])
                  cylinder (h=fork_width, d=M4_nut_diameter, $fn=6);
            }
        }

        //drzaky trubky - srouby M3
        difference() {
            translate([pipe_holder1_pos,fork_wheel_width/2+fork_width, 0])
              cube ([pipe_holder_length, pipe_holder_thickness, fork_thickness]);
            rotate ([0,90,0])
              translate([-fork_thickness/2, fork_wheel_width/2+fork_width+pipe_diameter/2+pipe_holder_space, 0])
                cylinder(h=fork_lenght, d=pipe_diameter, $fn=50);
        }

        difference() {
            translate([pipe_holder2_pos,fork_wheel_width/2+fork_width, 0])
              cube ([pipe_holder_length, pipe_holder_thickness, fork_thickness]);
            rotate ([0,90,0])
              translate([-fork_thickness/2, fork_wheel_width/2+fork_width+pipe_diameter/2+pipe_holder_space, 0])
                  cylinder(h=fork_lenght, d=pipe_diameter, $fn=50);
        }
      };
      rotate ([90,0,0,]) {
          translate([pipe_holder2_pos+pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
            cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);

          translate([pipe_holder2_pos+pipe_holder_length/2, fork_thickness/2, -(0.5*fork_wheel_width+M3_nut_height)])
            cylinder (h=fork_width, d=M3_nut_diameter, $fn=6);
        };
      rotate ([90,0,0,]) {
          translate([pipe_holder1_pos+pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
            cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);

          translate([pipe_holder1_pos+pipe_holder_length/2, fork_thickness/2, -(0.5*fork_wheel_width+M3_nut_height)])
            cylinder (h=fork_width, d=M3_nut_diameter, $fn=6);
      }
    }
}

888_1027() ;
