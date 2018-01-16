include <../Parameters.scad>

module 666_1004(wall_thickness, thickness_between_tubes, draft = true){

    width=main_tube_outer_diameter+2*wall_thickness;
    depth=main_tube_outer_diameter*2+2*wall_thickness+thickness_between_tubes;
    height=width;
    radius=main_tube_outer_diameter/2;


    difference(){

        translate([-(width/2),- (depth - main_tube_outer_diameter/2 - wall_thickness),0])
            cube([width,depth,height]);

        //tubes
        translate([0,0,-3])
            cylinder(h=height+6,r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);

        translate([-(main_tube_outer_diameter/2+wall_thickness) - 3, -(main_tube_outer_diameter+thickness_between_tubes), main_tube_outer_diameter/2 + wall_thickness])
            rotate([0,90,0])
                cylinder(h=height+6,r = main_tube_outer_diameter/2, $fn = draft ? 50 : 200);
        
        //bevelled edge
        translate([width/2+sqrt(2)*wall_thickness,0,-3])
            rotate([0,0,45])
                cube([width, width,height+6]);
        
        translate([-(width/2)-sqrt(2)*wall_thickness,0,-3])
            rotate([0,0,45])
                cube([width, width,height+6]); 
        
        translate([-(width/2)-3,- depth + height/2-sqrt(2)*wall_thickness,-height+(sqrt(2)*wall_thickness)/2])
            rotate([45,0,0])
                cube([width+6,height,height]);
       
        translate([-(width/2)-3, -depth + height/2-sqrt(2)*wall_thickness,height/2])  
            rotate([45,0,0])
                cube([width+6,height,height]);  

       	//screw
       	translate([-width/2,0,height/2])
    	   rotate ([0,90,0])   
                cylinder(h = width, r = M3_screw_diameter/2, $fn = 15);

        translate ([0,- (main_tube_outer_diameter+thickness_between_tubes),0])
            cylinder (h = height, r = M3_screw_diameter/2, $fn = 15);
    			
        //nut
        translate([-width/2-3,0, height/2])
            rotate ([0,90,0])
                cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

        translate([0, -(main_tube_outer_diameter+thickness_between_tubes),-3])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

        translate([width/2 - Nut_height_M3,0,height/2])
    	   rotate ([0,90,0])
                cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

        translate([0,-(main_tube_outer_diameter+thickness_between_tubes),height - Nut_height_M3])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);    
    }
}


666_1004(coupling_wall_thickness, thickness_between_tubes);

