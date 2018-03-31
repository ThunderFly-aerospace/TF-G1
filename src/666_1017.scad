
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
    translate ([-0.1,-depth/2 - global_clearance/2,- global_clearance/2])
        cube ([0.2,depth + global_clearance,height + global_clearance]);

	//main tube
	translate([0,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2, height - main_tube_outer_diameter/2 - coupling_wall_thickness])   
        rotate([90,0,0])
            cylinder(h = depth + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0, - thickness_between_tubes])
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

module 666_1017_drillhelper(height = 70 - coupling_wall_thickness + main_tube_outer_diameter/2, height_of_cap_cylinder = 2){

width=main_tube_outer_diameter+4*thickness_between_tubes;
depth=main_tube_outer_diameter*2;



difference () {

    translate([-(width/2),-(depth/2),0])
    color([1,0,0])
       cube ([width,depth,height]);


    //main tube
    translate([0,main_tube_outer_diameter + coupling_wall_thickness + global_clearance/2, height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])   
        rotate([90,0,0])
            cylinder(h = main_tube_outer_diameter*3 + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0, - thickness_between_tubes])
        cylinder(h = height - main_tube_outer_diameter/2 - main_tube_outer_diameter,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

            

    //screws
    translate ([- width/2 - global_clearance/2,10 - M3_screw_diameter/2,height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])
        rotate ([0,90,0])
            cylinder (h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- width/2 - global_clearance/2,- 10 + M3_screw_diameter/2,height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- width/2 - global_clearance/2,0,27.5])
        rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- width/2 - global_clearance/2,0,7.5])
        rotate([0,90,0])
            cylinder(h = width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    //prořezy pro zajištění
    translate([- (3*global_clearance)/2,-depth/2 - global_clearance,height - main_tube_outer_diameter/2 - global_clearance])
           cube([3*global_clearance,depth + 2*global_clearance, main_tube_outer_diameter]);
    translate([-(3*global_clearance)/2, -2*main_tube_outer_diameter, -global_clearance])
            cube([3*global_clearance, 4*main_tube_outer_diameter, 1.5*main_tube_outer_diameter]);
    //šrouby
        translate([0,0,70 - thickness_between_tubes/2])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
        
        translate([0,main_tube_outer_diameter/2 + 2*thickness_between_tubes,main_tube_outer_diameter*(2/3)])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
        mirror([0,1,0])
                translate([0,main_tube_outer_diameter/2 + 2*thickness_between_tubes,main_tube_outer_diameter*(2/3)])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }


    }

}





//rotate([90,0,0])
  //  666_1017(draft);

//translate([70,0,0])
666_1017_drillhelper();

include <../Parameters.scad>
