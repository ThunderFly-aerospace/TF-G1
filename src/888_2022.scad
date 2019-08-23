//========== VIDLICE TVARU H ==========//

include <../parameters.scad>

module 888_2016() {
    translate([-(696_bearing_outer_diameter/2+888_2016_connector_width+7), 0, 0])
    rotate([0, 0, -90])
    difference() {
        translate([-888_2016_holder_thickness-888_2016_wheel_width/2, -888_2016_wheel_diameter/2-10, -888_2016_height/2])
            cube([888_2016_holder_thickness*2+888_2016_wheel_width, 888_2016_wheel_diameter/2+50, 888_2016_height]);

        //otvor pro kolo
        translate([0, -888_2016_wheel_diameter/2-888_2016_wheel_width/2, 0])
            cube([888_2016_wheel_width, 888_2016_wheel_diameter, 888_2016_wheel_diameter], center=true);

        //otvor pro kolo
        translate([0, -888_2016_wheel_width/2, 0])
            cylinder(d=888_2016_wheel_width, h=888_2016_height*2, $fn=50, center=true);

        //otvor pro uchycení
        translate([-888_2016_wheel_width/2, 888_2016_connector_width, -888_2016_height/2-0.1])
            cube([888_2016_wheel_width, 100, 888_2016_height+0.2]);

        //otvor pro šroub u kola
        translate([0, -888_2016_wheel_diameter/2, 0])
            rotate([0, 90, 0])
                cylinder(d=888_2016_wheel_screw_diameter, h=888_2016_holder_thickness*2+888_2016_wheel_width+10, center=true, $fn=20);

        //matka šroubu u kola
        translate([888_2016_wheel_width/2+888_2016_holder_thickness-888_2016_wheel_nut_height, -888_2016_wheel_diameter/2, 0])
            rotate([0, 90, 0])
                cylinder(d=888_2016_wheel_nut_diameter, h=888_2016_wheel_nut_height+0.1, $fn=6);

        //hlavička šroubu u kola
        translate([-888_2016_wheel_width/2-888_2016_holder_thickness+888_2016_wheel_screw_head_height, -888_2016_wheel_diameter/2, 0])
            rotate([0, -90, 0])
                cylinder(d=888_2016_wheel_screw_head_diameter, h=888_2016_wheel_screw_head_height+0.1, $fn=20);

        //šroub pístu
        translate([0, -888_2016_wheel_diameter/2+screw_spring_distance, 0])
            rotate([0, 90, 0])
                cylinder(d=M3_screw_diameter, h=888_2016_holder_thickness*2+888_2016_wheel_width+10, center=true, $fn=20);

        //matka šroubu u pístu
        translate([0, -888_2016_wheel_diameter/2+screw_spring_distance, 0])
            rotate([0, 90, 0])
                cylinder(d=M3_nut_diameter, h=M3_nut_height*2+888_2016_wheel_width, center=true, $fn=6);

        //otvor pro šroub uchycení
        translate([0, 696_bearing_outer_diameter/2+888_2016_connector_width+7,  0])
            rotate([0, 90, 0])
                cylinder(d=M6_screw_diameter, h=200, $fn=20, center=true);
    }
}

888_2016();
