DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

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
    wall_thickness = 5;

    difference (){
        union(){
            hull(){
                translate([-(width/2),-(depth/2),0])
                    cube ([width,depth,height]);

                translate([engine_offset,0,engine_displacement])
                    rotate([0, engine_angle,0])
                        cylinder(h = height, d = engine_diameter + 2*wall_thickness,  $fn = draft ? 100 : 200);
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
    	   cylinder(h = height + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

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


include <../Parameters.scad>
