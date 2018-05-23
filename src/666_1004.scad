include <../Parameters.scad>
draft = true;

module 666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true){


    width = (main_tube_outer_diameter+2*coupling_wall_thickness - Screw_head_height_M3)/basic_screw_length;
        echo("width is", width);
    
        echo("ceil is", ceil(width));

    coupling_screw_length = (ceil(width)) * basic_screw_length;
        echo("coupling_screw_length is", coupling_screw_length);

    coupling_width = coupling_screw_length + Screw_head_height_M3;
        echo("coupling_width is", coupling_width);

    height=coupling_width;
        echo("height is", height);

    depth=main_tube_outer_diameter*2+2*coupling_wall_thickness+thickness_between_tubes;
        radius=main_tube_outer_diameter/2;

    bevelled_width = main_tube_outer_diameter + 2*coupling_wall_thickness;

    difference(){

        translate([-(coupling_width/2), - depth + main_tube_outer_diameter/2 + coupling_wall_thickness,0])
              cube([coupling_width,depth,height]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        translate([-coupling_width/2 - global_clearance/2, -(main_tube_outer_diameter+thickness_between_tubes),height/2])
            rotate([0,90,0])
               cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 50 : 200);
        
        //bevelled edge
        translate([bevelled_width/2+coupling_wall_thickness/sqrt(2),coupling_wall_thickness/sqrt(2),- global_clearance/2])
            rotate([0,0,45])
                cube([bevelled_width, bevelled_width,height + global_clearance]);
        
        translate([-(bevelled_width/2) - coupling_wall_thickness/sqrt(2),coupling_wall_thickness/sqrt(2),- global_clearance/2])
            rotate([0,0,45])
                cube([bevelled_width, bevelled_width,height + global_clearance]); 
        
        translate([- height/2 - global_clearance/2,- main_tube_outer_diameter/2 - thickness_between_tubes - main_tube_outer_diameter - coupling_wall_thickness - (sqrt(2)*bevelled_width)/2 - (main_tube_outer_diameter/sqrt(2))/3 - coupling_wall_thickness/sqrt(2),-coupling_wall_thickness/sqrt(2)])
            rotate([-45,0,0])
                cube([height + global_clearance,bevelled_width,bevelled_width]);
       
        translate([-coupling_width/2 - global_clearance/2,- main_tube_outer_diameter/2 - thickness_between_tubes - main_tube_outer_diameter - coupling_wall_thickness - coupling_wall_thickness/sqrt(2),height/2 + coupling_wall_thickness/sqrt(2)])  
            rotate([45,0,0])
                cube([coupling_width + global_clearance,height,height]);  

        //screw
        translate([-coupling_width/2 - global_clearance/2,0,height/2])
           rotate ([0,90,0])   
                cylinder(h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = 15);

        translate ([0,- (main_tube_outer_diameter+thickness_between_tubes),0])
                cylinder (h = height, r = M3_screw_diameter/2, $fn = 15);
                
        //nut
        translate([-coupling_width/2 - global_clearance/2,0, height/2])
            rotate ([0,90,0])
                cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
        
        translate([coupling_width/2 - Screw_head_height_M3,0,height/2])
           rotate ([0,90,0])
                cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

        translate([0, -(main_tube_outer_diameter+thickness_between_tubes),- global_clearance/2])
                cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

        translate([0,-(main_tube_outer_diameter+thickness_between_tubes),height - Screw_head_height_M3])
                cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);    
    }
}


666_1004(coupling_wall_thickness, thickness_between_tubes, draft);

