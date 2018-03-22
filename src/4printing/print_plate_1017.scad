include <../../Parameters.scad>

use <../666_1017.scad>

difference(){
    rotate([0,90,0])
        666_1017();
    translate([-50,-50,0])
        cube(150);
}