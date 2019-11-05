
draft = true;
stl = true;

nosnik = true;
predni_podvozek = true;
zadni_podvozek = true;
limec = true;
cover = false;
pilon_mount = true;
rotor_head = true;
motor = true;
tail = false;


print = true;
alu = true;
piston = true;
carbon = true;
other = true;

include <../../parameters.scad>
use <../666_1028.scad>
use <../888_1004.scad>
use <../888_1005.scad>
use <../888_2009.scad>
use <../888_1025.scad>
use <../888_1026.scad>
use <../888_1029.scad>
use <../888_1030.scad>
use <../888_1031.scad>
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
use <888_2103.scad>
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
difference(){
    union(){

      if(cover && print){

// Top cover
        translate([-engine_holder_beam_depth - hull_wall_thickness, 0, 0]) // musí to být posunuto asi o těch 6mm a nevím proč.
          rotate([90,0,0])
              if(stl){import("../../STL/888_1025.stl", convexity=4);}
              else{888_1025();}
      }

// Nosnik
    if(nosnik && print)
        translate([-engine_holder_beam_depth, 0, 0])
            if(stl){import("../../STL/888_1004.stl", convexity=3);}
            else{888_1004();}

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
// rotorova hlava
        if(rotor_head && print)
            translate([main_pilon_position, 0, height_of_vertical_tube])
                rotate(180)
                    if(stl){import("../../STL/888_1029.stl");}
                    else{888_1029();888_1029_servoholder();}

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
        color([0.8, 0.8, 0.8, 0.2])
            translate([0, 0, 0])
                rotate([0,-90,0])
                    if(stl){import("../../STL/888_1026.stl", convexity=4);}
                    else{888_1026();}

if(predni_podvozek && print)
    translate([0, 0, -beam_thickness_below])
        rotate([0, 0,0])
            if(stl){import("../../STL/888_2009.stl", convexity=4);}
            else{888_2009();}


if(predni_podvozek && print)
    rotate([30, 0, 180])
        888_2022(true);

if(predni_podvozek && print)
    rotate([45, 0, 0])
        888_2024();

if(predni_podvozek && print)
    translate([chasis_fork_thickness+KBRM03_B/2+fork_wheel_width/2, 57, 22])
        rotate([0, 0, 0])
            888_2025();


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
    washer_thickness = main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness;

    ch = chassis_height;
  
    echo(str("Delka predniho ramene je ", mod([chassis_pipe_baselength_f, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));
    echo(str("Delka  zadniho ramene je ", mod([chassis_pipe_baselength_r, chassis_pipe_wheelbase, chassis_height])-2017_pipe_bottom));


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
                if(false){import("../../STL/888_2017_pipes.stl", convexity=4);}
                else{888_2017_pipe_front(); 888_2017_pipe_rear();}

    if(carbon)color("Teal")
        mirror([0, 1, 0])
            translate([0, -chassis_wheelbase/2, -chassis_height])
                rotate([-90, -90, 0])
                    if(false){import("../../STL/888_2017_pipes.stl", convexity=4);}
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

// mechova kolecka
if(other){
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








}


}
//cube(1000);
}



if(tail)
    translate([0, 0, -beam_min_wall-beam_main_pipe_thickness*2]){

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

}

} // end of module assembly

assembly();