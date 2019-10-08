DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>
use <888_1004.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;


//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1026(draft)
{

    width = beam_thickness;
    depth = beam_width-22;   // šířka plechu držáku motoru
    height = engine_holder_beam_depth;
    engine_displacement = maximum_printable_size -  1.2 * height;
    //engine_displacement = 60;
    magnet_displacement = 50;
    magnet_vertical_position = -25;
    wall_thickness = 5;
    screw_length = 30;
    magnet_diameter = 75;
    distance_between_screws = 42.5;

    //vypouštěcí zařízení
    vlecne_zarizeni = true;
    servo = true;
    prumer = 2;
    vyska = 8;
    fix_screw_distance = 3; //vzdálenost kotvícího šroubku od serva
    servo_overhang = 5;
    release_wire_height = beam_thickness_above + 13;
    servo_lever = 5; //délka páky serva od středu otáčení ke konci
    distance_shift = (maximum_printable_size-1.2*height+height)-(magnet_displacement+magnet_diameter/2);
    distance_height = (engine_offset-wall_thickness-engine_diameter/2)-magnet_vertical_position;
    hole_distance = (magnet_displacement+magnet_diameter/2)+distance_shift*(main_tube_outer_diameter-magnet_vertical_position)/distance_height-27;

    difference (){
        union(){
            hull(){
                #translate([global_clearance - beam_thickness_below,-(depth/2),5])
                    cube([beam_thickness+0,depth,height]);

                translate([engine_offset,0,engine_displacement])
                    rotate([0, engine_angle,0])
                        cylinder(h = height, d = engine_diameter + 2*wall_thickness,  $fn = draft ? 100 : 200);

                translate([beam_thickness_above, 0, engine_holder_beam_depth - beam_patern*1.25])
                    rotate([0, 90, 0])
                        cylinder(d = 12, h = 5, $fn = 50);

                //translate([magnet_vertical_position, 0, magnet_displacement])
                //    rotate([0, 90, 0])
                //        cylinder(d = magnet_diameter, h = 5, $fn = draft?50:100);

            }
            translate([engine_offset,0, engine_displacement])
                rotate([0, engine_angle,0])
                    translate([0,0, height])
                        cylinder(h = wall_thickness, d1 = engine_diameter + 2*wall_thickness, d2 = engine_diameter + wall_thickness,  $fn = draft ? 100 : 200);
        }

        translate([engine_offset,0,engine_displacement])
            rotate([0, engine_angle,0])
                translate([0,0,- 4 * height])
                    cylinder(h = height * 5, d = engine_diameter, $fn = draft ? 100 : 200);

        // otvor pro osu motoru
        translate([engine_offset,0,engine_displacement])
            rotate([0, engine_angle,0])
                cylinder(h = height * 3, d = engine_shatf_hole_diameter, $fn = draft ? 100 : 200);

        // otvory pro šrouby motoru
        translate([engine_offset,0,engine_displacement])
            rotate([0, engine_angle,0])
                translate([0,0,height])
                    for (i=[0:3]) rotate([0, 0, 90*i]){
                        translate([0, engine_screws_radius, 0])
                            cylinder(h = 2*height, d = M4_screw_diameter, $fn = 50);

                        translate([0, engine_screws_radius, wall_thickness])
                           cylinder(h = height - 10, d = M4_nut_diameter, $fn = 6);
                    }

        // otvory pro chlazení
        translate([engine_offset,0,engine_displacement])
            rotate([0, engine_angle,0])
                translate([0,0,height - global_clearance])
                    rotate([0, 0,45])
                        for (i=[0:3]) rotate([0, 0, 90*i]){
                            translate([0, engine_holes_radius, 0])
                                cylinder(h = 15, d1 = 10, d2 = 20, $fn = 50);

                        }


        //otvor pro vývody motoru
        translate([engine_offset,0,engine_displacement])
            rotate([0, engine_angle, 0])
                translate([0, 0, height - 8])
                    rotate([90, 0, 45])
                        hull(){
                            cylinder(h = depth + global_clearance, d = 15 , $fn = draft ? 10 : 50);
                            translate([0,-25,0])
                                cylinder(h = depth + global_clearance, d = 15 , $fn = draft ? 10 : 50);
                        }


    	//tube
    	//for (i=[-1,1])
        //    translate([0, i*beam_main_pipe_distance/2,- global_clearance/2])
    	//       cylinder(h = height*100, d = beam_main_pipe_thickness, $fn = draft ? 100 : 200);

        translate([0, 0, engine_holder_beam_depth])
            rotate([0, 90, 0])
                beam_plug(60);

        translate([-50, -beam_width/2-1, engine_holder_beam_depth-100+global_clearance])
            cube([50, beam_width+2, 100]);

    	//screw

        // diry pro pripevneni drzaku motoru k nosniku
        for(i = [-1, 1]){
            translate([0, i*((beam_main_pipe_distance)/2), 0]){
                translate([0, 0, engine_holder_beam_depth - beam_patern/4])
                    rotate([0, 90, 0])
                        cylinder(d = M4_screw_diameter, h = 100, center = true, $fn = 50);
                translate([beam_thickness/2 + 5, 0, engine_holder_beam_depth - beam_patern/4])
                    rotate([0, 90, 0])
                        cylinder(d = M4_nut_diameter, h = 100, $fn = 6);
            }

            translate([-8, i*(beam_main_pipe_distance-15)/2, -5]){
                cylinder(d = M4_screw_diameter, h = 100, $fn = 50);
                translate([0, 0, 10+engine_holder_beam_depth])
                    cylinder(d = M4_nut_diameter, h = 100, $fn = 50);
            }
        }

        // Otvor pro pripeveni kolecka
        translate([0, 0, 0]){
            translate([0, 0, engine_holder_beam_depth - beam_patern*1.25])
                rotate([0, 90, 0])
                    cylinder(d = M3_screw_diameter, h = 100, center = true, $fn = 20);
            translate([beam_thickness_above + 5, 0, engine_holder_beam_depth - beam_patern*1.25])
                rotate([0, 90, 0])
                    cylinder(d = M3_nut_diameter, h = 100, $fn = 50);
        }

        //vypouštěcí zařízneí
        if(vlecne_zarizeni) {
            translate([release_wire_height, 0, 0])
                hull() {
                    translate([vyska/2-prumer/2, 0, 5+DS313MG_A])
                        cylinder(d=prumer, h=1000, $fn=15, center = true);
                    translate([vyska/-2-prumer/-2, 0, 5+DS313MG_A])
                        cylinder(d=prumer, h=1000, $fn=15, center = true);
                }

            translate([release_wire_height, 0, 0])
                hull() {
                    translate([vyska/2-prumer/2, 0, 5+DS313MG_A])
                        cylinder(d=prumer*5, h=55, $fn=35, center = true);
                    translate([vyska/-2-prumer/-2, 0, 5+DS313MG_A])
                        cylinder(d=prumer*5, h=55, $fn=35, center = true);
                }

            translate([release_wire_height, 0, 0])
                hull() {
                    translate([vyska/2-prumer/2, 0, 5+DS313MG_A+50])
                        cylinder(d=prumer, h=1000, $fn=55);
                    translate([vyska/-2-prumer/-2, 0, 5+DS313MG_A+100])
                        cylinder(d=prumer*10, h=1000, $fn=55);
                }

            translate([release_wire_height, 0, hole_distance])
                rotate([90, 0, 0])
                    cylinder(d=M3_screw_diameter, h=100, $fn=20, center=true);

            translate([release_wire_height, -15, hole_distance])
                rotate([90, 0, 0])
                    cylinder(d=M3_nut_diameter, h=20, $fn=6);

            translate([release_wire_height, 15, hole_distance])
                rotate([-90, 0, 0])
                    cylinder(d=M3_nut_diameter, h=20, $fn=20);


BSM_116HV_width = 23.3+0.5;
BSM_116HV_height = 20+0.5;
BSM_116HV_depth = 10;
BSM_116HV_flange_height = 15.5+0.4;
BSM_116HV_flange_width = 32;
BSM_116HV_holes_diameter = M2_screw_diameter;
BSM_116HV_holes_distance_width = 27;
BSM_116HV_holes_distanec_depth = 0;
BSM_116HV_axis_offset = 5;
BSM_116HV_axis_height = 5;

            if(servo){

                translate([45,-BSM_116HV_height-5,28-1])
                rotate([0, -140, 0])
                 union(){
                    cube([BSM_116HV_depth, BSM_116HV_height+5, BSM_116HV_width]);
                    cube([BSM_116HV_depth, 5, BSM_116HV_width+50]);
                    translate([0, BSM_116HV_flange_height-3.5, (BSM_116HV_width - BSM_116HV_flange_width)/2])
                        cube([BSM_116HV_depth/2+1, 7, BSM_116HV_flange_width]);

                    translate([0, BSM_116HV_flange_height, BSM_116HV_width/2 + BSM_116HV_holes_distance_width/2])
                        rotate([0, 90, 0])
                            cylinder(d=1.8, h=20, center=true, $fn = 50);

                    translate([0, BSM_116HV_flange_height, BSM_116HV_width/2 - BSM_116HV_holes_distance_width/2])
                        rotate([0, 90, 0])
                            cylinder(d=1.8, h=20, center=true, $fn = 50);

                    translate([BSM_116HV_depth/2, BSM_116HV_height+BSM_116HV_axis_height, BSM_116HV_width/2+BSM_116HV_axis_offset])
                        rotate([90, 0, 0])
                            cylinder(r = 15, h = 10, center = true, $fn = 80);

                }

                //translate([main_tube_outer_diameter-vyska/2+servo_lever-DS313MG_A/2, -2.5, -servo_overhang])
                //    cube([DS313MG_A, DS313MG_G, DS313MG_J]);

                //translate([main_tube_outer_diameter-vyska/2, -2.5, -servo_overhang])
                //    cube([servo_lever, 5, DS313MG_J]);

                //translate([width/2, -2.49, 0])
                //    cube([(main_tube_outer_diameter-vyska/2+servo_lever-DS313MG_A/2+DS313MG_A)-width/2, DS313MG_H+DS313MG_G, 50]);

            }
        }
    }
}


module 888_1026_drillhelper(height = 60, height_of_cap_cylinder = 2){



    width = main_tube_outer_diameter*2;
    depth = main_tube_outer_diameter + 4*thickness_between_tubes;



    difference (){

        translate([-(width/2),-(depth/2),0])
        color([0,0.5,0])
            cube ([width,depth,height]);

        //tube
        translate([0,0,- global_clearance])
           cylinder(h = 2*main_tube_outer_diameter + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

        //screw
        translate([0,depth/2 + global_clearance/2,7.5])
           rotate([90,0,0])
               cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);


        translate([0,depth/2 + global_clearance/2,42.5])
           rotate([90,0,0])
               cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

        //prořezy pro zajištění proti otočení
        translate([main_tube_outer_diameter/2 -global_clearance,- (3*global_clearance)/2,- main_tube_outer_diameter])
                cube([main_tube_outer_diameter, 3*global_clearance, 4*main_tube_outer_diameter]);

        mirror([1,0,0])
        translate([main_tube_outer_diameter/2 - global_clearance,- (3*global_clearance)/2,- main_tube_outer_diameter])
                cube([main_tube_outer_diameter, 3*global_clearance, 4*main_tube_outer_diameter]);

        //šrouby pro zajištění
        translate([depth/2,0,width/2])
            rotate([90,0,0])
                union(){
                        cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*M4_nut_height])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                }

        mirror([1,0,0])
        translate([depth/2,0,width/2])
            rotate([90,0,0])
                union(){
                        cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*M4_nut_height])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = M4_nut_height*2 + global_clearance, r = M4_nut_diameter/2, $fn = 6);
                }
    }
}

module 888_1026_drillhelper_doc(){


    color("Black")
        union(){
            //screw
            translate ([0,-150*0.4,7.5])
                rotate ([0,90,90])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

            translate ([0,-150*0.4,42.5])
                rotate ([0,90,90])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);
        }
}



888_1026(draft);



888_1026(draft);

//666_1026_drillhelper(height = 60, height_of_cap_cylinder = 2);
