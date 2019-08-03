include <../parameters.scad>



module pipes(diameter = pilon_pipe_diameter, lenght = 100){

                    translate([-(pilon_pipe_head_distance_x)/2, pilon_pipe_head_distance_y/2, 0])
                        orientate([-(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, (pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                            translate([0, 0, -5]) cylinder(d = diameter, h = length + 5, $fn = draft? 20 : 50);
                    translate([(pilon_pipe_head_distance_x)/2, pilon_pipe_head_distance_y/2, 0])
                            orientate([(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, (pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                                translate([0, 0, -5]) cylinder(d = diameter, h = length + 5, $fn = draft? 20 : 50);
                    translate([-(pilon_pipe_head_distance_x)/2, -pilon_pipe_head_distance_y/2, 0])
                            orientate([-(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, -(pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                                translate([0, 0, -5]) cylinder(d = diameter, h = length + 5, $fn = draft? 20 : 50);
                    translate([(pilon_pipe_head_distance_x)/2, -pilon_pipe_head_distance_y/2, 0])
                            orientate([(pilon_pipe_base_distance_x-pilon_pipe_head_distance_x)/2, -(pilon_pipe_base_distance_y-pilon_pipe_head_distance_y)/2, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                                translate([0, 0, -5]) cylinder(d = diameter, h = length + 5, $fn = draft? 20 : 50);
}


module 888_1029() {
    difference(){
                union(){

                    translate([-pilon_pipe_head_distance_x/2, -pilon_pipe_head_distance_y/2, 0])
                        cube([pilon_pipe_head_distance_x, pilon_pipe_head_distance_y, 10]);

                    intersection(){
                        hull()
                            pipes(1, 200);
                        cube([100, 100, 30], center = true);
                    }
                }

                %translate([0, 0, -height_of_vertical_tube])
                    cylinder(h = height_of_vertical_tube, d = 20);
                pipes(pilon_pipe_diameter, 500);

    }
}


888_1029();
