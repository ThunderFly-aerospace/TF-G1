//========== DRŽÁK VIDLICE ==========//

include <../parameters.scad>

holder_length = 70;
holder_angle = 55;
joint_diameter = 40;
joint_height = 5;

module 888_2024() {
    translate([0, 0, -696_bearing_outer_diameter/2-material_around_bearing])
    difference() {
        union() {
            translate([fork_wheel_width/-2, 0, 0])
                cube([fork_wheel_width, holder_length, 696_bearing_outer_diameter+material_around_bearing*2]);

            translate([0, 0, 696_bearing_outer_diameter/2+material_around_bearing])
                rotate([0, 90, 0])
                    cylinder(d=696_bearing_outer_diameter+material_around_bearing*2, h=fork_wheel_width, $fn=100, center=true);

            translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                rotate([-holder_angle, 0, 0])
                    cylinder(d=joint_diameter, h=joint_height, $fn=100);
            
            hull() {
                translate([-fork_wheel_width/2, holder_length-joint_diameter*3/4, 0])
                    cube([fork_wheel_width, joint_diameter*3/4, 696_bearing_outer_diameter+material_around_bearing*2]);

                translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
                    rotate([-holder_angle, 0, 0])
                        cylinder(d=joint_diameter, h=joint_height/3, $fn=100);
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
                cylinder(d=M6_screw_diameter, h=fork_wheel_width+10, $fn=20, center=true);

        //ložiska
        translate([-fork_wheel_width/2-0.1, 0, 696_bearing_outer_diameter/2+material_around_bearing])
            rotate([0, 90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1, $fn=60);
        translate([fork_wheel_width/2+0.1, 0, 696_bearing_outer_diameter/2+material_around_bearing])
            rotate([0, -90, 0])
                cylinder(d=696_bearing_outer_diameter, h=696_bearing_thickness+0.1, $fn=60);

        //šroub pro připevnění k dílu motoru
        translate([0, holder_length, 696_bearing_outer_diameter+material_around_bearing*2])
            rotate([-holder_angle, 0, 0])
                #cylinder(d=M8_screw_diameter, h=600, $fn=100, center=true);
    }
}

888_2024();