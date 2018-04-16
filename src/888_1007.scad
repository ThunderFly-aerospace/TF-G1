DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;

/*
// Nastavení zobrazení
//$vpr = [338, 0, 357];
$vpt = [67, 182, 195];
$vpd = 1800;
*/
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_1007(){

    translate([0,main_tube_outer_diameter*2,0])
        rotate([0,-90,90])
            666_1026_drillhelper();
         
    translate([0,-2 + length_of_main_tube,0])
        rotate([270,0,0])
            666_1028_drillhelper();

        rotate([-90,0,0])
            cylinder (h = length_of_main_tube, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    translate([0,main_pilon_position,70 - coupling_wall_thickness + main_tube_outer_diameter/2 - main_tube_outer_diameter])
        rotate([180,0,0])
            666_1017_drillhelper();

    translate([0, main_pilon_position,main_tube_outer_diameter/2 + thickness_between_tubes])
            cylinder (h = height_of_vertical_tube, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    translate([0,main_pilon_position,+ main_tube_outer_diameter/2 + thickness_between_tubes + height_of_vertical_tube - 2*main_tube_outer_diameter])
        rotate([0,0,90])
            666_1026_drillhelper();

//final module
}


module 888_1007_doc(){

    color("Black")
        union(){

            rotate($vpr)
            leader_line(angle=150, radius=main_tube_outer_diameter*3, angle_length=150, horz_line_length=20,
                        direction=DIM_LEFT, line_width=DIM_LINE_WIDTH,
                        text=str("666_1026"),
                        do_circle=false);


            translate([0, main_pilon_position, height_of_vertical_tube])
            rotate($vpr)
            leader_line(angle=150, radius=main_tube_outer_diameter*3, angle_length=150, horz_line_length=20,
                        direction=DIM_LEFT, line_width=DIM_LINE_WIDTH,
                        text=str("666_1026"),
                        do_circle=false);

            translate([0, main_pilon_position, main_tube_outer_diameter])
            rotate($vpr)
            leader_line(angle=150, radius=main_tube_outer_diameter*3, angle_length=150, horz_line_length=20,
                        direction=DIM_LEFT, line_width=DIM_LINE_WIDTH,
                        text=str("666_1017"),
                        do_circle=false);

            translate([0, length_of_main_tube, main_tube_outer_diameter])
            rotate($vpr)
            leader_line(angle=150, radius=main_tube_outer_diameter*2, angle_length=150, horz_line_length=20,
                        direction=DIM_LEFT, line_width=DIM_LINE_WIDTH,
                        text=str("666_1028"),
                        do_circle=false);

            translate([0,-2 + length_of_main_tube,0])
                rotate([270,180,0])
                    666_1028_drillhelper_doc();

            translate([0,0.75,0])
                rotate([0,90,90])
                    666_1026_drillhelper_doc();

            translate([0,main_pilon_position,height_of_vertical_tube + main_tube_outer_diameter/2 + 1.75])
                rotate([0,180,90])
                    666_1026_drillhelper_doc();
                    
            translate([main_tube_outer_diameter, main_pilon_position ,main_tube_outer_diameter*2 + 1])
                rotate([90,90,90])
                    666_1017_drillhelper_doc();

        }


}



888_1007();

888_1007_doc();


use <./lib/naca4.scad>
include <../Parameters.scad>

use<666_1026.scad>
use<666_1028.scad>
use<666_1017.scad>