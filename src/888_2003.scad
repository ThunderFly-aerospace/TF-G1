include <../Parameters.scad>

module 888_2003(draft = true){


    width = width_666_1004;

    coupling_screw_length = coupling_screw_length_666_1004;

    coupling_width = coupling_width_666_1004;
    height=coupling_width;

    depth=main_tube_outer_diameter*2+2*coupling_wall_thickness+thickness_between_tubes;
    
    radius=main_tube_outer_diameter/2;

    bevelled_width = main_tube_outer_diameter + 2*coupling_wall_thickness;

    difference(){

        translate([-(coupling_width/2), - depth + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
              cube([coupling_width,depth,height]);

        // middle cut
        translate ([-0.5, -depth + main_tube_outer_diameter/2 + coupling_wall_thickness, - global_clearance/2])
            cube ([1,depth,height + global_clearance]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        translate([0,-main_tube_outer_diameter/2 + thickness_between_tubes,height/2])
            rotate([90,0,0])
               cylinder(h=2*height,r = main_tube_outer_diameter/2, $fn = draft ? 50 : 200);
        
        //screw
        translate([-coupling_width/2 - global_clearance/2,0,height/2])
           rotate ([0,90,0])   
                cylinder(h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = 15);

        translate ([-coupling_width/2 - global_clearance/2,- (main_tube_outer_diameter+thickness_between_tubes),height/2])
           rotate ([0,90,0])   
                cylinder (h = height, r = M3_screw_diameter/2, $fn = 15);
                
        //nut
        translate([-coupling_width/2 - global_clearance/2,0, height/2])
            rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);
        
        translate([coupling_width/2 - M3_screw_head_height,0,height/2])
           rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);


        translate([coupling_width/2 - M3_screw_head_height, -(main_tube_outer_diameter+thickness_between_tubes), height/2])
            rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);
        
        translate([-coupling_width/2 - global_clearance/2, -(main_tube_outer_diameter+thickness_between_tubes),height/2])
           rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

    }
}

888_2003(coupling_wall_thickness, thickness_between_tubes, draft);
