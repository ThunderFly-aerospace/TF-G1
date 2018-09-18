//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;



module 888_2002(draft){

width = 2*tube_for_undercarriage_outer_diameter;
depth = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;
height = width;
    
difference(){

    union() {

        hull() {
            cylinder(h = height, r = tube_for_undercarriage_outer_diameter, $fn = draft ? 10 :50 );
            translate([0,1.5*main_tube_outer_diameter,0])
                cylinder(h = height/2, d = tube_for_undercarriage_outer_diameter, $fn = draft ? 10 :50 );
        }

        hull() {
            cylinder(h = height, r = tube_for_undercarriage_outer_diameter, $fn = draft ? 10 :50 );
            translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
                rotate([0,70,0])
                    cylinder(h = 2 * height, r = tube_for_undercarriage_outer_diameter, center = true,  $fn = draft ? 10 :50 );
        }
    }

	//vertical screw
    translate ([0,0,- global_clearance/2])
        cylinder(h = 2*height,d = M6_screw_diameter, $fn = draft ? 20 : 50);
    // podložka
    cylinder(h = 0.3, d = 13.6, $fn = draft ? 20 : 50);

    //cylinder(h = 0.6, d = 12, $fn = draft ? 20 : 50);

    translate([0,0,10-Nut_height_M6])
        cylinder (h = 2*height, d = Nut_diameter_M6, $fn = 6);


    //screw
    translate([0,main_tube_outer_diameter,0])
        cylinder(h = height, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );

    translate([0,1.5*main_tube_outer_diameter,0])
        cylinder(h = height, r = M3_screw_diameter/2, $fn = draft ? 10 :20 );


	//nut
    translate([0, main_tube_outer_diameter, height/2])
        cylinder (h = height, r = Nut_diameter_M3/2, $fn = 6);

    translate([0, 1.5* main_tube_outer_diameter, height/2])
        cylinder (h = height, r = Nut_diameter_M3/2, $fn = 6);

    // wheel tube 
    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70,0])
            cylinder(h = 2.5 * height, d = tube_for_undercarriage_outer_diameter, center = true,  $fn = draft ? 10 :50 );

    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([height/2, 0, tube_for_undercarriage_outer_diameter - Nut_height_M3])
                cylinder(h = 3* height, r = M3_screw_diameter/2, center = true, $fn = draft ? 10 :20 );

    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([-height/2, 0, tube_for_undercarriage_outer_diameter - Nut_height_M3])
                cylinder(h = 3* height, r = M3_screw_diameter/2, center = true, $fn = draft ? 10 :20 );


    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([-height/2, 0, tube_for_undercarriage_outer_diameter - Nut_height_M3])
                cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([height/2, 0, tube_for_undercarriage_outer_diameter - Nut_height_M3])
                cylinder(h = Nut_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([height/2, 0, -tube_for_undercarriage_outer_diameter - 10])
                cylinder(h = 10 - global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([0, -32/2 , 1.8 * tube_for_undercarriage_outer_diameter])
        rotate([0,70-90,0])
            translate([-height/2, 0, - tube_for_undercarriage_outer_diameter - 10])
                cylinder(h = 10 - global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    
    }
}



888_2002(draft);

include <../Parameters.scad>
