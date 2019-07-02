include <../../parameters.scad>
use <../888_2013.scad>


translate([0, 0, 888_2013_width/2]){

    rotate([0, 90, 0])
        888_2013();

    mirror([0, 1, 0])
        rotate([0, 90, 0])
            888_2013();

}
