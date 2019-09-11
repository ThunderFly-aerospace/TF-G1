include <../parameters.scad>
use <lib/servo.scad>
use <lib/igus.scad>

draft = $preview;
if (draft) {
    $fn = 10;
}

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

// tato funkce vytvari srouby na odecteni od kostky rotorove hlavy
module pipes_top_screw(position = 100, draft = false){
// predni tyce
    translate([pilon_pipe_head_front_x, pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, (pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([0, 10, 0])
                    rotate([90, 180, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                translate([0, 10, 10])
                    rotate([90, 0, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }


    translate([pilon_pipe_head_front_x, -pilon_pipe_head_front_y, 0])
        orientate([pilon_pipe_base_front_x - pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([0, -10, 0])
                    rotate([-90, 180, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                translate([0, -10, 10])
                    rotate([-90, 0, 0]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) cylinder(d = M3_nut_diameter, h = M3_nut_height, $fn = 6);
                        translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }

    // zadni tyc
    translate([-pilon_pipe_head_rear_x, 0, 0])
        orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
            union(){
                translate([-10, 0, 0])
                    rotate([-90, 0, -90]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) translate([0, 0, -20]) cylinder(d = M3_nut_diameter, h = M3_nut_height+20, $fn = 6);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        //translate([0, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
                translate([-10, 0, 10])
                    rotate([90, 0, 90]){
                        translate([0, 0, -5]) cylinder(d = M3_screw_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        rotate(30) translate([0, 0, -20]) cylinder(d = M3_nut_diameter, h = M3_nut_height+20, $fn = 6);
                        translate([0, 0, 17]) cylinder(d = M3_nut_diameter, h = 50 + 5, $fn = draft? 20 : 50);
                        //translate([-20, -M3_nut_diameter/2, 0]) cube([20, M3_nut_diameter, M3_nut_height]);
                    }
            }
}

servo_shift = [-6, -49, -30];

module 888_1029() {
    pilon_info();
    //%pipes(pilon_pipe_diameter, 500);
    difference(){
        union(){
            intersection(){
                union(){
                    hull(){
                        intersection(){
                            pipes(16, 200);
                            translate([-50, -50, -30])
                                cube([100, 100, 85]);

                        }
                        translate([0, 0, rotor_head_height-2])
                            rotate([0, -rotor_head_rank_angle, 0])
                                translate([-rotor_head_bearing_x_shift, 0, 0])
                                    cube([70, rotor_head_width, 10], center = true);
                        //translate([-5, 50, 0]) rotate([0, 180, 180]) LW_20MG_base_cube(5);
                        //translate([-5, -50, 0]) rotate([0, 180, 0]) LW_20MG_base_cube(5);


                    translate(servo_shift)
                        rotate([0, 180, 0])
                            LW_20MG_base_cube(5);
                    mirror([0, 1, 0])
                    translate(servo_shift)
                        rotate([0, 180, 0])
                            LW_20MG_base_cube(5);
                    }
                }

                translate([-50, -50, -30])
                    cube([100, 100, 85]);
            }


        }

        translate([0, 0, 0]) kardan(draft);

        // zadni tyc
        translate([-pilon_pipe_head_rear_x, 0, 0])
            orientate([-pilon_pipe_base_rear_x+pilon_pipe_head_rear_x, 0, -height_of_vertical_tube],vref=[0,0,1], roll=0)
                translate([0, 0, -5])
                    cylinder(d = pilon_pipe_diameter, h = 100 + 5, $fn = draft? 20 : 50);


        //#translate(servo_shift)
        //    cube([servo_20kg_body_y, servo_20kg_body_z, servo_20kg_body_x]);
        translate(servo_shift)
            rotate([0, 180, 0]){
                #LW_20MG(circle = 75, circle_pos = 150);
                LW_20MG_screw();
            }
        mirror([0, 1, 0])
        translate(servo_shift)
            rotate([0, 180, 0]){
                LW_20MG(circle = 75, circle_pos = 150);
                LW_20MG_screw();
            }

        pipes(pilon_pipe_diameter, 50);
        pipes_top_screw();

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
            translate([0,rotor_head_bearing_width/2+35,0])
               cube([100,70,30], center=true);
            translate([0,-rotor_head_bearing_width/2-35,0])
               cube([100,70,30], center=true);

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

            // montazni otvor
            //translate([-30/2-50-2, -30/2, -rotor_head_bearing_a1-20-4])
            //    cube([30+50, 30, 13]);

        }

}

/* difference(){
    cube(80, center = true);
kardan();
} */

888_1029();

//pipes_top_screw();
//pipes();
if(draft)
translate([0, 0, rotor_head_height])
rotate([0, rotor_head_rank_angle, 180])
translate([rotor_head_bearing_x_shift, 0, 10])
import("../STL/333_1001.stl", convexity=3);

if(draft)
translate([0, 0, rotor_head_height])
rotate([0, rotor_head_rank_angle, 180])
translate([rotor_head_bearing_x_shift, 0, -7])
efsm_12();
