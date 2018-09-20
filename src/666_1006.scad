
//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module 666_1006(height = 45, height_of_mini_cylinder = 2, draft = true)
{
	difference ()
    {

        union ()    // top cap 
        {   

            cylinder(h = height, d = main_tube_inner_diameter, $fn = draft ? 100 : 200);
            cylinder(h = height_of_mini_cylinder, d2 = main_tube_outer_diameter, d1 = main_tube_inner_diameter, $fn = draft ? 100 : 200);
        }


        translate([0,0, -global_clearance/2])
            cylinder (h= height + global_clearance, d = tube_for_undercarriage_outer_diameter, $fn = draft ? 50 : 100);

        //screw
        translate([-main_tube_inner_diameter/2 - global_clearance/2, 0, height/3 + height_of_mini_cylinder])
            rotate([0,90,0])
                cylinder(h = main_tube_inner_diameter + global_clearance, d = M3_screw_diameter, $fn = draft ? 10 : 20);

        //screw
        translate([-main_tube_inner_diameter/2 - global_clearance/2, 0, height - height/3 + height_of_mini_cylinder])
            rotate([0,90,0])
                cylinder(h = main_tube_inner_diameter + global_clearance, d = M3_screw_diameter, $fn = draft ? 10 : 20);
     }
}



module 666_1006_drillhelper(height = 45, height_of_mini_cylinder = 2)
{
    difference (){

    translate([-(main_tube_outer_diameter + 2* thickness_between_tubes)/2,- main_tube_outer_diameter,0])
        cube ([main_tube_outer_diameter + 2*thickness_between_tubes,2*main_tube_outer_diameter,height]);
            
    //tube
    translate([0,0,height_of_mini_cylinder])
            cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2,$fn = draft ? 100 : 200);

    //screw
    translate([0,main_tube_outer_diameter + global_clearance/2,height/3 + height_of_mini_cylinder])
        rotate([90,0,0])
            cylinder(h = 2 * main_tube_outer_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    //screw
    translate([0,main_tube_outer_diameter + global_clearance/2,height - height/3 + height_of_mini_cylinder])
        rotate([90,0,0])
            cylinder(h = 2 * main_tube_outer_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    //bevelled edge
    translate([(main_tube_outer_diameter + 2*thickness_between_tubes)/2, main_tube_outer_diameter - 1,- global_clearance/2])
        rotate([0,0,45])
            cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);

    mirror ([1,0,0])
        translate([(main_tube_outer_diameter + 2*thickness_between_tubes)/2, main_tube_outer_diameter - 1,- global_clearance/2])
            rotate([0,0,45])
                cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);


    mirror([0,1,0])
        translate([(main_tube_outer_diameter + 2*thickness_between_tubes)/2, main_tube_outer_diameter - 1,- global_clearance/2])
            rotate([0,0,45])
                cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);


    mirror ([1,0,0])
        mirror([0,1,0])
            translate([(main_tube_outer_diameter + 2*thickness_between_tubes)/2, main_tube_outer_diameter - 1,- global_clearance/2])
                rotate([0,0,45])
                    cube([main_tube_outer_diameter,main_tube_outer_diameter,height + global_clearance]);
    //final difference
    }
//final module    
}


rotate([0,0,90])
    666_1006();

translate([2*main_tube_outer_diameter,0,0])
    666_1006_drillhelper();


include <../Parameters.scad>
