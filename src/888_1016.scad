<<<<<<< HEAD
draft = true; 


module 888_1016(draft){

    plate_thickness = 5;
    plate_width = 50 + 0.1;
    plate_corners = 10 + 0.1;
    plate_length = 20; // vzdalenost, jak daleko bude drzak od okraje
    plate_axis_from_end = 20;

    hall_holder_wall_thickness = 5;
    hall_distance = 35; // distance between axis and magnet

    hall_length = 12;
    hall_length_offset = (11/2-2); // positiv is further from axis
    hall_width = 26;
    hall_thickness = 3-1;
    holder_length = plate_length + hall_distance - plate_axis_from_end + hall_length/2 + hall_holder_wall_thickness + hall_length_offset; 

    difference(){
        
        hull(){
            translate([-(plate_width + 2* hall_holder_wall_thickness)/2, 0, 0])
                cube([plate_width + 2* hall_holder_wall_thickness, plate_length, plate_thickness]);

            translate([-(hall_width)/2, 0, 0])
                cube([hall_width, holder_length, plate_thickness]);
        }

        translate([-hall_width/2, plate_length + hall_distance - plate_axis_from_end - hall_length/2 + hall_length_offset, plate_thickness - hall_thickness])
            cube([hall_width, hall_length, hall_thickness + global_clearance]);


        translate([-5/2, plate_length + hall_distance - plate_axis_from_end + hall_length/2 + hall_length_offset - 0.1, 0])
            cube([5, 2.5, plate_thickness + global_clearance]);

        translate([0,0,-global_clearance/2])
            // tento rozdil napodobuje tvar hlinikove desky
            difference(){
                translate([-plate_width/2, 0, 0])
                    cube([plate_width, plate_length, plate_thickness + global_clearance]);

                translate([-plate_width/2, plate_length - plate_corners, -global_clearance/2])
                    rotate([0, 0, -45])
                        translate([-plate_corners*2, 0, 0])
                            cube([plate_corners*2, plate_corners*2, plate_thickness + global_clearance]);
                
                translate([plate_width/2 - plate_corners, plate_length, -global_clearance/2])
                    rotate([0, 0, -45])
                        translate([0, 0, 0])
                            cube([plate_corners*2, plate_corners*2, plate_thickness + global_clearance]);
            }
    }

}


888_1016(draft);

include <../Parameters.scad>
=======
include <../Parameters.scad>

module 888_3016(draft = true){

    inner_diameter = 6.5;
    outer_diameter = bearing_efsm_12_d + 3;
    rim_height = 1;
    bearng_ball_height = 10.1/2;
    difference(){
        union(){
            cylinder(h = rim_height, d = outer_diameter, $fn = 50);
            translate([0,0,rim_height])
                cylinder(h = bearng_ball_height, d = bearing_efsm_12_d, $fn = 50);
        }
        cylinder(h = 2 * bearng_ball_height , d = inner_diameter, $fn = 50);
    }
}
888_3016();
>>>>>>> 3b6115ff668a6692c017d62245469f5d1b787b3c
