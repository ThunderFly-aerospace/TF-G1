include <../../parameters.scad>

rod = 3.3;
diameter = 10;
height = 20;
wall = 1.5;

module 888_4002_body(){

    difference(){
        union(){
            cube([2*wall + rod, diameter, height], center = true);
            translate([0, 0, height/2])
                rotate([0, 90, 0])
                    cylinder(d = diameter, h = 2*wall + rod, center=true);
            translate([0, (diameter)/2, 0])
                cylinder(d = rod+wall*2, h = height, center = true, $fn = 40);
        }

        translate([0, (diameter)/2, 0])
            cylinder(d = rod, h = height+1, center = true, $fn = 40);

        translate([0, 0, height/2])
          rotate([90, 0, 90])
            rotate_extrude(angle = 180)
                #translate([diameter/2, 0, 0])
                    circle(d = rod, $fn = 40);
    }

}


888_4002_body();
