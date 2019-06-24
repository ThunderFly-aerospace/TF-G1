include <../../parameters.scad>

use <../666_1017.scad>

difference(){
    rotate([0,90,0])
        666_1017(draft = false);
    translate([-50,-50,0])
        cube(150);
}

translate([0, 50, 0])

    difference(){
        rotate([0,90,0])
            666_1017(draft = false);
        translate([-50,-50,0])
            cube(150);
    }