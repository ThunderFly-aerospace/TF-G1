//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 666_1014(draft){

width = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;
    
difference(){

    translate([-(width/2),-(depth - tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage),0])
        cube([width,depth,height]);

	//tube
    translate ([0,0,- global_clearance/2])
        cylinder(h = height + global_clearance,r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 100 : 200);

    //bevelled edge
    translate([width/2+sqrt(2)*coupling_wall_thickness_undercarriage,0,- global_clearance/2])
        rotate([0,0,45])
           cube([width,width,height+ global_clearance]);

mirror([1,0,0])
    translate([width/2+sqrt(2)*coupling_wall_thickness_undercarriage,0,- global_clearance/2])
        rotate([0,0,45])
            cube([width,width,height + global_clearance]);

    translate([-(width/2) - global_clearance/2,- depth + height/2-sqrt(2)*coupling_wall_thickness_undercarriage,height/2])
        rotate([-135,0,0])
            cube([width + global_clearance, height,height]);
   
   translate([-(width/2) - global_clearance/2, -depth + height/2-sqrt(2)*coupling_wall_thickness_undercarriage,height/2])  
        rotate([45,0,0])
            cube([width + global_clearance,height,height]);  


    // middle cut
    translate ([-0.25,- depth,- global_clearance/2])
        cube ([0.5,depth*2,height + global_clearance]);

    //screw
    translate([-width/2 - global_clearance/2,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + M4_screw_diameter/2), height/2])
        rotate([0,90,0])
            cylinder(h = width + global_clearance,r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([-width/2,0,height/2])
        rotate ([0,90,0])
            cylinder(h = width, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

	//nut
	translate([-width/2 - global_clearance, 0, height/2])
	   rotate([0,90,0])
	      cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
    
    translate([width/2 - Nut_height_M3, 0, height/2])
	   rotate([0,90,0])
	       cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

	translate([width/2 - Nut_height_M4,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + M4_screw_diameter/2), height/2])
	   rotate([0,90,0])
	      cylinder (h = Nut_height_M4 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);

    }
}


module 666_1014_drillhelper(draft){

width = 2*tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;
    
difference(){

    translate([-(width/2),-(depth - tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage),0])
        cube([width,depth,height]);

    //tube
    translate ([0,0,- global_clearance/2])
        cylinder(h = height + global_clearance,r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 100 : 200);


    // middle cut
    translate ([-global_clearance,- depth,- global_clearance/2])
        cube ([2* global_clearance, depth*2,height + global_clearance]);

    //screw
    translate([-width/2 - global_clearance/2,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + M4_screw_diameter/2), height/2])
        rotate([0,90,0])
            cylinder(h = width + global_clearance,r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([-width/2,0,height/2])
        rotate ([0,90,0])
            cylinder(h = width, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

    //nut    
    translate([width/2 - Nut_height_M3,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + M4_screw_diameter/2), height/2])
       rotate([0,90,0])
           cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    }
}


module 666_1014_A(draft){

width = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;

    difference(){
        666_1014(draft);

        translate ([0,- depth,- global_clearance/2])
            cube ([width,depth*2,height + global_clearance]);
    }
}


module 666_1014_B(draft){

width = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;

    difference(){
        666_1014(draft);

        translate ([-width, -depth, -global_clearance/2])
            cube([width, depth*2, height + global_clearance]);
    }
}

666_1014(draft);

//666_1014_drillhelper(draft);




include <../Parameters.scad>
