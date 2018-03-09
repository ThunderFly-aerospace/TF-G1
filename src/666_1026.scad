
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

666_1026(draft);


include <../Parameters.scad>
