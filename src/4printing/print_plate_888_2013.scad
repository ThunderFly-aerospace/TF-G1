include <../../parameters.scad>
use <../888_2013.scad>


difference(){
    union(){
        rotate([0, 0, 0])
            888_2013(0, rotate = 1, left = 1);
        translate([-35, 0, 0])
            rotate([0, 0, 0])
                888_2013(1, rotate = 1, left = 1);
        translate([0, -25, 0])
            rotate([0, 0, 180])
                888_2013(0, rotate = 1, left = 0);
        translate([-35, -25, 0])
            rotate([0, 0, 180])
                888_2013(1, rotate = 1, left = 0);
    }

    translate([0, 0, -250-30])
        cube(500, center = true);
}
