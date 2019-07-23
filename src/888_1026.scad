DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;


//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1026(draft)
{

    width = main_tube_outer_diameter+2*thickness_between_tubes;
    depth = 53.5;   // šířka plechu držáku motoru
    height = main_tube_outer_diameter*2;
    engine_displacement = maximum_printable_size -  1.2 * height;
    magnet_displacement = 50;
    magnet_vertical_position = -20;
    wall_thickness = 5;
    screw_length = 30;
    magnet_diameter = 75;
    distance_between_screws = 42.5;

    //vypouštěcí zařízení
    vlecne_zarizeni = true;
    supports = true;
    supports_thickness = 0.61;
    prumer = 2;
    vyska = 5;
    servo_lever = 22.5; //délka páky serva od středu otáčení ke konci
    servo_lever_space = 3; //zvetšení místa pro páku serva
    servo_holder = 1.3; //tlouštka úchytu na servu
    dolni_konec_y = prumer/-2; //pomocná proměnná
    dolni_konec_x = (main_tube_outer_diameter*3/4)+vyska/-2; //pomocná proměnná

    distance_shift = (maximum_printable_size-1.2*height+height)-(magnet_displacement+magnet_diameter/2);
    distance_height = (engine_offset-wall_thickness-engine_diameter/2)-magnet_vertical_position;
    hole_distance = (magnet_displacement+magnet_diameter/2)+distance_shift*(main_tube_outer_diameter*3/4-magnet_vertical_position)/distance_height-13;



    if(supports) {
        difference() {
            union() {
                intersection() {
                    translate([dolni_konec_x+servo_lever-DS313MG_A/2, dolni_konec_y+DS313MG_X+DS313MG_G, (DS313MG_J-DS313MG_M)/2])
                        cube([DS313MG_A, DS313MG_H-10, DS313MG_M]);
                    translate([engine_offset,0,engine_displacement])
                        rotate([0, engine_angle,0])
                            translate([0,0,- 4 * height])
                                cylinder(h = height * 5, d = engine_diameter+supports_thickness, $fn = draft ? 100 : 200);
                }

                translate([dolni_konec_x+servo_lever+DS313MG_A/2-supports_thickness, dolni_konec_y+DS313MG_X+DS313MG_G, (DS313MG_J-DS313MG_M)/2])
                    cube([supports_thickness, DS313MG_H-10, DS313MG_M]);
            }

            translate([engine_offset,0,engine_displacement])
                rotate([0, engine_angle,0])
                    translate([0,0,- 4 * height])
                        cylinder(h = height * 5, d = engine_diameter, $fn = draft ? 100 : 200);
        }

    }

    
    difference (){
        union(){
            hull(){
                translate([-(width/2),-(depth/2),0])
                    cube([width,depth,height]);

                translate([engine_offset,0,engine_displacement])
                    rotate([0, engine_angle,0])
                        cylinder(h = height, d = engine_diameter + 2*wall_thickness,  $fn = draft ? 100 : 200);

                translate([magnet_vertical_position, 0, magnet_displacement])
                    rotate([0, 90, 0])
                        cylinder(d = magnet_diameter, h = 5, $fn = draft?50:100);

            }
            translate([engine_offset,0, engine_displacement])
                rotate([0, engine_angle,0])
                    translate([0,0, height])
                        cylinder(h = wall_thickness, d1 = engine_diameter + 2*wall_thickness, d2 = engine_diameter + wall_thickness,  $fn = draft ? 100 : 200);

            if(vlecne_zarizeni) {
                translate([width/2, dolni_konec_y, 0])
                    cube([dolni_konec_x-width/2+servo_lever+DS313MG_A/2, DS313MG_H+DS313MG_G+DS313MG_X, DS313MG_J]);
            }
        }


        translate([magnet_vertical_position, - distance_between_screws/2, magnet_displacement])
            rotate([0, 90, 0])
            {
                cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn=50);
                translate([0,0,5])
                   cylinder(d = M4_nut_diameter, h = 50 * M4_nut_height, $fn = 6);
            }
        translate([magnet_vertical_position,distance_between_screws/2, magnet_displacement])
            rotate([0, 90, 0])
            {
                cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn = 50);
                translate([0,0,5])
                    cylinder(d = M4_nut_diameter, h = 50 * M4_nut_height, $fn = 6);
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


        //octvor pro vývody motoru
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
    	translate([0,0,- global_clearance/2])
    	   cylinder(h = height*100, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    	//screw
    	translate([0,depth/2 + global_clearance/2,7.5])
    	   rotate([90,0,0])
    	       cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([0,-20,7.5])
           rotate([90,0,0])
               cylinder(h = depth + global_clearance, d = M4_nut_diameter, $fn = 6);

        translate([0,20,7.5])
           rotate([-90,0,0])
               cylinder(h = depth + global_clearance, d = M4_nut_diameter, $fn = 6);

    	translate([0,depth/2 + global_clearance/2,42.5])
    	   rotate([90,0,0])
    	       cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

        translate([0,-20,42.5])
           rotate([90,0,0])
               cylinder(h = depth, d = M4_nut_diameter, $fn = 6);

        translate([0,20,42.5])
           rotate([-90,0,0])
               cylinder(h = depth, d = M4_nut_diameter, $fn = 6);


        //vypouštěcí zařízneí
        if(vlecne_zarizeni) {
            translate([dolni_konec_x+servo_lever-DS313MG_A/2, dolni_konec_y, (DS313MG_J-DS313MG_M)/2])
                cube([100, 100, DS313MG_M]);

            translate([dolni_konec_x+servo_lever-DS313MG_A/2, dolni_konec_y+DS313MG_X+DS313MG_G+DS313MG_H-10, 0])
                cube([DS313MG_A, 10, DS313MG_M]);

            translate([dolni_konec_x, dolni_konec_y-servo_lever_space, 0])
                cube([100, DS313MG_X+DS313MG_G-DS313MG_K+servo_lever_space, DS313MG_J-(DS313MG_J-DS313MG_M)/2]);

            translate([dolni_konec_x+servo_lever-DS313MG_A/2, dolni_konec_y+DS313MG_X+DS313MG_G-servo_holder-5, 0])
                cube([100, servo_holder+5, DS313MG_J]);

            translate([dolni_konec_x+servo_lever-DS313MG_A/2, dolni_konec_y, 0])
                cube([100, DS313MG_X+DS313MG_G, DS313MG_M]);

            translate([dolni_konec_x+servo_lever, dolni_konec_y+DS313MG_X+DS313MG_G+3, (DS313MG_J-DS313MG_M)/4])
                rotate([-90, 0, 0])
                    cylinder(d=M2_5_nut_diameter, h=M2_5_nut_height, $fn=6);
            
            translate([dolni_konec_x+servo_lever+50, dolni_konec_y+DS313MG_X+DS313MG_G+3+M2_5_nut_height/2, (DS313MG_J-DS313MG_M)/4])
                cube([100, M2_5_nut_height, M2_5_nut_pocket], center=true);

            translate([dolni_konec_x+servo_lever, 0, (DS313MG_J-DS313MG_M)/4])
                rotate([-90, 0, 0])
                    cylinder(d=M2_5_screw_diameter, h=100, $fn=20);

            translate([dolni_konec_x+servo_lever, dolni_konec_y+DS313MG_X+DS313MG_G-3, DS313MG_J-(DS313MG_J-DS313MG_M)/4])
                rotate([90, 0, 0])
                    cylinder(d=M2_5_nut_diameter, h=100, $fn=20);

            translate([dolni_konec_x+servo_lever, dolni_konec_y+DS313MG_X+DS313MG_G+3, DS313MG_J-(DS313MG_J-DS313MG_M)/4])
                rotate([-90, 0, 0])
                    cylinder(d=M2_5_nut_diameter, h=M2_5_nut_height, $fn=6);
            
            translate([dolni_konec_x+servo_lever+50, dolni_konec_y+DS313MG_X+DS313MG_G+3+M2_5_nut_height/2, DS313MG_J-(DS313MG_J-DS313MG_M)/4])
                cube([100, M2_5_nut_height, M2_5_nut_pocket], center=true);

            
            translate([dolni_konec_x+servo_lever, -50, DS313MG_J-(DS313MG_J-DS313MG_M)/4])
                rotate([-90, 0, 0])
                    cylinder(d=M2_5_screw_diameter, h=100, $fn=20);

            translate([main_tube_outer_diameter*3/4, 0, 0])
                hull() {
                    translate([vyska/2-prumer/2, 0, 0])
                        cylinder(d=prumer, h=1000, $fn=15);
                    translate([vyska/-2-prumer/-2, 0, 0])
                        cylinder(d=prumer, h=1000, $fn=15);
                }

            translate([main_tube_outer_diameter*3/4, 0, 0])
                hull() {
                    translate([vyska/2-prumer/2, 0, 5+DS313MG_A+50])
                        cylinder(d=prumer, h=1000, $fn=15);
                    translate([vyska/-2-prumer/-2, 0, 5+DS313MG_A+100])
                        cylinder(d=prumer*10, h=1000, $fn=35);
                }


            translate([main_tube_outer_diameter*3/4, 0, hole_distance])
                rotate([90, 0, 0])
                    cylinder(d=M3_screw_diameter, h=100, $fn=20, center=true);

            translate([main_tube_outer_diameter*3/4, -15, hole_distance])
                rotate([90, 0, 0])
                    cylinder(d=M3_nut_diameter, h=20, $fn=6);

            translate([main_tube_outer_diameter*3/4, 15, hole_distance])
                rotate([-90, 0, 0])
                    cylinder(d=M3_nut_diameter, h=20, $fn=20);
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
