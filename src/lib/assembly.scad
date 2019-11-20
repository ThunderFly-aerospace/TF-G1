
draft = $preview;
stl = true;

rotor = false;
rotor_position = true;
nosnik = false;
predni_podvozek = false;
zadni_podvozek = false;
mechova_kolecka = false;
limec = false;
cover = false;
rotor_head_pulley_motor = false;
rotor_head_pulley_rotor = false;
rotor_head_plate = false;
rotor_head_prerotator = false;
pilon_mount = false;
rotor_head = false;
motor = false;
tail = false;
battery = false;
propeller = false;


print = false;
alu = false;
piston = false;
carbon = false;
other = false;

collisions = false;

include <../../parameters.scad>
use <../666_1028.scad>
use <../666_1201.scad>
use <../888_1004.scad>
use <../888_1005.scad>
use <../888_2009.scad>
use <../888_1020.scad>
use <../888_1025.scad>
use <../888_1026.scad>
use <../888_1029.scad>
use <../888_1030.scad>
use <../888_1031.scad>
use <../888_1036.scad>
use <../888_1036_single.scad>
use <../888_2013.scad>
use <../888_2016.scad>
use <../888_2017.scad>
use <../888_2021.scad>
use <../888_2027.scad>
use <../888_2022.scad>
use <../888_2024.scad>
use <../888_2025.scad>
use <../888_2011.scad>
use <../888_2012.scad>
use <../888_2021.scad>
//use <../888_2103.scad>
use <../drawings/888_2105.scad>
use <../main_motor.scad>
use <../lib/motor.scad>
use <../lib/igus.scad>
use <../lib/vector.scad>
use <../lib/piston.scad>



module piston(shift = 32){
    sphere(d = 15);

    translate([0, 0, 215])
        sphere(d = 15);

    translate([0, 0, 295])
        sphere(d = 15);

    cylinder(h = 265 + shift, d = 5);
    translate([0, 0, shift])
        cylinder(h = 150, d = 20);

}


module assembly(){

      if(cover && print){

// Top cover
        %if(stl){import("../../STL/888_1025.stl", convexity=4);}
         else{position_888_1025() 888_1025();}
      }

// Nosnik
    if(nosnik && print)
            if(stl){import("../../STL/888_1004.stl", convexity=3);}
            else{position_888_1004() 888_1004();}

// podelne tyce nosniku
    if(carbon && nosnik)
        for(i=[0, 1])
            mirror([0, i, 0])
                if(stl){import("../../STL/888_1004_pipe_a.stl");}
                else{position_888_1004_pipe(i) 888_1004_pipe();}

// Limce
        if(limec && print){
            if(stl){import("../../STL/888_1005.stl", convexity=4);}
            else{
                888_1005();
                888_1005_rear();
                mirror([0, 1, 0])
                   888_1005();
            }
        }

// pricne tyce nosnikem
        if(nosnik && carbon)
            for(i = [2])
                position_888_1004_pipe_traverse(i){
                    if(stl){import("../../STL/888_1005_pipe.stl", convexity=4);}
                    else{
                        888_1005_pipe();
                    }
                }

// pricne tyce nonikem.
        if(nosnik && carbon)
            for(i = [5,6])
                position_888_1031_pipe_tranverse(i){
                    if(stl){import("../../STL/888_1031_pipe.stl", convexity=4);}
                    else{
                        888_1031_pipe();
                    }
                }




// drzaky baterek
    if(battery && print){
        translate([beam_patern*2, tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1036.stl");

        translate([beam_patern*2, -tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1036.stl");

        translate([beam_patern*4, tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1036_single.stl");

        translate([beam_patern*4, -tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1036_single.stl");

    }


    if(tail && print){
        translate([beam_patern*9, tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1034.stl");

        translate([beam_patern*9, -tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1034.stl");

        translate([beam_patern*10, tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1034.stl");

        translate([beam_patern*10, -tail_pipe_distance/2, -beam_main_pipe_thickness-beam_vertical_space_between_pipes])
        rotate([-90, 0, 0]) import("../../STL/888_1034.stl");

    }



// rotorova hlava


        if(rotor_head && print)
            translate([main_pilon_position, 0, height_of_vertical_tube])
                rotate(180)
                        if(stl){import("../../STL/888_1029.stl");}
                        else{888_1029();888_1029_servoholder();}

// stredni dil kardanu

    translate([main_pilon_position + rotor_head_bearing_x_shift, 0, height_of_vertical_tube+rotor_head_height])rotate([0,rotor_head_rank_angle,0]){
    //union(){

            if(rotor_head && print)
                        rotate([0,0,0])
                            translate([0,0,4])
                                rotate([180,0,0])
                                    if(stl){
                                        import("../../STL/888_1022.stl", convexity=3);
                                    }else{
                                        888_1022();
                                    }




            /* if(rotor_head_pulley_rotor && print)
                        rotate([0,0,0])
                            translate([0,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+4+2])
                                //rotate([180,0,0])
                                    if(stl){
                                        import("../../STL/rotor_pulley.stl", convexity=3);
                                    }else{
                                        rotor_pulley();
                                    } */

            /* if(rotor_head_pulley_rotor && other)
                        rotate([0,0,0])
                            translate([0,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+4+2+20])
                                    import("../../STL/external/666_1207.stl"); */


            if(rotor_head_pulley_motor && print)
                        rotate([0,0,0])
                            translate([rotor_head_prerotator_distance,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+4+2])
                                //rotate([180,0,0])
                                    if(stl){
                                        import("../../STL/prerotator_pulley_motor.stl", convexity=3);
                                    }else{
                                        prerotator_pulley_motor();
                                    }

            if(rotor_head_prerotator && print)
                        rotate([0,0,0])
                            translate([rotor_head_prerotator_distance,0,rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)-8])
                                rotate([180,0,0])
                                    if(stl){
                                        import("../../STL/prerotator_imitation.stl", convexity=3);
                                    }else{
                                        prerotator_imitation();
                                    }



        }

// Tistena deska rotorove hlavy
if(rotor_head_plate && print)
    position_888_1020(enable = rotor_position)
        rotate([180,0,0]) translate([0, 0, -14])
            if(stl){
                import("../../STL/888_1020.stl", convexity=3);
            }else{
                888_1020();
            }

// Rotorove listy

rotor_flapping = rotor_flap0;
rotor_position = 90;

rotor_placement = true;
  translate([0, 500, 500]*rotor_placement);


//position_888_1020(enable = rotor_position){color("blue") sphere(r=5);}

position_888_1020(enable = rotor_position)
translate([0, 0, 45]){
  if(rotor){
  // rotorove listy
    if(other)
      position_666_1201(flapping = rotor_flapping, rotate = rotor_position)
        666_1201(draft = draft, holes = true);
    if(other)
      rotate(180) position_666_1201(flapping = rotor_flapping, rotate = rotor_position)
        666_1201(draft = draft, holes = true);

  // Rotorovy domek
  if(alu)
    translate([0,0,-12.5])
      rotate([0,0,-rotor_delta+90 + rotor_position])
        import("../../STL/external/666_1207.stl");

  // Remenice rotoru
  if(print)
    rotate([0,0,-rotor_delta+90 + rotor_position])
      translate([0, 0, -17 - 12.5])
        if(stl){
            import("../../STL/rotor_pulley.stl", convexity=3);
        }else{
            rotor_pulley();
        }
  }
}

rotor_springing = 100;

if(rotor && collisions){
  %position_888_1020(enable = rotor_position)
    translate([0, 0, 45]){
      rotate_extrude($fn=200)hull(){
        translate([30,-5,0]) square(10);
        translate([rotor_blade_length+30,-rotor_springing/2,0]) square([1, rotor_springing]);
      }
    }
}

        // if(rotor_head && print)
        //     translate([main_pilon_position, 0, height_of_vertical_tube])
        //         rotate(180)
        //             if(stl){import("../../STL/888_1029_servoholder.stl");}
        //             else{888_1029_servoholder();}


// stredni patka pro pripevneni pylonu
        if(pilon_mount && print)
            translate([-engine_holder_beam_depth+beam_patern*10.25, 0, beam_thickness_above])
                rotate(180)
                    888_1030();

// bocni patky pro pripevneni pylonu
        if(pilon_mount && print)
            translate([-engine_holder_beam_depth+beam_patern*6.5, 0, 0])
                rotate(180)
                    888_1031();

        if(pilon_mount && print)
            translate([-engine_holder_beam_depth+beam_patern*6.5, 0, 0])
                mirror([0, 1, 0])
                    rotate(180)
                        888_1031();

        if(pilon_mount && carbon)
        translate([-engine_holder_beam_depth+beam_patern*8.2, 0, height_of_vertical_tube])
            rotate(180)
                pipe_front(10);

        if(pilon_mount && carbon)
        mirror([0, 1, 0])
        translate([-engine_holder_beam_depth+beam_patern*8.2, 0, height_of_vertical_tube])
            rotate(180)
                pipe_front(10);

        if(pilon_mount && carbon)
        translate([-engine_holder_beam_depth+beam_patern*8.2, 0, height_of_vertical_tube])
            rotate(180)
                pipe_rear(10);

// motor
    if(motor && print)
        //color([0.8, 0.8, 0.8, 0.2])
            translate([0, 0, 0])
                rotate([0,-90,0])
                    if(stl){import("../../STL/888_1026.stl", convexity=4);}
                    else{888_1026();}

    if(motor && other){
        position_main_motor()
            motor_main();
    }

    if(propeller && other){
        position_main_motor()
            translate([1.5, 0, -15]) rotate([-90, 0, 0]) scale(9)
            import("../../STL/APC_15x4C.stl");
    }

    if(propeller && collisions){
        position_main_motor()
            translate([1.5, 0, -15]) rotate([0, 0, 0])
                cylinder(h = 10, d = 380);
    }


if(predni_podvozek && print)
    translate([0, 0, -beam_thickness_below])
        rotate([0, 0,0])
            if(stl){import("../../STL/888_2009.stl", convexity=4);}
            else{888_2009();}


column_height = 65;
column_offset = 50;

// Predni podvozek
if(predni_podvozek && print)
  translate([-column_offset, 0, -beam_thickness_below - column_height])
      rotate([0, 0, -90])
          888_2105();

/*
 %translate([main_pilon_position, 0, 0])
    cylinder(d = 20, h = height_of_vertical_tube);

%translate([-2*main_tube_outer_diameter, -100, 0])
    rotate([0, 90, 0])
        cylinder(d = 20, h = length_of_main_tube);


%translate([250, tail_pipe_distance/2, 0])
    rotate([0, 90, 0])
        cylinder(d = 10, h = 500);

%translate([250, -tail_pipe_distance/2, 0])
    rotate([0, 90, 0])
        cylinder(d = 10, h = 500);
*/

if(zadni_podvozek)
    translate([beam_patern*9.5, 0, -beam_thickness_below]){
    // Dily na pripevneni podvozkovych trubek do KSTM lozisek pod nosnikem

    if(print)
        translate([-chassis_baselength_f, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
            orientate([-chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
                rotate([0, 90, 90])
                    if(stl){import("../../STL/888_2013.stl");}
                    else{888_2013();}

    if(print)
        translate([-chassis_baselength_f, -chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
            orientate([-chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])
                rotate([0, 90, 90])
                    if(stl){import("../../STL/888_2013.stl");}
                    else{888_2013();}

    if(print)
        translate([chassis_baselength_r, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
            orientate([chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
                rotate([0, 90, 90])
                    if(stl){import("../../STL/888_2013.stl");}
                    else{888_2013();}

    if(print)
        translate([chassis_baselength_r, -chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
             orientate([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])
                 rotate([0, 90, 90])
                    if(stl){import("../../STL/888_2013.stl");}
                     else{888_2013();}


    // KSTM kulova loziska pod nosnikem virniku
    if(other)
    color("navy"){
        for(i = [0, 1]) mirror([0, i, 0]){
            translate([chassis_baselength_r, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
                orientate([chassis_pipe_baselength_r, -chassis_pipe_wheelbase, chassis_height])
                    rotate([180, 0, 90]) kstm_08();
            translate([-chassis_baselength_f, chassis_top_bearing_position_y, -chassis_top_bearing_position_z])
                orientate([-chassis_pipe_baselength_f, -chassis_pipe_wheelbase, chassis_height])
                    rotate([180, 0, 90]) kstm_08();
        }
    }

    // Trojuhelnik pod nosnikem k podvozku
    if(print)
    color([0.2, 0.2, 0.6, 0.7]){
        translate([-chassis_baselength_f, 0, 0])
            rotate([0, 0, 180])
                888_2027(front = true);
        translate([chassis_baselength_r, 0, 0])
                888_2027(front = false);
    }


// Drzak vidlice zadnich kolecek
    if(print)
        translate([0, chassis_wheelbase/2, -chassis_height])
            rotate([90, -90, 0])
                if(stl){import("../../STL/888_2017_right.stl", convexity=4);}
                else{888_2017(left = 0);}

    if(print)
        translate([0, -chassis_wheelbase/2, -chassis_height])
            rotate([-90, -90, 0])
                if(stl){import("../../STL/888_2017_left.stl", convexity=4);}
                else{888_2017(left = 1);}

// Ramena zadniho podvozku
    if(carbon)color("Teal")
        translate([0, -chassis_wheelbase/2, -chassis_height])
            rotate([-90, -90, 0])
                if(stl){import("../../STL/888_2017_pipes.stl", convexity=4);}
                else{888_2017_pipe_front(); 888_2017_pipe_rear();}

    if(carbon)color("Teal")
        mirror([0, 1, 0])
            translate([0, -chassis_wheelbase/2, -chassis_height])
                rotate([-90, -90, 0])
                    if(stl){import("../../STL/888_2017_pipes.stl", convexity=4);}
                    else{888_2017_pipe_front(); 888_2017_pipe_rear();}


// vidlice zadniho kolecka
    if(print)
        translate ([0, -chassis_wheelbase/2 , -chassis_height])
            rotate([-3, 0, 0])
                translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                    translate([0, 0, -25])
                        if(stl){import("../../STL/888_2021.stl");}
                        else{888_2021();}

    if(print)
        mirror([0, 1, 0])
        translate ([0, -chassis_wheelbase/2 , -chassis_height])
            rotate([-3, 0, 0])
                translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                    translate([0, 0, -25])
                        if(stl){import("../../STL/888_2021.stl");}
                        else{888_2021();}

if(print){
    translate ([0, -chassis_wheelbase/2 , -chassis_height])
        rotate([-3, 0, 0])
            translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                translate([0, 0, -25]){
                    translate([0, wheel_inner_thickness/2+4.6, 0]) rotate([90, 0, 0]) 888_2011(true);
                    translate([0, -wheel_inner_thickness/2-4.6, 0]) rotate([-90, 0, 0]) 888_2011(false);
                    translate([0, wheel_inner_thickness/2+6.8, 0]) rotate([90, 0, 0]) 888_2012();
                    translate([0, -wheel_inner_thickness/2-6.8, 0]) rotate([-90, 0, 0]) 888_2012();
                }

    mirror([0, 1, 0])
        translate ([0, -chassis_wheelbase/2 , -chassis_height])
            rotate([-3, 0, 0])
                translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                    translate([0, 0, -25]){
                        translate([0, wheel_inner_thickness/2+4.6, 0]) rotate([90, 0, 0]) 888_2011(true);
                        translate([0, -wheel_inner_thickness/2-4.6, 0]) rotate([-90, 0, 0]) 888_2011(false);
                        translate([0, wheel_inner_thickness/2+6.8, 0]) rotate([90, 0, 0]) 888_2012();
                        translate([0, -wheel_inner_thickness/2-6.8, 0]) rotate([-90, 0, 0]) 888_2012();
                    }
    }


// zadni kolecka



    //
    //
    //      Dily pro souvisejici s pricnou tyci
    //
    //

    translate([0, 0, 0]){
        //color("green"){

            // trmeny k pricne trubce

            if(print)
            translate([0, chassis_suspension_basewidth/2, beam_main_pipe_thickness/2 + beam_min_wall])
                rotate([-90, 180, 0])
                    if(stl){import("../../STL/888_2016.stl");}
                    else{888_2016();}

            if(print)
            translate([0, -chassis_suspension_basewidth/2, beam_main_pipe_thickness/2 + beam_min_wall])
                rotate([90, 0, 0])
                    if(stl){import("../../STL/888_2016.stl");}
                    else{888_2016();}

            if(other)
            translate([0, -chassis_suspension_basewidth/2 - 5, beam_min_wall + beam_main_pipe_thickness/2 + 9])
                rotate([20, 0, 0])
                    translate([0,  -kstm_ball_height(8), 0])
                        rotate([0, 180+45, 90])
                        chassis_piston_assembly();


            if(other)
            translate([0, chassis_suspension_basewidth/2 + 5, beam_min_wall + beam_main_pipe_thickness/2 + 9])
                rotate([20, 0, 180])
                    translate([0,  -kstm_ball_height(8), 0])
                        rotate([0, 180+45, 90])
                        chassis_piston_assembly();

        //}

        color("Teal"){
            if(carbon)
            translate([beam_patern/2,0, beam_main_pipe_thickness/2 + beam_min_wall])
                if(stl){import("../../STL/888_2016_pipe.stl");}
                else{888_2016_pipe();}


            if(carbon)
            translate([-beam_patern/2,0, beam_main_pipe_thickness/2 + beam_min_wall])
                if(stl){import("../../STL/888_2016_pipe.stl");}
                else{888_2016_pipe();}



            if(other)
            translate([0, -chassis_suspension_basewidth/2 - 5, beam_main_pipe_thickness/2 + beam_min_wall+2])
                rotate([-20, 0, 0])
                    translate([0,  -kstm_ball_height(8), 0])
                        rotate([0, -90, 90])
                            kstm_08();

            if(other)
            translate([0, chassis_suspension_basewidth/2 + 5, beam_main_pipe_thickness/2 + beam_min_wall+2])
                rotate([20, 0, 0])
                    translate([0,  kstm_ball_height(8), 0])
                    rotate([0, 90, 90])
                        kstm_08();

        }
    }
//cube(1000);
}

// mechova kolecka
if(mechova_kolecka && other)
    translate([beam_patern*9.5, 0, -beam_thickness_below]){

        translate ([0, -chassis_wheelbase/2 , -chassis_height])
            rotate([-3, 0, 0])
                translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                    translate([0, 0, -25]){
                        wheel_tiere();
                    }

        mirror([0, 1, 0])
            translate ([0, -chassis_wheelbase/2 , -chassis_height])
                rotate([-3, 0, 0])
                    translate([0, -chassis_fork_width-fork_wheel_width/2, 0])
                        translate([0, 0, -25]){
                            wheel_tiere();
                        }
    }



if(tail)
    translate([0, 0, -beam_vertical_space_between_pipes*2-beam_main_pipe_thickness*2]){

    if(print)
        translate([tail_y_pos, -tail_pipe_distance/2, 0])
            rotate([-tail_airfoils_angle/2, 0, 0])
                translate([0, 0, -tail_height/2])
                if(stl){import("../../STL/666_1028.stl", convexity=4);}
                else{666_1028(pipe = false);}

    if(print)
        mirror([0, 1, 0])
        translate([tail_y_pos, -tail_pipe_distance/2, 0])
            rotate([-tail_airfoils_angle/2, 0, 0])
                translate([0, 0, -tail_height/2])
                if(stl){import("../../STL/666_1028.stl", convexity=4);}
                else{666_1028(pipe = false);}

    if(carbon)
        translate([tail_y_pos, -tail_pipe_distance/2, 0])
            rotate([-tail_airfoils_angle/2, 0, 0])
                translate([0, 0, -tail_height/2])
                    if(stl){import("../../STL/666_1028_pipes.stl", convexity=4);}
                    else{666_1028_pipe();}

    if(carbon)
        translate([tail_y_pos, tail_pipe_distance/2, 0])
            rotate([-tail_airfoils_angle/2, 0, 0])
                translate([0, 0, -tail_height/2])
                    if(stl){import("../../STL/666_1028_pipes.stl", convexity=4);}
                    else{666_1028_pipe();}
} // end of tail

} // end of module assembly

//assembly();
