//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 666_1015(draft){

    
difference(){

    translate([-(width_666_1015/2),-(depth_666_1015 - tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage),0])
        cube([width_666_1015,depth_666_1015,height_666_1015]);

	//tube
    translate ([0,0,- global_clearance/2])
        cylinder(h = height_666_1015 + global_clearance,r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 100 : 200);

    //bevelled edge
    translate([width_666_1015/2+sqrt(2)*coupling_wall_thickness_undercarriage,0,- global_clearance/2])
        rotate([0,0,45])
           cube([width_666_1015,width_666_1015,height_666_1015 + global_clearance]);

mirror([1,0,0])
    translate([width_666_1015/2+sqrt(2)*coupling_wall_thickness_undercarriage,0,- global_clearance/2])
        rotate([0,0,45])
            cube([width_666_1015,width_666_1015,height_666_1015 + global_clearance]);

    translate([-(width_666_1015/2) - global_clearance/2,- depth_666_1015 + height_666_1015/2-sqrt(2)*coupling_wall_thickness_undercarriage,height_666_1015/2])
        rotate([-135,0,0])
            cube([width_666_1015 + global_clearance, height_666_1015,height_666_1015]);
   
   translate([-(width_666_1015/2) - global_clearance/2, - depth_666_1015 + height_666_1015/2-sqrt(2)*coupling_wall_thickness_undercarriage,height_666_1015/2])  
        rotate([45,0,0])
            cube([width_666_1015 + global_clearance,height_666_1015,height_666_1015]);  
    // END of bevelled edge

    // middle cut
    translate ([-0.25,- depth_666_1015,- global_clearance/2])
        cube ([0.5,depth_666_1015*2,height_666_1015 + global_clearance]);

    //screw
    
    translate([-width_666_1015/2,0,height_666_1015/4])
        rotate ([0,90,0])
            cylinder(h = width_666_1015, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

	translate([-width_666_1015/2,0,height_666_1015 - height_666_1015/4])
        rotate ([0,90,0])
            cylinder(h = width_666_1015, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

	translate([width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2) ,0])
            cylinder(h = width_666_1015, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

	translate([-width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2) ,0])
            cylinder(h = width_666_1015, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );


//////
    translate([-width_666_1015/2 - global_clearance/2,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2), height_666_1015/2])
        rotate([0,90,0])
            cylinder(h = width_666_1015 + global_clearance, d=tube_for_undercarriage_outer_diameter, $fn = draft ? 10 : 20);



	//nut
	translate([-width_666_1015/2 - global_clearance, 0, height_666_1015/4])
	   rotate([0,90,0])
	      cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
    
    translate([width_666_1015/2 - Nut_height_M3, 0, height_666_1015/4])
	   rotate([0,90,0])
	       cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

	translate([-width_666_1015/2 - global_clearance, 0, height_666_1015 - height_666_1015/4])
	   rotate([0,90,0])
	      cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
    
    translate([width_666_1015/2 - Nut_height_M3, 0, height_666_1015 - height_666_1015/4])
	   rotate([0,90,0])
	       cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);


	//nut
	translate([-width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2) ,-global_clearance])
	      cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
    
	translate([width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2), -global_clearance])
	       cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

	translate([-width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2) ,width_666_1015-Nut_height_M3])
	      cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);
    
	translate([width_666_1015/4,  -(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + tube_for_undercarriage_outer_diameter/2) ,width_666_1015-Nut_height_M3])
	       cylinder (h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    }
}


module 666_1015_drillhelper(draft){

    
difference(){

    translate([-(width_666_1015_drillhelper/2),-(depth_666_1015 - tube_for_undercarriage_outer_diameter/2 - coupling_wall_thickness_undercarriage),-5])
       		cube([width_666_1015_drillhelper,depth_666_1015,height_666_1015 + 10]);

    //tube
    translate ([0,0,- global_clearance/2 - 5])
       		cylinder(h = height_666_1015 + global_clearance + 10,r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 100 : 200);


    // middle cut
    translate ([-global_clearance,- depth_666_1015,- global_clearance/2 - 5])
        	cube ([2* global_clearance, depth_666_1015*2,height_666_1015 + global_clearance + 10]);

    //screw
    translate([-width_666_1015_drillhelper/2 - global_clearance/2,-(thickness_between_tubes_undercarriage + tube_for_undercarriage_outer_diameter/2 + M4_screw_diameter/2), height_666_1015/2])
        rotate([0,90,0])
            cylinder(h = width_666_1015_drillhelper + global_clearance,r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([-width_666_1015_drillhelper/2 - global_clearance/2,0,height_666_1015/4])
        rotate ([0,90,0])
            cylinder(h = width_666_1015_drillhelper + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

	translate([-width_666_1015_drillhelper/2 - global_clearance/2,0,height_666_1015 - height_666_1015/4])
        rotate ([0,90,0])
            cylinder(h = width_666_1015_drillhelper+global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

    }
}


module 666_1015_A(draft){

    difference(){
        666_1015(draft);

        translate ([0,- depth_666_1015,- global_clearance/2])
            cube ([width_666_1015,depth_666_1015*2,height_666_1015 + global_clearance]);
    }
}


module 666_1015_B(draft){


    difference(){
        666_1015(draft);

        translate ([-width_666_1015, -depth_666_1015, -global_clearance/2])
           cube([width_666_1015, depth_666_1015*2, height_666_1015 + global_clearance]);
    }
}



		666_1015(draft);

translate([0,30,0])
		666_1015_drillhelper(draft);

include <../Parameters.scad>