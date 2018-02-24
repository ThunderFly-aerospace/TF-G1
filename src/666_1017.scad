
//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 666_1017(draft) {

width=main_tube_outer_diameter+2*coupling_wall_thickness;
depth=width;
height= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;


difference () {
	translate([-(width/2),-(width/2),0])
	   cube ([width,depth,height]);

    //middle cut
    translate ([-4,-depth/2 - global_clearance/2,- global_clearance/2])
        cube ([8,depth + global_clearance,height + global_clearance]);

	//main tube
	translate([0,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2, height- main_tube_outer_diameter/2 - coupling_wall_thickness])   
        rotate([90,0,0])
            cylinder(h = depth + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0, - global_clearance*2])
        cylinder(h = height - coupling_wall_thickness - main_tube_outer_diameter,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

   			

   	//screws
   	translate ([- width/2 - global_clearance/2,10 - M3_screw_diameter/2,height - coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([- width/2 - global_clearance/2,- 10 + M3_screw_diameter/2,height - coupling_wall_thickness - main_tube_outer_diameter/2])
     	rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([- width/2 - global_clearance/2,0,27.5])
        rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([- width/2 - global_clearance/2,0,7.5])
        rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	//nut
 	translate ([- width/2 - global_clearance,10 - M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
	
	translate([- width/2 - global_clearance,- 10 + M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

	translate ([width/2 - Nut_height_M3,10 - M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
	
	translate([width/2 - Nut_height_M3,- 10 + M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

 	translate([- width/2 - global_clearance,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

 	translate([- width/2 - global_clearance,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2 - Nut_height_M3,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2 - Nut_height_M3,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    //horizontal bevelled edge
        translate([0,-(depth/2) - global_clearance/2,height+sqrt(2)*coupling_wall_thickness])
            rotate([0,45,0])
                cube([width,width + global_clearance,width]);

    mirror([1,0,0])
        translate([0,-(depth/2) - global_clearance/2,height+sqrt(2)*coupling_wall_thickness])
            rotate([0,45,0])
                cube([width,width + global_clearance,width]);

    //vertical bevelled edge

        translate([-width + 2,0,- global_clearance/2])
            rotate([0,0,45])
                cube([height,height,height + global_clearance]);

    mirror([1,0,0])
        translate([-width + 2,0,- global_clearance/2])
            rotate([0,0,45])
                cube([height,height,height + global_clearance]);

    mirror([0,1,0])
        translate([-width + 2,0,- global_clearance/2])
            rotate([0,0,45])
                cube([height,height,height + global_clearance]);

    mirror([0,1,0])
        mirror([1,0,0])
            translate([-width + 2,0,- global_clearance/2])
                rotate([0,0,45])
                    cube([height,height,height + global_clearance]);
    }    
}

rotate([90,0,0])
    666_1017(draft);

include <../Parameters.scad>
