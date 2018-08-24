include <../../Parameters.scad>

use <../888_2003.scad>

difference(){
    rotate([0,90,0])
        888_2003(draft=false);
    translate([-50,-50,0])
        cube(150);
}

