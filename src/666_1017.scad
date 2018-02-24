
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
    translate ([-4,-depth/2-3,-3])
        cube ([8,depth+6,height+6]);

	//main tube
	translate([0,main_tube_outer_diameter/2 + coupling_wall_thickness + 3, height- main_tube_outer_diameter/2 - coupling_wall_thickness])   
        rotate([90,0,0])
            cylinder(h = depth+6, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0,-1])
        cylinder(h = height - main_tube_outer_diameter - coupling_wall_thickness,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

   			

   	//screws
   	translate ([-width/2-3,10-M3_screw_diameter/2,height - coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = width+6, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([-width/2-3,-10+M3_screw_diameter/2,height - coupling_wall_thickness - main_tube_outer_diameter/2])
     	rotate([0,90,0])
            cylinder(h = width+6, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([-width/2-3,0,27.5])
        rotate([0,90,0])
            cylinder(h = width+6, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	translate([-width/2-3,0,7.5])
        rotate([0,90,0])
            cylinder(h = width+6, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

 	//nut
 	translate ([-width/2-3,10-M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);
	
	translate([-width/2-3,-10+M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

	translate ([width/2-Nut_height_M3,10-M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
   	    rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);
	
	translate([width/2-Nut_height_M3,-10+M3_screw_diameter/2,height- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

 	translate([-width/2-3,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

 	translate([-width/2-3,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2-Nut_height_M3,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2-Nut_height_M3,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Nut_height_M3+3, r = Nut_diameter_M3/2, $fn = 6);

    //horizontal bevelled edge
    translate([0,-(depth/2)-3,height+sqrt(2)*coupling_wall_thickness])
        rotate([0,45,0])
            cube([width,width+6,width]);

    translate([-width/2-(sqrt(2)*coupling_wall_thickness),-(depth/2)-3,height - coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,-45,0])
            cube([width,width+6,width]);

    //vertical bevelled edge
    translate([-width+2,0,-3])
        rotate([0,0,225])
            cube([height,height,height+6]);

    translate([-width+2,0,-3])
        rotate([0,0,45])
            cube([height,height,height+6]);

    translate([+width-2,0,-3])
        rotate([0,0,45])
            cube([height,height,height+6]);

    translate([0,-width+2,-3])
        rotate([0,0,-45])
            cube([height,height,height+6]);


    }    
}

rotate([90,0,0])
    666_1017(draft);

include <../Parameters.scad>
