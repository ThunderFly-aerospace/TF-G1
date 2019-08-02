include <../parameters.scad>

module 888_1029() {

                union(){

                    translate([-pilon_pipe_head_distance_x/2, -pilon_pipe_head_distance_y/2, 0])
                        cube([pilon_pipe_head_distance_x, pilon_pipe_head_distance_y, 10]);

                }

                %rotate([-90, 0, 0])
                    cylinder(h = height_of_vertical_tube, d = 20);

                #translate([-(pilon_pipe_head_distance_x)/2, pilon_pipe_head_distance_y/2, 0])
                    orientate([-(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, (pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                        translate([0, 0, -5]) cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 50);

                #translate([(pilon_pipe_head_distance_x)/2, pilon_pipe_head_distance_y/2, 0])
                        orientate([(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, (pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                            translate([0, 0, -5]) cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 50);

                #translate([-(pilon_pipe_head_distance_x)/2, -pilon_pipe_head_distance_y/2, 0])
                        orientate([-(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, -(pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                            translate([0, 0, -5]) cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 50);

                #translate([(pilon_pipe_head_distance_x)/2, -pilon_pipe_head_distance_y/2, 0])
                        orientate([(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, -(pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                            translate([0, 0, -5]) cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 50);
    }


888_1029();
