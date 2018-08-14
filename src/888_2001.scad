//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 888_2001(height = 10, height_of_cap_cylinder = 2){

    width = main_tube_outer_diameter*2; 
    depth = main_tube_outer_diameter + 4*thickness_between_tubes;
    
    difference (){

        translate([-(width/2),-(depth/2),0])
        color([0,0.9,0])
            cube ([width,depth,height]);
        
        //tube
        translate([0,0,- global_clearance])
           cylinder(h = 2*main_tube_outer_diameter + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

        /*//screw
        translate([0,depth/2 + global_clearance/2,7.5])
           rotate([90,0,0])
               cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);


        translate([0,depth/2 + global_clearance/2,42.5])
           rotate([90,0,0])
               cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
        */
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
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
        
        mirror([1,0,0])
        translate([depth/2,0,width/2])
            rotate([90,0,0])
                union(){
                        cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
    }



}


888_2001(draft);


include <../Parameters.scad>
