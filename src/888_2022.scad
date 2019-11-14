//========== VIDLICE TVARU H ==========//

include <../parameters.scad>
use <888_2011.scad>
use <888_2012.scad>
use <888_2021.scad>

module wheel_tiere(){
     rotate([90, 0, 0]){
        rotate_extrude($fn=$preview?30:200)
        hull(){
            translate([wheel_inner_diameter/2, -wheel_inner_thickness/2+wheel_disc_upper_thickness, 0])
                square([4, wheel_inner_thickness-wheel_disc_upper_thickness*2]);
            translate([19+wheel_outer_diameter/2 - wheel_inner_thickness, 0, 0])
            scale([0.7, 1.3]) circle(wheel_inner_thickness/2, $fn=100);
        }
    }
}

module wheel() {
    wheel_tiere();
    //rotate([90, 0, 0]) cylinder(h = 20, d = 110);
    translate([0, wheel_inner_thickness/2+4.6, 0]) rotate([90, 0, 0]) 888_2011(true);
    translate([0, -wheel_inner_thickness/2-4.6, 0]) rotate([-90, 0, 0]) 888_2011(false);
    translate([0, wheel_inner_thickness/2+6.8, 0]) rotate([90, 0, 0]) 888_2012();
    translate([0, -wheel_inner_thickness/2-6.8, 0]) rotate([-90, 0, 0]) 888_2012();
}

wheel_screw_diameter = M4_screw_diameter;
wheel_nut_diameter = M4_nut_diameter;
wheel_nut_height = M4_nut_height;
wheel_screw_head_height = M4_nut_height;
wheel_screw_head_diameter = M4_nut_diameter;

wheel_tolerance = -5;
888_2022_wheel_diameter = wheel_diameter+wheel_tolerance;
lifting_size = 10;

height = 696_bearing_outer_diameter+material_around_bearing*2;
connector_width = 15;
wheel_screw_overhang = 8;

front_fork_length = 888_2022_front_fork_length;
piston_mount_offset = 888_2022_piston_mount_offset;

module 888_2022(set_wheel=false) {
    translate([0, 0, 0]) {
    if(set_wheel) {
        translate([0, -front_fork_length, 0])
            rotate([0, 0, 90])
                wheel();
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
        translate([-joint_width/2-0.2, -connector_width-10, -height*5])
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

888_2022();
