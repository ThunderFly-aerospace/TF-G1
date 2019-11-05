//========== DRŽÁK VIDLICE ==========//

include <../parameters.scad>

holder_length = 90;
holder_angle = 55;
joint_diameter = 40;
joint_height = 5;
bearing_extension = 0;

module 888_2024(orientate = 0) {
    rotate([6.7, 0, 0]*orientate)
    //rotate([atan(((holder_length) / (-696_bearing_outer_diameter/2-material_around_bearing) )), 0, 0])

    //translate([0, 0, 0])
    //#rotate([0, 90, 0])
    //cylinder(d = 10, h = 100, center = true);


    //translate([0, holder_length, -696_bearing_outer_diameter/2-material_around_bearing])
    //#rotate([0, 90, 0])
    //cylinder(d = 10, h = 100, center = true);

    translate([0, 0, -696_bearing_outer_diameter/2-material_around_bearing])
    difference() {
        union() {
            hull() {
                translate([joint_width/-2, 0, 0])
                    cube([joint_width, holder_length+bearing_extension, 696_bearing_outer_diameter+material_around_bearing*2]);

                translate([0, 0, 696_bearing_outer_diameter/2+material_around_bearing])
                    rotate([0, 90, 0])
                        cylinder(d=696_bearing_outer_diameter+material_around_bearing*2, h=joint_width, $fn=100, center=true);

                translate([0, holder_length, 0])
                    rotate([0, 90, 0])
                        cylinder(d=696_bearing_outer_diameter+material_around_bearing*2, h=joint_width, $fn=50, center=true);
            }

            translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                rotate([-holder_angle, 0, 0])
                    cylinder(d=joint_diameter, h=joint_height, $fn=100);

            hull() {
                translate([-joint_width/2, holder_length-joint_diameter, 0])
                    cube([joint_width, joint_diameter*3/4, 696_bearing_outer_diameter+material_around_bearing*2]);

                translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                    rotate([-holder_angle, 0, 0])
                        cylinder(d=joint_diameter, h=joint_height/5, $fn=100);

                // kostka pro tahlo serva
                translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                    rotate([-holder_angle, 0, 0])
                        translate([32, 0, -10])
                            cylinder(d = 10, h = 10);
                            //cube([joint_diameter/2+10, 10, 10]);

                translate([0, holder_length, 0])
                    rotate([0, 90, 0])
                        cylinder(d=696_bearing_outer_diameter+material_around_bearing*2, h=fork_wheel_width, $fn=50, center=true);
            }

            //doraz
            translate([-stop_width/2, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                rotate([-holder_angle, 0, 0])
                    translate([0, -joint_diameter/2-stop_size, -40])
                        cube([stop_width, stop_size+10, joint_height+40]);
        }

        //šroub úchytu
        translate([0, 0, 696_bearing_outer_diameter/2+material_around_bearing])
            rotate([0, 90, 0])
                cylinder(d=M6_screw_diameter+2, h=fork_wheel_width+10, $fn=20, center=true);

        //ložiska
        translate([-joint_width/2-0.1, 0, 696_bearing_outer_diameter/2+material_around_bearing])
            rotate([0, 90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1, $fn=60);
        translate([joint_width/2+0.1, 0, 696_bearing_outer_diameter/2+material_around_bearing])
            rotate([0, -90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1, $fn=60);

        //Osa pro pripevneni k hornimu dilu
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                cylinder(d=15, h=600, $fn=100, center=true);

        //ložiska pro otáčení celého podvozku
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([0, 0, joint_height-608_bearing_thickness+0.1])
                    cylinder(d=608_bearing_outer_diameter, h=608_bearing_thickness, $fn=100);
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([0, 0, joint_height-608_bearing_thickness*2-100-front_undercarriage_bearing_distance])
                    cylinder(d=608_bearing_outer_diameter, h=608_bearing_thickness+100, $fn=100);

        // osazeni pro loziska
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([0, 0, joint_height-608_bearing_thickness+0.1-0.5])
                    cylinder(d=17, h=608_bearing_thickness, $fn=100);
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([0, 0, joint_height-608_bearing_thickness*2-100-10+0.5])
                    cylinder(d=18, h=608_bearing_thickness+100, $fn=100);


        // Otvory pro tahlo
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([31, 0, 0])
                   cylinder(d=M3_screw_diameter, h=600, $fn=100, center=true);


        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                translate([31, 0, -100-10])
                   cylinder(d=M3_nut_diameter, h=100, $fn=6);
                   //cylinder(d=14, h=600, $fn=100, center=true);



        //šroub pro připevnění pístů
        translate([0, holder_length, 0])
            rotate([0, 90, 0])
                cylinder(d=M6_screw_diameter+2, h=fork_wheel_width*2, $fn=20, center=true);

        //ložiska pro písty
        translate([-fork_wheel_width/2-0.1-2, holder_length, 0])
            rotate([0, 90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1, $fn=50);
        translate([fork_wheel_width/2+0.1+10+2, holder_length, 0])
            rotate([0, -90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1+10, $fn=50);

    }
}


translate([0, -holder_length/2, 0])
    rotate([holder_angle, 0, 0])
        888_2024();
