// patka pro pridelani predni tyce pylonu k nosniku
include <../parameters.scad>
use <888_1004.scad>
//use <lib/drill.scad>

draft = true;

module 888_1031(draft){
    difference(){
        hull(){
            //translate([-beam_patern/2, 0, -beam_thickness/4])
            //    cube([beam_patern, beam_width/2+pilon_pipe_diameter+15, beam_thickness/2]);

        // tvar pro srouby do podlozky
            for (i=[-beam_patern/2,0])
                translate([i, 0, 0])
                    rotate([-90, 0, 0])
                        cylinder(d = M4_nut_diameter+8, h = beam_width/2+pilon_pipe_diameter+15, $fn = draft? 10 : 60);

        // Tvar pro pripevneni pro tyce
            for (i=[-beam_patern/2, beam_patern/2])
                translate([i - beam_patern/4, 0, -beam_main_pipe_thickness - beam_vertical_space_between_pipes])
                    rotate([-90, 0, 0])
                        cylinder(d = beam_main_pipe_thickness+4.75, h = beam_width/2+pilon_pipe_diameter+15, $fn = draft? 10 : 60);
        }

        translate([-40, 0, 0])
            beam_plug(80);

        for (i=[-beam_patern/2, beam_patern/2]) {
            translate([i, 0, 0])
                rotate([-90, 0, 0]){
                    cylinder(d = M4_screw_diameter, h = 100, $fn =  draft? 10 : 60);
                    translate([0, 0, beam_width/2 + 10])
                        cylinder(d = M4_nut_diameter, h = 100, $fn =  draft? 10 : 60);

                }
        }

        // Dira pro pripevneni pro tyce pylonu
        for (i=[[-beam_patern/2, 0], [beam_patern/2, 180]])
            translate([i[0] - beam_patern/4, 0, -beam_main_pipe_thickness - beam_vertical_space_between_pipes]){
                rotate([-90, 0, 0])
                    cylinder(d = beam_main_pipe_thickness, h = beam_width/2 + 5 + 15 + global_clearance, $fn = draft? 10 : 60);
                rotate([0, 90, 0])
                    translate([0, beam_width/2+5, 0])
                        rotate([i[1], 0, 0]){
                            cylinder(d = M3_screw_diameter, h = 20, center = true);
                            translate([0, 0, -10 - beam_main_pipe_thickness/2 -1]) cylinder(d = M3_nut_diameter, h = 10);
                            hull(){
                                translate([0, 0, beam_main_pipe_thickness/2 +1]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                                translate([20, 0, beam_main_pipe_thickness/2 +1]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                            }

                        }
            }

        translate([-beam_patern/4, pilon_pipe_base_front_y, pilon_pipe_base_front_z])
            orientate([-pilon_pipe_base_front_x + pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), height_of_vertical_tube-pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                union(){
                    translate([0, 0, -15-global_clearance])
                        cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 10 : 60);

                    for(i = [[0, 0], [-10, 180]]) translate([0, 0, i[0]])
                    rotate([90, i[1], 0]){
                        translate([0, 0,-beam_main_pipe_thickness/2-2]) cylinder(d = M3_screw_diameter, h = 50, $fn =  draft? 20 : 60);
                        translate([0, 0,-beam_main_pipe_thickness/2-2-50-layer]) cylinder(d = M3_nut_diameter, h = 50, $fn =  draft? 20 : 60);
                        translate([0, 0, pilon_pipe_diameter/2+2]) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-M3_nut_diameter/2, 0, pilon_pipe_diameter/2+2]) cube([M3_nut_diameter, 50, M3_nut_height]);
                    }
            }
    }
}

module 888_1031_pipe(draft){
    difference(){
        rotate([0, 90, 0])
            cylinder(d = beam_main_pipe_thickness, h = beam_width + 2*(5+15), center = true);
        rotate([0, 90, 0])
            cylinder(d = beam_main_pipe_thickness-2, h = beam_width + 2*(5+15)+1, center = true);
    }
}

module 888_1031_drill_a(draft){

    cube_side = 25;
    height = 40;
    clamp_length = 10;
    clamp_thickness = 1;
    pipe_diameter = beam_main_pipe_thickness;
    drill_diameter = M3_screw_diameter;
    holes = [15];
    end = true;
    text_a = "drill-A 888_1031";
    text_b = "pylon pricna trub";


    difference(){
        translate([-cube_side/2, -cube_side/2, end? -5: 0]) cube([cube_side, cube_side, height + (end?5:0)]);
        cylinder(d = pipe_diameter, h=height+1, $fn = draft? 10 : 60);

        for(i = holes){
            translate([0, 0, i])
                rotate([0, 90, 0])
                    cylinder(d = drill_diameter, h = cube_side+2, center = true, $fn = draft? 10 : 60);
        }

        translate([-clamp_thickness/2, -cube_side/2, height - clamp_length])
            cube([clamp_thickness, cube_side, clamp_length]);

        for(i = [1, -1]){
            translate([-cube_side/2, i*(pipe_diameter/2+2), height - clamp_length/2])
                rotate([0, 90, 0])
                    cylinder(d = M3_screw_diameter, h = cube_side, $fn = draft? 10 : 60);

            translate([-cube_side/2, i*(pipe_diameter/2+2), height - clamp_length/2])
                rotate([0, 90, 0])
                    cylinder(d = M3_nut_diameter, h = cube_side/2 - pipe_diameter/3, $fn = 6);

            translate([pipe_diameter/3, i*(pipe_diameter/2+2), height - clamp_length/2])
                rotate([0, 90, 0])
                    cylinder(d = M3_nut_diameter, h = cube_side/2 - pipe_diameter/3, $fn = 6);
        }

        translate([-cube_side/4, -cube_side/2, height/2]) rotate([90, -90, 0]) linear_extrude(0.3, center = true) text(text_a, valign = "center", halign = "center", size = 4);
        translate([cube_side/4, -cube_side/2, height/2]) rotate([90, -90, 0]) linear_extrude(0.3, center = true) text(text_b, valign = "center", halign = "center", size = 4);
    }
}

module 888_1031_info(){
    echo("==========INFO 888_1031 ==========");
    echo("Dil pro pripevneni prednich tyci pylonu");

    echo(" ");
    echo("Delka pricnych tyci:", beam_width + 2*(5+15));
}


888_1031_info();
888_1031();

//translate([20, 0, 0]) 888_1031_drill_a($preview);
