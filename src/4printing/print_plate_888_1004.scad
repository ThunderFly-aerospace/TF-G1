include <../../parameters.scad>

use <../888_1004.scad>

draft = false;

for (i=[1:len(beam_division)]) {

    translate([(i-0.7)*(beam_thickness+2), 0, 0])
        rotate([0, -90, 0])
            intersection(){
                translate([-beam_division[i-1], 0, 0])
                    888_1004();
                translate([0, -50, -50])
                    cube([beam_division[i]-beam_division[i-1], 100, 100]);

            }

}
