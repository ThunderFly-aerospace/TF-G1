include <../../parameters.scad>
use <../888_2013.scad>


//translate([0, 0, 50])
//    rotate([0, 90, 0])
//        888_2013(true);

rotate([0, 0, 0])
    888_2013(false, rotate = 1);

translate([-35, 0, 0])
    rotate([0, 0, 0])
        888_2013(true, rotate = 1);
/*
mirror([0, 1, 0]) translate([0, 25, 0]){
        rotate([0, 0, 0])
            888_2013(false, rotate = 1);

        translate([-35, 0, 0])
            rotate([0, 0, 0])
                888_2013(true, rotate = 1);
    } */
