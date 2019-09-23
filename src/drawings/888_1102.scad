
draft = true;
stl = true;

limec = true;
pilon_mount = true;
motor = true;

include <../../parameters.scad>
use <../888_1004.scad>
use <../888_1005.scad>
use <../888_2009.scad>
use <../888_1026.scad>
use <../888_1029.scad>
use <../888_1030.scad>
use <../888_1031.scad>

difference(){
    union(){


// Nosnik
        translate([-engine_holder_beam_depth, 0, 0])
            if(stl){import("../../STL/888_1004.stl", convexity=4);}
            else{888_1004();}

// Limce
        if(limec){
            if(stl){import("../../STL/888_1005.stl", convexity=4);}
            else{888_1005();}

            mirror([0, 1, 0])
                if(stl){import("../../STL/888_1005.stl", convexity=4);}
                else{888_1005();}
        }
// rotorova hlava
        translate([main_pilon_position, 0, height_of_vertical_tube])
            rotate(180)
                888_1029();

        translate([main_pilon_position, 0, height_of_vertical_tube])
            rotate(180)
                888_1029_servoholder();




// stredni patka pro pripevneni pylonu
        if(pilon_mount)
            translate([-engine_holder_beam_depth+beam_patern*9.25, 0, beam_thickness_above])
                rotate(180)
                    888_1030();

// bocni patky pro pripevneni pylonu
        if(pilon_mount)
            translate([-engine_holder_beam_depth+beam_patern*5.5, 0, 0])
                rotate(180)
                    888_1031();

        if(pilon_mount)
            translate([-engine_holder_beam_depth+beam_patern*5.5, 0, 0])
                mirror([0, 1, 0])
                    rotate(180)
                        888_1031();

// motor
    if(motor)
        color([0.8, 0.8, 0.8, 0.2])
            translate([0, 0, 0])
                rotate([0,-90,0])
                    if(stl){import("../../STL/888_1026.stl", convexity=4);}
                    else{888_1026();}

translate([0, 0, -beam_thickness_below])
    rotate([0, 0,0])
        if(stl){import("../../STL/888_2009.stl", convexity=4);}
        else{888_2009();}


/* %translate([main_pilon_position, 0, 0])
    cylinder(d = 20, h = height_of_vertical_tube);

%translate([-2*main_tube_outer_diameter, -100, 0])
    rotate([0, 90, 0])
        cylinder(d = 20, h = length_of_main_tube); */


%translate([250, tail_pipe_distance/2, 0])
    rotate([0, 90, 0])
        cylinder(d = 10, h = 500);

%translate([250, -tail_pipe_distance/2, 0])
    rotate([0, 90, 0])
        cylinder(d = 10, h = 500);



}
//cube(1000);
}
