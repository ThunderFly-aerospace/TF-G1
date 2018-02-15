include <../Parameters.scad>
draft = true;

module 666_1004(coupling_wall_thickness, thickness_between_tubes, draft = true){


    width=main_tube_outer_diameter+2*coupling_wall_thickness;
    depth=main_tube_outer_diameter*2+2*coupling_wall_thickness+thickness_between_tubes;
    height=width;
    radius=main_tube_outer_diameter/2;


    difference(){

        translate([-(width/2),- (depth - main_tube_outer_diameter/2 - coupling_wall_thickness),0])
            cube([width,depth,height]);

        //tubes
        translate([0,0,- global_clearance/2])
            cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        translate([-(main_tube_outer_diameter/2+coupling_wall_thickness) - global_clearance/2, -(main_tube_outer_diameter+thickness_between_tubes), main_tube_outer_diameter/2 + coupling_wall_thickness])
            rotate([0,90,0])
                cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 50 : 200);
        
        //bevelled edge
        translate([width/2+sqrt(2)*coupling_wall_thickness,0,- global_clearance/2])
            rotate([0,0,45])
                cube([width, width,height + global_clearance]);
        
        translate([-(width/2)-sqrt(2)*coupling_wall_thickness,0,- global_clearance/2])
            rotate([0,0,45])
                cube([width, width,height + global_clearance]); 
        
        translate([-(width/2) - global_clearance/2,- depth + height/2-sqrt(2)*coupling_wall_thickness,-height+(sqrt(2)*coupling_wall_thickness)/2])
            rotate([45,0,0])
                cube([width + global_clearance,height,height]);
       
        translate([-(width/2) - global_clearance/2, - depth + height/2-sqrt(2)*coupling_wall_thickness,height/2])  
            rotate([45,0,0])
                cube([width + global_clearance,height,height]);  

       	//screw
       	translate([-width/2,0,height/2])
    	   rotate ([0,90,0])   
                cylinder(h = width, r = M3_screw_diameter/2, $fn = 15);

        translate ([0,- (main_tube_outer_diameter+thickness_between_tubes),0])
            cylinder (h = height, r = M3_screw_diameter/2, $fn = 15);
    			
        //nut
        translate([-width/2 - global_clearance/2,0, height/2])
            rotate ([0,90,0])
                cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

        translate([0, -(main_tube_outer_diameter+thickness_between_tubes),- global_clearance/2])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

        translate([width/2 - Nut_height_M3,0,height/2])
    	   rotate ([0,90,0])
                cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

        translate([0,-(main_tube_outer_diameter+thickness_between_tubes),height - Nut_height_M3])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);    
    }
}


666_1004(coupling_wall_thickness, thickness_between_tubes, draft);

