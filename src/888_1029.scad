include <../parameters.scad>



module pipes(diameter = pilon_pipe_diameter, length = 100, draft = false){
    length_front = mod([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z]) + 5;
// predni tyce
    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = length_front, $fn = draft? 20 : 50);
    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = length_front, $fn = draft? 20 : 50);

// zadni tyc

    length_rear = mod([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z]);

    translate([-pilon_pipe_head_rear_x, 0, 0])
        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
            translate([0, 0, -5]) cylinder(d = diameter, h = length_rear, $fn = draft? 20 : 50);
}

module pilon_info(){

    front = 0;

    length_rear = mod([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z]);

    echo("========= PILON INFO ================");
    echo(str("Delka zadni tyce je ", length_rear, "mm"));

}


module pipes_top_screw(position = 100, draft = false){
// predni tyce
    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([0, 10, 0])
                    rotate([90, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                translate([0, 10, 10])
                    rotate([90, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }


    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([0, -10, 0])
                    rotate([-90, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                translate([0, -10, 10])
                    rotate([-90, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }

// zadni tyc
    translate([-pilon_pipe_head_rear_x, 0, 0])
        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([-10, 0, 5])
                    rotate([0, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                /* translate([-10, 0, 10])
                    rotate([0, 90, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    } */
            }
}

module 888_1029() {
    pilon_info();
    %pipes(pilon_pipe_diameter, 500);
    difference(){
                union(){

                    //#translate([0, 0, 5])
                    //    cube([pilon_pipe_head_distance_x, pilon_pipe_head_distance_y, 10], center = true);

                    intersection(){
                        hull()
                            pipes(14, 200);
                        cube([100, 100, 30], center = true);
                    }
                }


            // kostky k odecneti od rohu dilu
                // predni tyce
                    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
                            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
                                translate([-25, -20, -50])
                                    cube([50, 20, 100]);

                    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
                            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
                                #translate([-25, 0, -50])
                                    cube([50, 20, 100]);

                // zadni tyc
                    translate([-pilon_pipe_head_rear_x, 0, 0])
                        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                            translate([0, 0, -5]) cylinder(d = diameter, h = length + 5, $fn = draft? 20 : 50);


                %translate([0, 0, -height_of_vertical_tube])
                    cylinder(h = height_of_vertical_tube, d = 20);
                pipes(pilon_pipe_diameter, 500);
                pipes_top_screw();

    }
}


module 888_1029_clamp(){




}

888_1029();

translate([50, 50, 0])
    888_1029_clamp();
