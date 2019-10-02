include <../parameters.scad>



module 888_1033() {

    screw_height = 5;
    servo_height = 13+DS313MG_X+DS313MG_G;
    difference([0, 0, 0]) {
        union() {
            translate([0, 0, screw_height/2])
                cube([beam_socket_width*1.3, DS313MG_J, screw_height], center=true);

            translate([beam_socket_width*1.3/2-DS313MG_A, -DS313MG_J/2, screw_height])
                cube([DS313MG_A, DS313MG_J, servo_height-screw_height]);
        }

        translate([beam_socket_width/-2, 0, 0])
            cylinder(d=M3_screw_diameter, h=screw_height*5, $fn=20, center=true);

        translate([beam_socket_width/2, 0, 0])
            cylinder(d=M3_screw_diameter, h=screw_height*5, $fn=20, center=true);

        translate([0, 0, screw_height+(servo_height-screw_height)/2+0.05])
            cube([beam_socket_width*2, DS313MG_M, servo_height-screw_height+0.1], center=true);

        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/2+(DS313MG_B-DS313MG_E), 0])
            cylinder(d=M2_screw_diameter, h=100, center=true, $fn=20);

        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/-2-(DS313MG_B-DS313MG_E), 0])
            cylinder(d=M2_screw_diameter, h=100, center=true, $fn=20);

        
        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/2+(DS313MG_B-DS313MG_E), servo_height-(servo_height-screw_height)*1/3])
            cylinder(d=M2_nut_diameter, $fn=6, h=M2_nut_height);

        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/-2-(DS313MG_B-DS313MG_E), servo_height-(servo_height-screw_height)*1/3])
            cylinder(d=M2_nut_diameter, $fn=6, h=M2_nut_height);

        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/2+(DS313MG_B-DS313MG_E)-M2_nut_pocket/2, servo_height-(servo_height-screw_height)*1/3])
            cube([20, M2_nut_pocket, M2_nut_height]);

        translate([beam_socket_width*1.3/2-DS313MG_A/2, DS313MG_M/-2-(DS313MG_B-DS313MG_E)-M2_nut_pocket/2, servo_height-(servo_height-screw_height)*1/3])
            cube([20, M2_nut_pocket, M2_nut_height]);
    }
}

888_1033();