
//VIDLICE PRO ZADNI KOLO

include <../parameters.scad>

cylinder_2_thickness = 1.5;

fork_wheel_width = wheel_inner_thickness + 2*cylinder_2_thickness + 2* wheel_disc_upper_thickness + 0.5;
screw_length = 55;
fork_thickness = 20;
fork_width = 10 ;
fork_hole_diameter = 10 ;
fork_lenght = 55;

pipe_diameter = tube_for_undercarriage_outer_diameter;
pipe_holder_length = 20;
pipe_holder_thickness = pipe_diameter/2+3;

pipe_holder_distance = 20;
pipe_holder1_pos = -5;
pipe_holder2_pos = pipe_holder1_pos + pipe_holder_distance;
pipe_holder_space =3;


module 888_1027() {

rotate([0, 90, 0]) translate([-fork_lenght+6, 0, -fork_thickness/2])
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
                translate([fork_lenght-6, fork_thickness/2, 0])
                  cylinder (h=2*fork_width+fork_wheel_width+20, d=M4_screw_diameter, center=true, $fn=50);

                translate([fork_lenght-6,fork_thickness/2, -30 - (screw_length-5)/2])
                  cylinder (h=30, d=M4_nut_diameter, $fn=6);

                translate([fork_lenght-6, fork_thickness/2,  (screw_length-5)/2])
                  cylinder (h=30, d=M4_nut_diameter, $fn=50);
            }
        }

        //drzaky trubky - srouby M3
        /* difference() {
            translate([pipe_holder1_pos,fork_wheel_width/2, 0])
              cube ([pipe_holder_length, pipe_holder_thickness + fork_width, fork_thickness]);
            rotate ([0,90,0])
              translate([-fork_thickness/2, fork_wheel_width/2+fork_width+pipe_diameter/2+pipe_holder_space, 0])
                cylinder(h=fork_lenght*2, d=pipe_diameter, $fn=50, center = true);
        }

        difference() {
            translate([pipe_holder2_pos,fork_wheel_width/2+fork_width, 0])
              cube ([pipe_holder_length, pipe_holder_thickness, fork_thickness]);
            rotate ([0,90,0])
              translate([-fork_thickness/2, fork_wheel_width/2+fork_width+pipe_diameter/2+pipe_holder_space, 0])
                cylinder(h=fork_lenght*2, d=pipe_diameter, $fn=50, center = true);
        } */
      }
      rotate ([90,0,0,]) {
          translate([pipe_holder2_pos+pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
            cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);

          translate([pipe_holder2_pos+pipe_holder_length/2, fork_thickness/2, -(0.5*fork_wheel_width+M3_nut_height*2)])
            cylinder (h=fork_width, d=M3_nut_diameter, $fn=6);

          translate([pipe_holder1_pos+pipe_holder_length/2, fork_thickness/2, -fork_wheel_width])
            cylinder (h=fork_wheel_width, d=M3_screw_diameter, $fn=50);

          translate([pipe_holder1_pos+pipe_holder_length/2, fork_thickness/2, -(0.5*fork_wheel_width+M3_nut_height*2)])
            cylinder (h=fork_width, d=M3_nut_diameter, $fn=6);
      }
    }
}

module 888_1027_drill(){
    difference(){
        cube([25, 25, pipe_holder_distance+pipe_holder_length], center = true);

        cylinder(d = tube_for_undercarriage_outer_diameter, h = pipe_holder_distance+20+global_clearance, $fn = 80, center = true);

        translate([0, 0, pipe_holder_distance/2])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 30, center = true, $fn = 80);

        translate([0, 0, -pipe_holder_distance/2])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter, h = 30, center = true, $fn = 80);
    }
}

888_1027();
//888_1027_drill();
