include <../parameters.scad>
draft = true;

module 666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true){


bevelled_width = main_tube_outer_diameter + 2*coupling_wall_thickness;

    difference(){

        translate([-(coupling_width_666_1004/2), - depth_666_1004 + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
              cube([coupling_width_666_1004,depth_666_1004,height_666_1004]);

        // middle cut
        translate ([-0.5, 0, - global_clearance/2])
            cube ([1,depth_666_1004,height_666_1004 + global_clearance]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h=height_666_1004 + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        translate([-coupling_width_666_1004/2 - global_clearance/2, -(main_tube_outer_diameter+thickness_between_tubes),height_666_1004/2])
            rotate([0,90,0])
               cylinder(h=height_666_1004 + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 50 : 200);
        
        //bevelled edge
        translate([bevelled_width/2+coupling_wall_thickness/sqrt(2),coupling_wall_thickness/sqrt(2),- global_clearance/2])
            rotate([0,0,45])
                cube([bevelled_width, bevelled_width,height_666_1004 + global_clearance]);
        
        translate([-(bevelled_width/2) - coupling_wall_thickness/sqrt(2),coupling_wall_thickness/sqrt(2),- global_clearance/2])
            rotate([0,0,45])
                cube([bevelled_width, bevelled_width,height_666_1004 + global_clearance]); 
        
        translate([- height_666_1004/2 - global_clearance/2,- main_tube_outer_diameter/2 - thickness_between_tubes - main_tube_outer_diameter - coupling_wall_thickness - (sqrt(2)*bevelled_width)/2 - (main_tube_outer_diameter/sqrt(2))/3 - coupling_wall_thickness/sqrt(2),-coupling_wall_thickness/sqrt(2)])
            rotate([-45,0,0])
                cube([height_666_1004 + global_clearance,bevelled_width,bevelled_width]);
       
        translate([-coupling_width_666_1004/2 - global_clearance/2,- main_tube_outer_diameter/2 - thickness_between_tubes - main_tube_outer_diameter - coupling_wall_thickness - coupling_wall_thickness/sqrt(2),height_666_1004/2 + coupling_wall_thickness/sqrt(2)])  
            rotate([45,0,0])
                cube([coupling_width_666_1004 + global_clearance,height_666_1004,height_666_1004]);  

        //screw
        translate([-coupling_width_666_1004/2 - global_clearance/2,0,height_666_1004/2])
           rotate ([0,90,0])   
                cylinder(h = coupling_width_666_1004 + global_clearance, r = M3_screw_diameter/2, $fn = 15);

        translate ([0,- (main_tube_outer_diameter+thickness_between_tubes),0])
                cylinder (h = height_666_1004, r = M3_screw_diameter/2, $fn = 15);
                
        //nut
        translate([-coupling_width_666_1004/2 - global_clearance/2,0, height_666_1004/2])
            rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);
        
        translate([coupling_width_666_1004/2 - M3_screw_head_height,0,height_666_1004/2])
           rotate ([0,90,0])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

        translate([0, -(main_tube_outer_diameter+thickness_between_tubes),- global_clearance/2])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

        translate([0,-(main_tube_outer_diameter+thickness_between_tubes),height_666_1004 - M3_screw_head_height])
                cylinder (h = M3_screw_head_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);    
    }
}


module 666_1004_drillhelper(coupling_wall_thickness, thickness_between_tubes, draft = true){

       
    difference(){

        translate([-(coupling_width_666_1004/2), -depth_666_1004_drillhelper/4,0])
              cube([coupling_width_666_1004,depth_666_1004_drillhelper/2,height_666_1004]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h=height_666_1004 + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);
        
        //screw
        translate([-coupling_width_666_1004/2 - global_clearance/2,0,height_666_1004/2])
           rotate ([0,90,0])   
                cylinder(h = coupling_width_666_1004 + global_clearance, r = M3_screw_diameter/2, $fn = 15);
                
    }
}


666_1004(coupling_wall_thickness, thickness_between_tubes, draft);


translate([50,0,0])
    666_1004_drillhelper(coupling_wall_thickness, thickness_between_tubes, draft);
