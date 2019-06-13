include <../Parameters.scad>

module 888_2003 (coupling_wall_thickness, thickness_between_tubes,draft = true){

//modifikace spojky 666_1004

    bevelled_width = main_tube_outer_diameter + 2*coupling_wall_thickness;

    magnet_displacement = 40;
    wall_thickness = 5;
    screw_length = 30;
    magnet_diameter = 75;
    distance_between_screws = 42.5;


    difference(){

        union(){
            translate([-(coupling_width_666_1004/2), - depth_666_1004 + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
                  cube([coupling_width_666_1004, depth_666_1004, height_666_1004]);


            hull(){

                translate([-(coupling_width_666_1004/2), - depth_666_1004 + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
                      cube([coupling_width_666_1004, depth_666_1004/4, height_666_1004]);

                translate([0, - depth_666_1004 + main_tube_outer_diameter/2 + coupling_wall_thickness , magnet_displacement])
                    rotate([90, 0, 0])
                        cylinder(d = magnet_diameter, h = 5, $fn = draft?50:100);
            }

        }

        // middle cut
        translate ([-0.5, -depth_666_1004 , - global_clearance/2])
            cube ([1, 3*depth_666_1004 + global_clearance, 3* height_666_1004 + global_clearance]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h = height_666_1004 + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        //screw
        translate([-coupling_width_666_1004/2 - global_clearance/2,0,height_666_1004/2])
           rotate ([0,90,0])   
                cylinder(h = coupling_width_666_1004 + global_clearance, r = M3_screw_diameter/2, $fn = 15);
                
        //nut
        translate([-coupling_width_666_1004/2 - global_clearance/2,0, height_666_1004/2])
            rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);
        
        translate([coupling_width_666_1004/2 - M3_screw_head_height,0,height_666_1004/2])
           rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

        translate([distance_between_screws/2, - depth_666_1004 + main_tube_outer_diameter/2, magnet_displacement]) 
            rotate([-90, 0, 0])
            {
                cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn=50);
                translate([0,0,5])
                   cylinder(d = M4_nut_diameter, h = 50 * M4_nut_height, $fn = 6);
            }

        translate([- distance_between_screws/2,- depth_666_1004 + main_tube_outer_diameter/2 , magnet_displacement])
            rotate([-90, 0, 0])
            { 
                cylinder(d = M4_screw_diameter, h = 10 + global_clearance, $fn = 50);
                translate([0,0,5])
                    cylinder(d = M4_nut_diameter, h = 50 * M4_nut_height, $fn = 6);
            }


    }

}


888_2003 (coupling_wall_thickness, thickness_between_tubes, draft = true);

