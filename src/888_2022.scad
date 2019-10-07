//========== VIDLICE TVARU H ==========//

include <../parameters.scad>


wheel_screw_diameter = M4_screw_diameter;
wheel_nut_diameter = M4_nut_diameter;
wheel_nut_height = M4_nut_height;
wheel_screw_head_height = M4_nut_height;
wheel_screw_head_diameter = M4_nut_diameter;

wheel_tolerance = 15;
888_2022_wheel_diameter = wheel_diameter+wheel_tolerance;
lifting_size = 10;

height = 696_bearing_outer_diameter+material_around_bearing*2;
connector_width = 25;
wheel_screw_overhang = 8;

front_fork_length = 120;
piston_mount_offset = -15;

module 888_2022(wheel=false) {
    translate([0, 0, 0]) {
    if(wheel) {
        union() {
            translate([-fork_wheel_width*1/3/2, -888_2022_wheel_diameter/2, 0])
                rotate([0, -90, 0])
                    cylinder(d2=wheel_diameter-30, d1=wheel_diameter, h=fork_wheel_width*1/3, $fn=20);
            translate([fork_wheel_width*1/3/2, -888_2022_wheel_diameter/2, 0])
                rotate([0, 90, 0])
                    cylinder(d2=wheel_diameter-30, d1=wheel_diameter, h=fork_wheel_width*1/3, $fn=20);
            translate([0, -888_2022_wheel_diameter/2, 0])
                rotate([0, 90, 0])
                    cylinder(d=wheel_diameter, h=fork_wheel_width*1/3, center=true, $fn=20);
        }
    }


    difference() {
        union() {
            translate([-chasis_fork_thickness-fork_wheel_width/2, -front_fork_length-chasis_fork_thickness, -height/2])
                hull(){
                    cube([chasis_fork_thickness*2+fork_wheel_width, 888_2022_wheel_diameter/2+chasis_fork_thickness, height]);

                    translate([-chasis_fork_thickness + fork_wheel_width/2 , 0, 0])
                        cube([chasis_fork_thickness*4, front_fork_length+chasis_fork_thickness*2, height]);
                }

            hull() {

                translate([0, 0, 0])
                    cube([chasis_fork_thickness*2+joint_width, 20, height], center = true);

                //translate([0, connector_width+material_around_bearing*2+696_bearing_outer_diameter, height/2+696_bearing_outer_diameter/2+material_around_bearing+lifting_size])
                    rotate([0, 90, 0])
                        cylinder(d=height, h=chasis_fork_thickness*2+joint_width, $fn=100, center=true);
            }

            translate([0, -front_fork_length - piston_mount_offset, 0])
                hull() {
                translate([0, 0, 0])
                    cube([chasis_fork_thickness*2+fork_wheel_width, (M3_nut_diameter+3)*2, height], center=true);

                translate([0, 0, screw_spring_distance])
                    rotate([0, 90, 0])
                        cylinder(d=M3_nut_diameter+3, h=chasis_fork_thickness*2+fork_wheel_width, $fn=50, center=true);
            }
        }

        //kolo
        translate([0, -front_fork_length, 0])
            cube([fork_wheel_width, 888_2022_wheel_diameter, 888_2022_wheel_diameter], center=true);

        //kolo
        translate([0, -front_fork_length + 888_2022_wheel_diameter/2, 0])
            scale([1,1/2, 1])
                cylinder(d=fork_wheel_width, h=height*2, $fn=50, center=true);

        //uchycení
        #translate([-joint_width/2-0.2, -connector_width-10, -height*5])
            cube([joint_width+0.4, 300, height*10]);

        //šroub u kola
        translate([0, -front_fork_length, 0])
            rotate([0, 90, 0])
                cylinder(d=wheel_screw_diameter, h=chasis_fork_thickness*2+fork_wheel_width+10, center=true, $fn=20);

        //matka šroubu u kola
        translate([50/2, -front_fork_length, 0])
            rotate([0, 90, 0])
                cylinder(d=wheel_nut_diameter, h=10+0.1, $fn=6);

        //hlavička šroubu u kola
        translate([-50/2, -front_fork_length, 0])
            rotate([0, -90, 0])
                cylinder(d=wheel_screw_head_diameter, h=10+0.1, $fn=20);

        //šroub pístu
        translate([0, -front_fork_length - piston_mount_offset, screw_spring_distance])
            rotate([0, 90, 0])
                cylinder(d=M3_screw_diameter, h=chasis_fork_thickness*2+fork_wheel_width+10, center=true, $fn=20);

        //matka šroubu u pístu
        translate([0, -front_fork_length - piston_mount_offset, screw_spring_distance])
            rotate([0, 90, 0])
                cylinder(d=M3_nut_diameter, h=M3_nut_height*2+fork_wheel_width, center=true, $fn=6);

        //šroub uchycení
        rotate([0, 90, 0])
            cylinder(d=M6_screw_diameter, h=chasis_fork_thickness*2+fork_wheel_width+10, $fn=20, center=true);

        rotate([0, 90, 0])
            translate([0, 0, chasis_fork_thickness+joint_width/2-5])
                cylinder(d=M6_nut_diameter, h=10, $fn=20);

        rotate([0, 90, 0])
            translate([0, 0, -(chasis_fork_thickness+joint_width/2)-5])
                cylinder(d=M5_nut_diameter, h=10, $fn=6);


    }
    }
}

888_2022(false);
