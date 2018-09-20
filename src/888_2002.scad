//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 888_2002(draft){

width = 2*tube_for_undercarriage_outer_diameter;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;

wheel_width = 32;
wheel_diameter = 110; 
    
difference(){

    union() {


        hull() {
            cylinder(h = height, d = 608_bearing_outer_diameter * 1.5, $fn = draft ? 10 :50 );
            translate([0,1.5*main_tube_outer_diameter,0])
                cylinder(h = height/2, d = tube_for_undercarriage_outer_diameter, $fn = draft ? 10 :50 );
        }

        hull() {
            cylinder(h = height, d = 608_bearing_outer_diameter * 1.5, $fn = draft ? 10 :50 );
            translate([wheel_width/2, - 2*tube_for_undercarriage_outer_diameter, 1.8 * tube_for_undercarriage_outer_diameter])
                rotate([45,0,0])
                    cube([10,15,height/2]);
        }


        //hull() {
            translate([wheel_width/2, - 2*tube_for_undercarriage_outer_diameter, 1.8 * tube_for_undercarriage_outer_diameter])
                rotate([45,0,0])
                {
                 //   cylinder(h =  height, d = tube_for_undercarriage_outer_diameter, center = true,  $fn = draft ? 10 :50 );
                    cube([10,15,70]);
                }
        //}


    }

	//vertical screw
    translate ([0,0,- global_clearance/2])
        cylinder(h = 2*height, d = 608_bearing_outer_diameter - 3, $fn = draft ? 20 : 50);

    cylinder (h= 608_bearing_thickness, d = 608_bearing_outer_diameter, $fn = draft ? 50 : 100);
    translate([0,0,10 + 608_bearing_thickness])
        cylinder (h= height, d = 608_bearing_outer_diameter, $fn = draft ? 50 : 100);



    //servo screw
    translate([0,main_tube_outer_diameter,0])
        cylinder(h = height, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

    translate([0,1.5*main_tube_outer_diameter,0])
        cylinder(h = height, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );


    // wheel screw
    translate([wheel_width/2, -wheel_diameter/2 - tube_for_undercarriage_outer_diameter/2, wheel_diameter/2 + 1.2*tube_for_undercarriage_outer_diameter])
        rotate([0,90,0])
            cylinder(h = height, d = M4_screw_diameter, center = true, $fn = draft ? 10 :20 );

    translate([wheel_width/2 + 7, -wheel_diameter/2 - tube_for_undercarriage_outer_diameter/2, wheel_diameter/2 + 1.2*tube_for_undercarriage_outer_diameter])
        rotate([0,90,0])
            cylinder(h = height, d = Nut_diameter_M4, $fn = 6);



	//nut
    translate([0, main_tube_outer_diameter, height/2])
        cylinder (h = height, r = Nut_diameter_M3/2, $fn = 6);

    translate([0, 1.5* main_tube_outer_diameter, height/2])
        cylinder (h = height, r = Nut_diameter_M3/2, $fn = 6);
    
    }
}



888_2002(draft);

include <../Parameters.scad>
