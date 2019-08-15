include <../parameters.scad>

//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


module 888_2004(height = 45, height_of_mini_cylinder = 2, draft = true)
{
    height = height_of_mini_cylinder+g2_0_space_btw_wheel_holder+g2_5_height;

    bearing_screw_length = 45;

	difference ()
    {

        union ()    // top cap
        {
            cylinder(h = height_of_mini_cylinder, d = main_tube_outer_diameter, $fn = draft ? 100 : 200);

            cylinder (h = height, d = main_tube_inner_diameter, $fn = draft ? 100 : 200);
        }


        translate([0, 0, bearing_screw_length - 2 * 608_bearing_thickness - 10 - 1.5 - global_clearance])  /// 1.5 mm je tloušťka podložky
            cylinder (h = 2*height, d = M6_screw_diameter, $fn = draft ? 50 : 100);

        translate([0, 0, bearing_screw_length - 2 * 608_bearing_thickness - 6])  /// 1.5 mm je tloušťka podložky
            cylinder (h = 2*height, d = M6_nut_diameter, $fn = 6);

        translate([0, 0, -global_clearance])  /// 1.5 mm je tloušťka podložky
            cylinder (h= bearing_screw_length - 2 * 608_bearing_thickness - 10 - 1.5, d = 8.5, $fn = draft ? 50 : 100);

        //screw
        //translate([-main_tube_inner_diameter/2 - global_clearance/2, 0, height/2 + height_of_mini_cylinder])
        //    rotate([0,90,0])
        //        cylinder(h = main_tube_inner_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

        for (i = [1:2]){
            translate([0,main_tube_outer_diameter + global_clearance/2, height - i*g2_5_height/3])
                rotate([90,0,0])
                    cylinder(h = 2 * main_tube_outer_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
        }

    }
}



module 888_2004_drillhelper(height = 45, height_of_mini_cylinder = 2)
{

    height = height_of_mini_cylinder+g2_0_space_btw_wheel_holder+g2_5_height;

    difference (){

    translate([-(main_tube_outer_diameter + 2* thickness_between_tubes)/2,- main_tube_outer_diameter,0])
        cube ([main_tube_outer_diameter + 2*thickness_between_tubes,2*main_tube_outer_diameter,height]);

            //tube
            translate([0,0,height_of_mini_cylinder])
                    cylinder(h=height + global_clearance,r = main_tube_outer_diameter/2,$fn = draft ? 100 : 200);

            //screw
            //translate([0,main_tube_outer_diameter + global_clearance/2, height/2 + height_of_mini_cylinder])
            //    rotate([90,0,0])
            //        cylinder(h = 2 * main_tube_outer_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

            for (i = [1:2]){
                translate([0,main_tube_outer_diameter + global_clearance/2, height - i*g2_5_height/3])
                    rotate([90,0,0])
                        cylinder(h = 2 * main_tube_outer_diameter + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
            }


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
    888_2004();

translate([2*main_tube_outer_diameter,0,0])
    888_2004_drillhelper();


include <../parameters.scad>
