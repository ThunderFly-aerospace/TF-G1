include <../parameters.scad>
include <lib/servo.scad>
use <lib/igus.scad>

draft = $preview;
//draft = false;
if (draft) {
    $fn = 10;
}


function rotor_head_front_pipe_length() = mod([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z]) + 5 + 15;
function rotor_head_rear_pipe_length() = mod([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z]);


module pilon_info(){
    echo("========= PILON INFO ================");
    echo(str("Delka predni tyce je ", rotor_head_front_pipe_length(), "mm"));
    echo(str("Delka zadni tyce je ", rotor_head_rear_pipe_length(), "mm"));
}

module pipes(diameter = pilon_pipe_diameter, draft = $preview){
    length_front = rotor_head_front_pipe_length();
// predni tyce
    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = length_front, $fn = draft? 9 : 50);
    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = length_front, $fn = draft? 8 : 50);

// zadni tyc
    length_rear = rotor_head_rear_pipe_length();
    translate([-pilon_pipe_head_rear_x, 0, 0])
        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
            translate([0, 0, -5]) cylinder(d = diameter, h = length_rear, $fn = draft? 8 : 50);
}


module pipe_front(diameter = pilon_pipe_diameter, draft = false)
    difference(){
        translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
            orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube+pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = rotor_head_front_pipe_length(), $fn = draft? 8 : 50);

        pipes_top_screw();
    }

module pipe_rear(diameter = pilon_pipe_diameter, draft = false)
    difference(){
        translate([-pilon_pipe_head_rear_x, 0, 0])
            orientate([-pilon_pipe_base_rear_x + pilon_pipe_head_rear_x, 0, -height_of_vertical_tube+pilon_pipe_base_rear_z],vref=[0,0,1], roll=0)
                translate([0, 0, -5]) cylinder(d = diameter, h = rotor_head_rear_pipe_length(), $fn = draft? 9 : 50);

        pipes_top_screw();
    }




// tato funkce vytvari srouby na odecteni od kostky rotorove hlavy
module pipes_top_screw(position = 100, draft = false){
// predni tyce
    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=-101)
            //union() for(h = rotor_head_screw_distances + [rotor_head_front_pipe_length()-5-5, rotor_head_front_pipe_length()-5-15]){
            union() for(h = rotor_head_screw_distances){
                translate([0, 10, h])
                    rotate([90, 180, 0]){
                        translate([0, 0, -5])
                            cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17])
                            cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                                rotate(30)
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height*1.3, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0])
                            cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }


    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=-79)
            union() for(h = rotor_head_screw_distances){
                translate([0, 10, h])
                    rotate([90, 0, 0]){
                        translate([0, 0, -5])
                            cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17])
                            cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                                rotate(30)
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height*1.3, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0])
                            cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }

    // zadni tyc
    translate([-pilon_pipe_head_rear_x, 0, 0])
        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union()rotate([0, 0, 90]){
                for(h = rotor_head_screw_distances){
                    translate([-10, 0, h])
                        rotate([-90, 0, -90]){
                            translate([0, 0, -5])
                                cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                            rotate(30)
                                translate([0, 0, -20-2])
                                    cylinder(d = M3_nut_diameter, h = M3_nut_height+20, $fn = 6);
                            translate([0, 0, 17+2])
                                cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                            //translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                        }
                }

                for(h = [rotor_head_rear_pipe_length()-5-5, rotor_head_rear_pipe_length()-5-15]){
                   translate([0, -10, h])
                       rotate([-90, 0, 0]){
                           translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                           rotate(30) translate([0, 0, -20]) cylinder(d = M3_nut_diameter, h = M3_nut_height+20, $fn = 6);
                           translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                }
            }
        }
}

module pipe_drill(draft){

    difference(){
        translate([-15, -15, -7])
            cube([30, 30, 100]);
        translate([0, 0, -5+global_clearance])
            cylinder(d = pilon_pipe_diameter, h  = 150, $fn = 25);
        translate([-0.5, -20, 67])
            cube([1, 40, 50]);

        rotate([0, -90, 0]){
            for(h = rotor_head_screw_distances)
                translate([h, 0, 0])
                    cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 20);

            translate([85, 8, 0])  cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 20);
            translate([85, -8, 0])  cylinder(d = M3_screw_diameter, h = 50, center = true, $fn = 20);
            translate([85, 8, 7])  cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
            translate([85, -8, 7])  cylinder(d = M3_nut_diameter, h = 50, $fn = 6);
            translate([85, 8, -50-7])  cylinder(d = M3_nut_diameter, h = 50, $fn = 20);
            translate([85, -8, -50-7])  cylinder(d = M3_nut_diameter, h = 50, $fn = 20);
        }
    }

}


module 888_1029() {
    pilon_info();
    //%pipes(pilon_pipe_diameter, 500);
    difference(){
        union(){
            intersection(){
                union(){
                    hull(){
                        intersection(){
                            pipes(16, draft);
                            translate([-50, -50, -15])
                                cube([100, 100, 85]);

                        }
                        translate([0, 0, rotor_head_height-2])
                            rotate([0, -rotor_head_rank_angle, 0])
                                translate([-rotor_head_bearing_x_shift, 0, 0])
                                    cube([60, rotor_head_width, 10], center = true);
                        //translate([-5, 50, 0]) rotate([0, 180, 180]) LW_20MG_base_cube(5);
                        //translate([-5, -50, 0]) rotate([0, 180, 0]) LW_20MG_base_cube(5);


                    translate(rotor_head_servo_shift)
                        rotate([0, 180, 0])
                            LW_20MG_base_cube(5);
                    mirror([0, 1, 0])
                    translate(rotor_head_servo_shift)
                        rotate([0, 180, 0])
                            LW_20MG_base_cube(5);
                    }
                }

                translate([-50, -50, -15])
                    cube([100, 100, 85]);
            }


        }

        translate([0, 0, 0]) kardan(draft);

        // zadni tyc
        translate([-pilon_pipe_head_rear_x, 0, 0])
            orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                translate([0, 0, -5])
                    cylinder(d = pilon_pipe_diameter, h = 100 + 5, $fn = draft? 20 : 50);


        translate(rotor_head_servo_shift)
            rotate([0, 180, 0]){
                LW_20MG(circle = 75, circle_pos = 150, depth_offset = 10, clearance = global_clearance);
                LW_20MG_screw();
            }
        mirror([0, 1, 0])
        translate(rotor_head_servo_shift)
            rotate([0, 180, 0]){
                LW_20MG(circle = 75, circle_pos = 150, depth_offset = 10, clearance = global_clearance);
                LW_20MG_screw();
            }

        pipes(pilon_pipe_diameter);
        pipes_top_screw();

        pos = [[-LW_20MG_thickness - rotor_head_servo_shift[0], 20, 0],
               [LW_20MG_thickness - rotor_head_servo_shift[0], 20, 0],
               [LW_20MG_thickness - rotor_head_servo_shift[0], -20, 180],
               [-LW_20MG_thickness - rotor_head_servo_shift[0], -20, 180]];

        for (i=pos) {
            translate([i[0], i[1], -30+5])
            rotate([0, 0, i[2]]){
                //rotate([0, 0, 0])
                    cylinder(d=M3_nut_diameter, h= M3_nut_height, $fn = 6);
                translate([0, 0, -20])
                    cylinder(h = 20, d= M3_screw_diameter, $fn = draft? 8:20);
                translate([0, 0, M3_nut_height + layer])
                    cylinder(h = 5, d= M3_screw_diameter, $fn = draft? 8:20);
                translate([-M3_nut_diameter/2, 0, 0]) cube([M3_nut_diameter, 20, M3_nut_height]);
            }
        }

    }

    // Plna vrstva nad servem
    //translate([0, 0, rotor_head_servo_shift[2] + LM_20MG_axis_offset])
    //    cylinder(d = 40, h = layer);
}


module 888_1029_servoholder(draft){

    thickness = 15;
    zpos = rotor_head_servo_shift[2] - thickness - (LM_20MG_length - LM_20MG_axis_offset);

        difference(){
            hull(){
                translate([rotor_head_servo_shift[0]-15, -LM_20MG_length +9, zpos])
                    cube([30,  LM_20MG_length + 23, thickness]);
                intersection(){
                    pipes(16, $preview);
                    translate([-50, -90/2, zpos])
                        cube([100, 90, thickness]);
                }
            }

            translate(rotor_head_servo_shift)
                rotate([0, 180, 0]){
                    LW_20MG(circle = 75, circle_pos = 150, depth_offset = 10, screw_diameter = 0, clearance = global_clearance);
                    LW_20MG_screw();
                }
            mirror([0, 1, 0])
            translate(rotor_head_servo_shift + [0, 0, 0])
                rotate([0, 180, 0]){
                    LW_20MG(circle = 75, circle_pos = 165, depth_offset = 10, screw_diameter = 0, clearance = global_clearance);
                    LW_20MG_screw();
                }


            pipes(pilon_pipe_diameter, $preview);
            pipes_top_screw();

            translate([rotor_head_servo_shift[0]-15, -20, zpos-0.5])
                cube([40, 40, thickness+1]);


    }

}

module kardan_brit_oposite_model(lenght)
{
    difference(){
        translate([0,0,lenght/2-rotor_head_wall_height/2])
            cube([rotor_head_brit_width+1.5*rotor_head_cardan_clearance+0.01,lenght,lenght], center=true);
        translate([0,0,-rotor_head_wall_height*sqrt(2)])
            rotate([45,0,0])
                cube(2*rotor_head_wall_height, center=true);

        }
}

module kardan(draft = false){

    //priruba pro lozisko
    translate([-rotor_head_bearing_x_shift,0, rotor_head_height])
        rotate([0, -rotor_head_rank_angle, 0]){

            // základní tvar pro prirubu
            translate([0, 0, 15-rotor_head_bearing_a_center_of_rotation])
                cube([rotor_head_bearing_width+global_clearance, rotor_head_bearing_width+global_clearance, 30], center=true);

            translate([0, 0, -18-60+0.3])
                cylinder(h=90, d=rotor_head_bearing_db);

            if(draft){}else{
            for (i=[[rotor_head_bearing_m/2, rotor_head_bearing_m/2, -25, 0],
                [-rotor_head_bearing_m/2, rotor_head_bearing_m/2, -25, 0],
                [-rotor_head_bearing_m/2, -rotor_head_bearing_m/2, -25, 1],
                [rotor_head_bearing_m/2, -rotor_head_bearing_m/2, -25, 1]]) {
                translate(i+[0,0,10]){
                    //bridged screw hole
                    translate([0,0,-M5_nut_height/2 + layer])
                        cylinder(h = 30, d = M5_screw_diameter, $fn = draft ? 10 : 60);

                    translate([0,0,-1.5*M5_nut_height])
                    {
                        rotate([0,0,30])
                            cylinder(h = M5_nut_height, d = M5_nut_diameter, $fn = 6);
                        rotate([0, 0, i[3]*180])
                            translate([-M5_nut_pocket/2, 0, 0])
                                cube([M5_nut_pocket, 20, M5_nut_height]);

                        //bridged screw hole
                        translate([0, 0, -M5_nut_pocket/2])
                            cylinder(h = M5_nut_pocket, d = M5_screw_diameter, $fn = draft ? 10 : 60);

                        /*//bridged screw hole
                        translate([0, 0, -7-3])
                            cylinder(h = 7, d = M5_screw_diameter, $fn = draft ? 20 : 100);*/
                    }

                }
            //brity
            xdst=(rotor_head_bearing_width+global_clearance+1.5*rotor_head_cardan_clearance+rotor_head_brit_width)/2;
            translate([xdst,0,0])
                rotate([rotor_head_roll_stop,0,0])
                         kardan_brit_oposite_model(70);
            translate([-xdst,0,0])
                rotate([rotor_head_roll_stop ,0,0])
                        kardan_brit_oposite_model(70);
            translate([xdst,0,0])
                rotate([-rotor_head_roll_stop,0,0])
                        kardan_brit_oposite_model(70) ;
            translate([-xdst,0,0])
                rotate([-rotor_head_roll_stop,0,0])
                        kardan_brit_oposite_model(70);
            //zuzeni
            //#translate([0,rotor_head_bearing_width/2+35,0])
            //   cube([100,70,30], center=true);
            //translate([0,-rotor_head_bearing_width/2-35,0])
            //   cube([100,70,30], center=true);

            //elegance
            translate([(rotor_head_bearing_width+global_clearance)/2+1.5*rotor_head_cardan_clearance+rotor_head_brit_width,0,0])
            translate([35*sqrt(2)+1,0,0])
                rotate([0,45,0])
                    translate([-20, 0, 0])
                        cube([70,70,70],center=true);
           translate([-((rotor_head_bearing_width+global_clearance)/2+1.5*rotor_head_cardan_clearance+rotor_head_brit_width),0,0])
            translate([-(35*sqrt(2)+1),0,0])
                rotate([0,45,0])
                    translate([0, 0, 20])
                        cube([70,70,70],center=true);

            }
            }
        }

}

/* difference(){
    cube(80, center = true);
kardan();
} */

translate([0, 80, 0]) pipe_drill();

888_1029();
888_1029_servoholder();

//pipes_top_screw();
//pipes();
if(draft)
    translate([0, 0, rotor_head_height])
        rotate([0, rotor_head_rank_angle, 180])
            translate([rotor_head_bearing_x_shift, 0, 16]){
                rotate([180,0,0])
                    import("../STL/888_1020.stl", convexity=3);
                translate([0,0,-(4)])
                    import("../STL/666_1265.stl", convexity=3);
                translate([0,0,0])
                    import("../STL/666_1264.stl", convexity=3);
                translate([0, 0, -rotor_head_plate_thickness - 11.3])
                    rotate([180, 0, 0])
                        import("../STL/888_1022.stl", convexity=3);
            }

if(draft)
    translate([0, 0, rotor_head_height])
        rotate([0, rotor_head_rank_angle, 180])
            translate([rotor_head_bearing_x_shift, 0, -7])
                efsm_12();

//translate([0, 50, 0]) pipe_front(10);
//translate([0, 50, 0]) pipe_rear(10);
