include <../../parameters.scad>
use <../888_2013.scad>


difference(){
    union(){
        translate([10, 0, 0])
            888_2013(rotate = 1, left = 1);
        translate([-60, 0, 0])
            rotate([0, 0, 0])
                888_2013(rotate = 1, left = 1);
        translate([50, -40, 0])
            rotate([0, 0, 180])
                888_2013(rotate = 1, left = 0);
        translate([-20, -40, 0])
            rotate([0, 0, 180])
                888_2013(rotate = 1, left = 0);
    }
}
