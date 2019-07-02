include <../parameters.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.
//$fs = draft ? 5 : 0.5;
//$fa = 10;




888_2013_width = 50;

module 888_2013(draft) {
    material_plus = 10;

    difference(){

        translate([-888_2013_width/2, 0, -main_tube_outer_diameter/2])
            cube([888_2013_width, main_tube_outer_diameter/2 + material_plus, main_tube_outer_diameter + material_plus*2]);

        rotate([0, 90, 0])
            cylinder(d = main_tube_outer_diameter, h = 888_2013_width);

        rotate([45, 0, 0])
            translate([-888_2013_width/2, main_tube_outer_diameter/2+material_plus, -25])
                cube([888_2013_width, 50, 50]);
        rotate([45+90, 0, 0])
            translate([-888_2013_width/2, main_tube_outer_diameter/2+material_plus, -25])
                cube([888_2013_width, 50, 50]);
    }
}



//666_1017_drillhelper_doc();

888_2013(draft);

//translate([70,0,0])
//666_1017_drillhelper();
