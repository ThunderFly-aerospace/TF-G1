DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;  
DIM_SPACE = .1 * DOC_SCALING_FACTOR;   


//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 666_1026(draft)
{
    width = main_tube_outer_diameter+2*thickness_between_tubes;	
    depth = main_tube_outer_diameter*2;
    height = depth;


    difference (){

        translate([-(width/2),-(depth/2),0])
            color([0,0.5,0])

            cube ([width,depth,height]);
    	
    	//tube
    	translate([0,0,- global_clearance/2])
    	   cylinder(h = height + global_clearance,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    	//screw
    	translate([0,depth/2 + global_clearance/2,7.5])
    	   rotate([90,0,0])
    	       cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);


    	translate([0,depth/2 + global_clearance/2,42.5])
    	   rotate([90,0,0])
    	       cylinder(h = depth + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);
    	
    	//bevelled edge

    	   translate([width/2,main_tube_outer_diameter - 1,- global_clearance/2])
    	       rotate([0,0,45])
    	           cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);

        mirror([1,0,0])
            translate([width/2,main_tube_outer_diameter - 1,- global_clearance/2])
                rotate([0,0,45])
                    cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);
    	
        mirror([0,1,0])
            translate([width/2,main_tube_outer_diameter - 1,- global_clearance/2])
                rotate([0,0,45])
                    cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);

        mirror([1,0,0])
          mirror([0,1,0])
            translate([width/2,main_tube_outer_diameter - 1,- global_clearance/2])
                rotate([0,0,45])
                    cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);

    }
}


module 666_1026_drillhelper(height = 60, height_of_cap_cylinder = 2){



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

module 666_1026_drillhelper_doc(){


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



666_1026(draft);



666_1026(draft);

//666_1026_drillhelper(height = 60, height_of_cap_cylinder = 2);


include <../Parameters.scad>
